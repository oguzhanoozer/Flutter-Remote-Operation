import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../ui/screens/container/model/container_model.dart';
import '../../../../ui/widgets/text_on_image.dart';
import '../../../exceptions/api_exception.dart';
import '../../../models/result.dart';
import '../../../models/rx.dart';
import '../../../utils/app_logger.dart';

const double _markerSize = 150;

const int _pageLimit = 10;
const String docName = 'containers';
const String orderByName = 'sensor_id';

class ContainerClient {
  static final ContainerClient _singleton = ContainerClient._internal();

  factory ContainerClient() {
    return _singleton;
  }

  ContainerClient._internal() {
    _init();
  }

  DocumentSnapshot? _lastDocument;
  Query<Map<String, dynamic>>? pageQuery;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  final Rx<List<ContainerModel>> containerList = Rx<List<ContainerModel>>(<ContainerModel>[]);
  bool _hasMoreData = true;

  void _init() {
    pageQuery = firestoreInstance.collection(docName).orderBy(orderByName).limit(_pageLimit);
  }

  Future<Result<List<ContainerModel>, ApiException>> fetch() async {
    final List<ContainerModel> containerList = <ContainerModel>[];

    if (!_hasMoreData || pageQuery == null) {
      return Success(containerList);
    }
    try {
      await pageQuery!.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotList = snapshot.docs;

        if (snapshotList.isNotEmpty) {
          await Future.forEach<QueryDocumentSnapshot<Map<String, dynamic>>>(snapshotList, (QueryDocumentSnapshot<Map<String, dynamic>> item) async {
            final ContainerModel model = ContainerModel.fromJson(item.data());

            await createMarkerIcon(model.fullness_rate, isRelocated: model.is_relocated.value).then((BitmapDescriptor icon) => model.icon(set: () => icon));
            containerList.add(model);
          });
          _lastDocument = snapshot.docs.last;
          _hasMoreData = snapshotList.length == _pageLimit;

          pageQuery = firestoreInstance.collection(docName).orderBy(orderByName).startAfterDocument(_lastDocument!).limit(_pageLimit);
        }
      });
      return Success(containerList);
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<Result<bool, ApiException>> updateMarkerPosition(ContainerModel model, LatLng position) async {
    try {
      final CollectionReference containerRef = firestoreInstance.collection(docName);

      containerRef.doc(model.sensor_id.toString()).update(<Object, Object?>{
        'location': GeoPoint(
          position.latitude,
          position.longitude,
        ),
        'is_relocated': true,
      }).then((_) => AppLogger.debug('Container Data Updated'));

      await createMarkerIcon(model.fullness_rate, isRelocated: true).then((BitmapDescriptor icon) {
        model.icon(set: () => icon);
      });

      final GeoPoint location = GeoPoint(position.latitude, position.longitude);
      model.location(set: () => location);
      model.is_relocated(set: () => true);
      return const Success(true);
    } catch (e) {
      return Failure(ApiException.from(e));
    }
  }

  Future<BitmapDescriptor> createMarkerIcon(int fullnessRate, {bool isRelocated = false}) async {
    return await TextOnImage(
      isRelocated: isRelocated,
      text: fullnessRate.toString(),
    ).toBitmapDescriptor(logicalSize: const Size(_markerSize, _markerSize), imageSize: const Size(_markerSize, _markerSize));
  }
}
