import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants/app_icons.dart';
import '../base_screen_view.dart';
import 'splash_screen_controller.dart';

@RoutePage<void>()
final class SplashScreenView extends BaseScreenView<SplashScreenController> {
  const SplashScreenView({
    super.key,
  }) : super(
          safeArea: const ScaffoldSafeArea(bottom: false),
        );

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

final class _SplashScreenViewState extends BaseScreenViewState<SplashScreenView, SplashScreenController> {
  @override
  Scaffold builder(BuildContext context, SplashScreenController controller) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SizedBox.expand(
            child: AppIcons.logo(fit: BoxFit.scaleDown),
          ),
        ],
      ),
    );
  }
}
