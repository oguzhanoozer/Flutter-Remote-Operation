import '../../../core/configs/constants/app_strings.dart';
import '../../../core/exceptions/base_exception.dart';
import '../../../core/init/app_locator.dart';
import '../../../core/routing/app_navigation.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/services/base_service.dart';
import '../../../core/services/network/network_manager_service.dart';
import '../../../core/utils/dialog_utils.dart';
import '../base_screen_controller.dart';

final class SplashScreenController extends BaseScreenController {
  final Service<AuthService> _authService;
  final Service<NetworkManagerService> _networkService;
  final Duration _minWaitDuration = const Duration(milliseconds: 2000);

  SplashScreenController(this._authService, this._networkService);

  @override
  Future<void> onInitState() async {
    super.onInitState();
    _handleInitialization();
  }

  Future<void> checkConnection() async {
    bool connectionChecked = false;
    _networkService().getConnectivityStatus().listen((bool connection) async {
      if (!connection && !connectionChecked) {
        connectionChecked = true;
        await DialogUtils.showErrorDialog(context(), message: AppStrings.noConnection).then((_) {
          connectionChecked = false;
        });
      }
    });
  }

  void _handleInitialization() async {
    try {
      await Future.wait<void>(
        <Future<void>>[
          Future<void>.delayed(_minWaitDuration),
          AppLocator.initServices(),
        ],
      );
      checkConnection();
      if (await _authService().isAuthenticated()) {
        AppNavigation.goToContainerScreen(context());
      } else {
        AppNavigation.goToLoginScreen(context());
      }
    } catch (e) {
      await DialogUtils.showErrorDialog(context(), message: BaseException.from(e).message);
      AppNavigation.goToSplashScreen(context());
    }
  }
}
