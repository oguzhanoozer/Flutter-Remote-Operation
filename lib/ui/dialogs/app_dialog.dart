import 'package:flutter/material.dart';

import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../widgets/label_button.dart';
import 'base_dialog.dart';

const double _kIconWidthFactor = 0.30;
const double _kIconVisibleRatio = 0.50;

final class AppDialog extends BaseDialog {
  AppDialog({
    super.key,
    super.routeName,
    this.isBottomDialog = false,
    this.icon,
    this.title,
    this.message,
    this.messageWidget,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.cancelButtonText,
    this.primaryButtonColors,
    this.onTapPrimaryButton,
    this.onTapSecondaryButton,
  });

  final bool isBottomDialog;
  final Widget? icon;
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final String? cancelButtonText;
  final List<Color>? primaryButtonColors;
  final void Function()? onTapPrimaryButton;
  final void Function()? onTapSecondaryButton;

  @override
  Widget builder(BuildContext context) {
    const EdgeInsets messagePadding = EdgeInsets.only(
      left: AppSize.paddingLow,
      right: AppSize.paddingLow,
      bottom: AppSize.paddingLow,
    );

    final Widget message = Padding(
      padding: messagePadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (messageWidget != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSize.padding,
                ),
                child: messageWidget,
              ),
          ],
        ),
      ),
    );

    final double width = MediaQuery.sizeOf(context).width;
    final double iconSize = icon == null ? 0 : width * _kIconWidthFactor;

    final Widget buttons = Row(
      children: <Widget>[
        if (primaryButtonText != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingLow),
              child: CustomLabelButton(
                isExpand: false,
                label: primaryButtonText!,
                onTap: () {
                  pop(context, () => onTapPrimaryButton?.call());
                },
              ),
            ),
          ),
        if (secondaryButtonText != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingLow),
              child: CustomLabelButton(
                isExpand: false,
                label: secondaryButtonText!,
                onTap: () => pop(context, () => onTapSecondaryButton?.call()),
              ),
            ),
          ),
        if (cancelButtonText != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingLow),
              child: CustomLabelButton(
                isExpand: false,
                label: cancelButtonText!,
                onTap: () => pop(context),
              ),
            ),
          ),
      ],
    );

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: isBottomDialog ? 500 : 400.0),
          child: Container(
            width: width,
            padding: const EdgeInsets.only(
              left: AppSize.padding,
              // top: (icon == null ? AppSize.padding : AppSize.paddingLow) + (iconSize * _kIconVisibleRatio),
              right: AppSize.padding,
              bottom: AppSize.padding,
            ),
            margin: EdgeInsets.only(
              top: iconSize * (1 - _kIconVisibleRatio),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.background,
              borderRadius: BorderRadius.circular(super.radius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: message,
                ),
                if (primaryButtonText != null || cancelButtonText != null)
                  const SizedBox(
                    height: AppSize.paddingLow,
                  ),
                buttons,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
