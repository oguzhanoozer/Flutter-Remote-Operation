import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/exceptions/api_exception.dart';
import '../../../../core/models/result.dart';
import '../../../../core/models/rx.dart';
import '../../../../core/services/api/clients/container_client.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../base_screen_controller.dart';
import '../model/container_model.dart';

const String docName = 'containers';
const String orderByName = 'sensor_id';

final class ContainerScreenController extends BaseScreenController {
  ContainerScreenController();

  final Rx<List<ContainerModel>> containerList = Rx<List<ContainerModel>>(<ContainerModel>[]);
  final Rx<bool> isDraggable = Rx<bool>(false);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    getDataClustering();
  }

  Future<void> getDataClustering() async {
    try {
      final Result<List<ContainerModel>, ApiException> result = await ContainerClient().fetch();
      result.on(
        success: (List<ContainerModel> list) {
          if (list.isNotEmpty) {
            containerList().addAll(list);
            containerList.refresh();
            getDataClustering();
          }
        },
        failure: (ApiException e) => throw e,
      );
    } catch (e) {
      DialogUtils.showErrorDialog(context(), message: e.toString());
    }
  }

  Future<void> updateMarkerPosition(ContainerModel model, LatLng position) async {
    try {
      final Result<bool, ApiException> result = await ContainerClient().updateMarkerPosition(model, position);
      result.on(
        success: (bool isUpdateSucceed) {
          if (isUpdateSucceed) {
            containerList.refresh();
          }
        },
        failure: (ApiException e) => throw e,
      );
    } catch (e) {
      DialogUtils.showErrorDialog(context(), message: e.toString());
    }
  }

  void onTapMap(LatLng position) async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}',
    );
    final bool canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
