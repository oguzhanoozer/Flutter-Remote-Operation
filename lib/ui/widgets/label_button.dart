import 'package:flutter/material.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';
import '../../core/models/rx.dart';
import 'gesture_detector.dart';

const int _kMinColorLengthForGradient = 2;

final class CustomLabelButton extends StatelessWidget {
  const CustomLabelButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.isExpand = true,
    this.enabled = true,
    this.borderColor,
    Color foregroundColor = AppColors.green,
  }) : foregroundColor = enabled ? foregroundColor : AppColors.disabledButtonForeground;

  factory CustomLabelButton.text({
    Key? key,
    required String label,
    final void Function()? onTap,
    Color foregroundColor = AppColors.green,
  }) {
    return CustomLabelButton(
      key: key,
      label: label,
      onTap: onTap,
      isExpand: false,
      foregroundColor: foregroundColor,
    );
  }

  factory CustomLabelButton.cancel({
    Key? key,
    required String label,
    final void Function()? onTap,
    bool isExpand = true,
  }) {
    return CustomLabelButton(
      key: key,
      label: label,
      onTap: onTap,
      isExpand: isExpand,
    );
  }

  final String label;
  final AppIcons? icon;
  final void Function()? onTap;
  final bool isExpand;
  final bool enabled;
  final Color? borderColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final Decoration decoration = BoxDecoration(
      //shape: const StadiumBorder(),
      color: foregroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: AppColors.shadowGreen,
          spreadRadius: 0,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );

    final Widget buttonItem = Material(
      color: Colors.transparent,
      elevation: AppSize.labelButtonElevation,
      shape: StadiumBorder(
        side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
      ),
      child: Container(
        decoration: decoration,
        //padding: AppSize.labelButtonPadding,
        constraints: const BoxConstraints(
          minWidth: AppSize.labelButtonMinSize,
          minHeight: AppSize.labelButtonMinSize,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: AppTextStyles.button(),
              maxLines: AppSize.labelButtonMaxLines,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );

    return CustomGestureDetector(
        onTap: switch (enabled) {
          true => switch (onTap) {
              final void Function() onTap => () {
                  onTap();
                },
              _ => null,
            },
          false => null,
        },
        child: switch (isExpand) {
          true => SizedBox(
              height: 43,
              width: 340,
              child: buttonItem,
            ),
          false => buttonItem,
        });
  }
}
