import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static const ThemeMode themeMode = ThemeMode.light;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    hintColor: AppColors.onSurfaceLow,
    fontFamily: fontFamily,
  );
}
