import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'app_router.dart';

abstract final class AppNavigation {
  static final AppRouter _router = AppRouter(navigatorKey: rootNavigatorKey);
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

  static RouterConfig<Object> get routerConfig => _router.routerConfig;

  static void unFocus([UnfocusDisposition disposition = UnfocusDisposition.scope]) {
    FocusManager.instance.primaryFocus?.unfocus(
      disposition: disposition,
    );
  }

  static Future<void> popRoute<T>(BuildContext? context, [T? result]) async {
    await context?.popRoute<T>(result);
  }

  static void goToSplashScreen(BuildContext? context) {
    (context ?? rootNavigatorKey.currentContext)?.router.replaceAll(
      <PageRouteInfo>[SplashScreenRoute()],
      updateExistingRoutes: false,
    );
  }

  static void goToContainerScreen(BuildContext? context) {
    context?.router.replaceAll(<PageRouteInfo>[ContainerScreenRoute()]);
  }

  static void goToLoginScreen(BuildContext? context) {
    context?.router.replaceAll(<PageRouteInfo>[LoginScreenRoute()]);
  }
}
