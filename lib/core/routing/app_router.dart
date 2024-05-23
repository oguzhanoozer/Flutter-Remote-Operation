import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../ui/screens/container/view/container_screen_view.dart';
import '../../ui/screens/login/login_screen_view.dart';
import '../../ui/screens/splash/splash_screen_view.dart';
import 'app_navigation.dart';
import 'guards/auth_guards.dart';
import 'observers/navigation_observer.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({
    required super.navigatorKey,
  });

  @override
  List<AutoRoute> routes = <AutoRoute>[
    RedirectRoute(path: '/', redirectTo: '/splash'),
    AutoRoute(
      path: '/splash',
      page: SplashScreenRoute.page,
      fullscreenDialog: true,
      type: const RouteType.custom(
        transitionsBuilder: TransitionsBuilders.noTransition,
      ),
    ),
    AutoRoute(path: '/login', page: LoginScreenRoute.page),
    AutoRoute(
      path: '/container',
      page: ContainerScreenRoute.page,
      fullscreenDialog: true,
      guards: <AutoRouteGuard>[
        AuthGuard(),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/unknown'),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  RouterConfig<UrlState> get routerConfig {
    return super.config(
      deepLinkBuilder: (PlatformDeepLink deepLink) {
        return DeepLink.defaultPath;
      },
      navigatorObservers: () {
        return <NavigatorObserver>[
          NavigationObserver(),
        ];
      },
    );
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    AppNavigation.unFocus();
    resolver.next();
  }
}
