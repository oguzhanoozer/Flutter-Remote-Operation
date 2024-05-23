import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_size.dart';

enum AppIcons {
  battery_bin(),
  clear(),
  error(),
  house_hold(),
  logo(),
  password(),
  password_yellow();

  String get _path => 'assets/icons/$name.png';

  Widget call({
    double size = AppSize.icon,
    Color color = AppColors.icon,
    bool applyColorFilter = true,
    BoxFit? fit = BoxFit.contain,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        _path,
        fit: fit,
      ),
    );
  }
}
