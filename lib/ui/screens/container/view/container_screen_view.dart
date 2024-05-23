import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/models/rx.dart';
import '../../../widgets/obx.dart';
import '../../base_screen_view.dart';
import '../model/container_model.dart';
import '../viewmodel/container_screen_view_model.dart';
import 'container_map_view.dart';

@RoutePage<void>()
final class ContainerScreenView extends BaseScreenView<ContainerScreenController> {
  const ContainerScreenView({
    super.key,
  }) : super(
          safeArea: const ScaffoldSafeArea(bottom: false),
        );

  @override
  State<ContainerScreenView> createState() => _ContainerScreenViewState();
}

final class _ContainerScreenViewState extends BaseScreenViewState<ContainerScreenView, ContainerScreenController> {
  @override
  Scaffold builder(BuildContext context, ContainerScreenController controller) {
    return Scaffold(
      body: Obx(
        controller.containerList,
        builder: (BuildContext context, Rx<List<ContainerModel>> list, _) {
          return ContainerMapView(
            containerList: controller.containerList,
            onDragPositionUpdate: (ContainerModel model, LatLng position) {
              controller.updateMarkerPosition(model, position);
            },
            onTapMap: (LatLng position) {
              controller.onTapMap(position);
            },
          );
        },
      ),
    );
  }
}
