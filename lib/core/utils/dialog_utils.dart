import 'package:flutter/material.dart';

import '../../ui/dialogs/app_dialog.dart';
import '../configs/constants/app_icons.dart';
import '../configs/constants/app_size.dart';
import '../configs/constants/app_strings.dart';
import '../configs/theme/app_colors.dart';
import '../configs/theme/app_text_styles.dart';

abstract final class DialogUtils {
  static Future<void> showMarkerTopDialog(
    BuildContext? context, {
    Widget? messageWidget,
    void Function()? onApply,
    void Function()? onSecondaryApply,
  }) {
    return AppDialog(
      message: '',
      messageWidget: messageWidget,
      primaryButtonText: AppStrings.navigate,
      secondaryButtonText: AppStrings.relocate,
      onTapPrimaryButton: onApply,
      onTapSecondaryButton: onSecondaryApply,
    ).show(context);
  }

  static Future<void> showSavedLocationSuccess(
    BuildContext? context, {
    Widget? messageWidget,
  }) {
    return AppDialog(
      message: '',
      messageWidget: Text(
        AppStrings.savedLocation,
        style: AppTextStyles.body1_medium(
          color: AppColors.darkGray,
          fontWeight: FontWeight.w400,
        ),
      ),
      isBottomDialog: true,
    ).show(context);
  }

  static Future<void> showSaveLocationWarning(
    BuildContext? context, {
    Widget? messageWidget,
    void Function()? onApply,
  }) {
    return AppDialog(
      message: '',
      messageWidget: Text(
        AppStrings.saveLocation,
        style: AppTextStyles.body1_medium(
          color: AppColors.darkGray,
          fontWeight: FontWeight.w400,
        ),
      ),
      primaryButtonText: AppStrings.save,
      onTapPrimaryButton: onApply,
    ).show(context);
  }

  static Future<void> showErrorDialog(
    BuildContext? context, {
    required String message,
  }) {
    return AppDialog(
      message: '',
      messageWidget: Padding(
        padding: const EdgeInsets.only(right: AppSize.paddingLow, top: AppSize.padding, bottom: AppSize.padding),
        child: Row(
          children: <Widget>[
            AppIcons.error(size: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.body1_medium(
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray,
                ),
              ),
            ),
          ],
        ),
      ),
      isBottomDialog: true,
    ).show(context);
  }
}
