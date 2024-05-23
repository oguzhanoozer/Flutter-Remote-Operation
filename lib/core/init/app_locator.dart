import 'package:get_it/get_it.dart';

import '../../ui/screens/base_screen_controller.dart';
import '../../ui/screens/container/viewmodel/container_screen_view_model.dart';
import '../../ui/screens/login/login_screen_controller.dart';
import '../../ui/screens/splash/splash_screen_controller.dart';
import '../services/auth/auth_service.dart';
import '../services/base_service.dart';
import '../services/network/network_manager_service.dart';

abstract final class AppLocator {
  static Future<void> initControllers() async {
    await ControllerLocator._init();
  }

  static Future<void> initServices() async {
    await ServiceLocator._init();
  }
}

abstract final class ControllerLocator {
  static final GetIt _locator = GetIt.asNewInstance();
  static final Map<String, dynamic> _controllers = <String, dynamic>{};

  static Future<void> _init() async {
    await _locator.reset(dispose: true);
    _controllers.clear();
    _register();
  }

  static void _register() {
    void registerController<C extends BaseScreenController>(
      C Function() factroryFunc, {
      String? instanceName,
    }) {
      _locator.registerFactoryParam(
        (_, __) => factroryFunc(),
        instanceName: instanceName,
      );
    }

    registerController<LoginScreenController>(
      () => LoginScreenController(
        () => ServiceLocator.get<AuthService>(),
      ),
    );

    registerController<SplashScreenController>(
      () => SplashScreenController(
        () => ServiceLocator.get<AuthService>(),
        () => ServiceLocator.get<NetworkManagerService>(),
      ),
    );

    registerController<ContainerScreenController>(
      () => ContainerScreenController(),
    );
  }

  static String _getControllerKey<C extends BaseScreenController>(int hashCode) {
    return '$hashCode-$C';
  }

  static C get<C extends BaseScreenController>(int hashCode) {
    return _controllers[_getControllerKey<C>(hashCode)];
  }

  static C create<C extends BaseScreenController>(int hashCode) {
    return _controllers.putIfAbsent(
      _getControllerKey<C>(hashCode),
      () => _locator.get<C>(),
    );
  }

  static void dispose<C extends BaseScreenController>(int hashCode) {
    get<C>(hashCode).onDispose();
    _controllers.remove(_getControllerKey<C>(hashCode));
  }
}

abstract final class ServiceLocator {
  static final GetIt _locator = GetIt.asNewInstance();

  static Future<void> _init() async {
    await _locator.reset(dispose: true);
    _register();
    await _locator.allReady();
  }

  static void _register() {
    void registerService<S extends BaseService<S>>(
      S Function() getInstance, {
      String? instanceName,
      Iterable<Type>? dependsOn,
    }) {
      _locator.registerSingletonAsync<S>(
        () => getInstance().init(),
        instanceName: instanceName,
        dependsOn: dependsOn,
        dispose: (S instance) => instance.dispose(),
      );
    }

    registerService<AuthService>(
      () => const AuthService(),
    );

    registerService<NetworkManagerService>(
      () => NetworkManagerService(),
    );
  }

  static T get<T extends Object>() => _locator.get<T>();
}
