import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/widgets/navigator.dart';

import '../../utils/app_logger.dart';

final class NavigationObserver extends AutoRouteObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? routeName = route.settings.name;
    if (routeName != null) {}
    AppLogger.debug(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.debug(route.settings.name);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.debug(route.settings.name);
  }
}
