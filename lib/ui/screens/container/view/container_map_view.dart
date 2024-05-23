import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/configs/constants/app_strings.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_text_styles.dart';
import '../../../../core/models/rx.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../model/container_model.dart';

class ContainerMapView extends StatefulWidget {
  final Rx<List<ContainerModel>> containerList;
  final void Function(ContainerModel model, LatLng position) onDragPositionUpdate;
  final void Function(LatLng position) onTapMap;

  const ContainerMapView({
    super.key,
    required this.containerList,
    required this.onDragPositionUpdate,
    required this.onTapMap,
  });

  @override
  State<ContainerMapView> createState() => _ContainerMapViewState();
}

class _ContainerMapViewState extends State<ContainerMapView> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  CameraPosition initialValue = const CameraPosition(target: LatLng(39.9334, 32.8597), zoom: 5.0);
  bool isDraggable = false;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      markers: <Marker>{
        ...widget.containerList.value.map((ContainerModel model) {
          return Marker(
            icon: switch (model.icon.value == null) {
              true => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              false => model.icon.value!,
            },
            onDragEnd: (LatLng value) {
              DialogUtils.showSaveLocationWarning(
                context,
                onApply: () {
                  model.location(
                    set: () => GeoPoint(value.latitude, value.longitude),
                  );
                  setState(() {
                    isDraggable = false;
                  });
                  widget.onDragPositionUpdate(model, value);
                  DialogUtils.showSavedLocationSuccess(context);
                },
              );
            },
            draggable: isDraggable,
            markerId: MarkerId(model.sensor_id.toString()),
            position: LatLng(model.location.value.latitude, model.location.value.longitude),
            onTap: () async {
              await DialogUtils.showMarkerTopDialog(
                context,
                messageWidget: markerInformation(model),
                onSecondaryApply: () {
                  isDraggable = true;
                  setState(() {});
                },
                onApply: () {
                  widget.onTapMap.call(LatLng(model.location.value.latitude, model.location.value.longitude));
                },
              );
            },
          );
        }),
      },
      mapType: MapType.normal,
      initialCameraPosition: initialValue,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Text titleText(String title) {
    return Text(
      title,
      style: AppTextStyles.body1_medium(
        color: AppColors.darkBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text bodyText(String body) {
    return Text(
      body,
      style: AppTextStyles.body1_medium(
        color: AppColors.darkGray,
      ),
    );
  }

  Widget markerInformation(ContainerModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model.name,
          style: AppTextStyles.body1_high(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
        titleText(AppStrings.fullnessRate),
        bodyText('%${model.fullness_rate}'),
        titleText(AppStrings.temperature),
        bodyText('%${model.temperature}'),
        titleText(AppStrings.sensorId),
        bodyText('%${model.sensor_id}'),
      ],
    );
  }
}
