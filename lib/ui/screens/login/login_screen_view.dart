import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/configs/constants/app_size.dart';
import '../../../../core/configs/constants/app_strings.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/constants/app_icons.dart';
import '../../../core/configs/theme/app_text_styles.dart';
import '../../../core/models/rx.dart';
import '../../widgets/label_button.dart';
import '../../widgets/obx.dart';
import '../../widgets/text_field.dart';
import '../base_screen_view.dart';
import 'login_screen_controller.dart';

const double _emptyHeight = 100;
const double _aspectRatio = 4;

@RoutePage<void>()
final class LoginScreenView extends BaseScreenView<LoginScreenController> {
  const LoginScreenView({
    super.key,
  }) : super(
          safeArea: const ScaffoldSafeArea(bottom: false),
        );

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

final class _LoginScreenViewState extends BaseScreenViewState<LoginScreenView, LoginScreenController> {
  final TextStyle textStyle = AppTextStyles.body1_high();

  @override
  Scaffold builder(BuildContext context, LoginScreenController controller) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(height: _emptyHeight),
              _buildLogo(
                alignment: Alignment.bottomCenter,
                aspectRatio: _aspectRatio,
                widthFactor: AppSize.loginSmallLogoWidthFactor,
                logo: AppIcons.logo(color: AppColors.error),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSize.paddingHigh),
                child: Text(AppStrings.enterUserInformation, style: textStyle),
              ),
              Expanded(
                child: Container(
                  color: AppColors.background.withOpacity(AppSize.loginBackgroundOpacity),
                  child: Obx(
                    controller.isError,
                    builder: (BuildContext context, Rx<bool> isError, _) {
                      return ListView(
                        padding: const EdgeInsets.all(AppSize.paddingHigh),
                        children: <Widget>[
                          CustomTextField(
                            isError: isError.value,
                            hintText: isError.value ? controller.username : AppStrings.userName,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              controller.username = value;
                              controller.checkButtonEnabled();
                            },
                          ),
                          const SizedBox(height: AppSize.padding),
                          CustomTextField(
                            hintText: AppStrings.password,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            onChanged: (String value) {
                              controller.password = value;
                              controller.checkButtonEnabled();
                            },
                            onSubmitted: (_) => controller.onTapLoginButton(),
                            isPasswordField: true,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSize.paddingHigh * 2),
                child: Obx(
                  controller.buttonEnabled,
                  builder: (BuildContext context, Rx<bool> buttonEnabled, _) => CustomLabelButton(
                    label: AppStrings.login,
                    onTap: buttonEnabled.value ? () => controller.onTapLoginButton() : null,
                    foregroundColor: buttonEnabled.value ? AppColors.green : AppColors.green.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo({
    required Alignment alignment,
    required double aspectRatio,
    required double widthFactor,
    required Widget logo,
  }) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Align(
        alignment: alignment,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            child: logo,
          ),
        ),
      ),
    );
  }
}
