import 'dart:async';

import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

import '../base_service.dart';

final class NetworkManagerService extends BaseService<NetworkManagerService> {
  late FlutterNetworkConnectivity _flutterNetworkConnectivity;

  @override
  Future<NetworkManagerService> init() async {
    super.init();

    _flutterNetworkConnectivity = FlutterNetworkConnectivity(
      isContinousLookUp: true,
      lookUpDuration: const Duration(seconds: 5),
      lookUpUrl: 'google.com',
    );
    getConnectivityStatus();
    initCheckConnectivity();
    return this;
  }

  Stream<bool> getConnectivityStatus() {
    return _flutterNetworkConnectivity.getInternetAvailabilityStream();
  }

  Future<void> initCheckConnectivity() async {
    await _flutterNetworkConnectivity.registerAvailabilityListener();
  }

  @override
  void dispose() {
    _flutterNetworkConnectivity.unregisterAvailabilityListener();
    super.dispose();
  }
}
