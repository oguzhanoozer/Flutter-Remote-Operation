import 'package:flutter/material.dart';

import '../../core/configs/constants/app_size.dart';

///import '../../core/utils/app_analytics.dart';
import 'gesture_detector.dart';

final class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.size = AppSize.iconButtonSize,
    this.hasOpacityAnimation = true,
  });

  final Widget icon;
  final void Function()? onTap;
  final Color backgroundColor;
  final double size;
  final bool hasOpacityAnimation;

  bool get isTransparent => backgroundColor == Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: switch (onTap) {
        final void Function() onTap => () {
            onTap();
          },
        _ => null,
      },
      hasOpacityAnimation: hasOpacityAnimation,
      child: Material(
        color: backgroundColor,
        elevation: isTransparent ? 0 : AppSize.iconButtonElevation,
        shape: isTransparent ? const RoundedRectangleBorder() : const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: icon,
          ),
        ),
      ),
    );
  }
}
