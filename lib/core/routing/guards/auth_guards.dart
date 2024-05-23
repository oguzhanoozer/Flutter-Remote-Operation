import 'package:auto_route/auto_route.dart';

import '../../init/app_locator.dart';
import '../../services/auth/auth_service.dart';
import '../app_router.dart';

final class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final bool isAuthenticated = await ServiceLocator.get<AuthService>().isAuthenticated();
    if (isAuthenticated) {
      resolver.next(true);
    } else {
      router.push(const LoginScreenRoute());
    }
  }
}
