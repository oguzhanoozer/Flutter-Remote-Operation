import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

const String fontFamily = 'OpenSans';

enum AppTextStyles {
  button(fontSize: 20, color: AppColors.lightColor, fontWeight: FontWeight.w800), //* H3 */
  title(fontSize: 16, color: AppColors.darkGray, fontWeight: FontWeight.w400), //* T1 InputBox Label Deactive */

  body1_low(fontSize: 12, color: AppColors.shadow, fontWeight: FontWeight.w400), //* Input Box Label Color */
  body1_medium(fontSize: 16, color: AppColors.shadow),
  body1_high(fontSize: 20, color: AppColors.darkGray, fontWeight: FontWeight.w400), //* button text*/
  title_high(fontSize: 28, color: AppColors.onSurfaceHigh, fontWeight: FontWeight.w800);

  final int fontSize;
  final Color color;
  final FontWeight fontWeight;

  const AppTextStyles({
    required this.fontSize,
    this.color = AppColors.onSurfaceMedium,
    this.fontWeight = FontWeight.normal,
  });

  TextStyle call({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.toDouble(),
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle,
    );
  }
}
