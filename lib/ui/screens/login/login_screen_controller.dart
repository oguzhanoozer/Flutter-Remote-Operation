import '../../../../core/models/result.dart';
import '../../../../core/routing/app_navigation.dart';
import '../../../../core/services/auth/auth_service.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../../core/models/rx.dart';
import '../../../core/services/base_service.dart';
import '../base_screen_controller.dart';

final class LoginScreenController extends BaseScreenController {
  final Service<AuthService> _authService;
  String username = '';
  String password = '';

  LoginScreenController(this._authService);

  Rx<bool> isError = Rx<bool>(false);
  Rx<bool> buttonEnabled = Rx<bool>(false);

  bool get isUserTextsEmpty => username.isEmpty || password.isEmpty;

  void checkButtonEnabled() {
    if (isUserTextsEmpty) {
      buttonEnabled(set: () => false);
    } else {
      buttonEnabled(set: () => true);
    }
  }

  void onTapLoginButton() async {
    viewState.setBusy(true);
    await _authService().login(username: username, password: password).then(
      (Result<Nothing, ApiException> result) {
        result.on(
          success: (_) {
            AppNavigation.goToContainerScreen(context());
          },
          failure: (ApiException e) {
            isError(set: () => true);
            buttonEnabled(set: () => false);
            DialogUtils.showErrorDialog(context(), message: e.message);
          },
        );
      },
    );
    viewState.setBusy(false);
  }
}
