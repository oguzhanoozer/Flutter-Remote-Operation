import 'package:flutter/material.dart';

abstract final class AppColors {
  // Base colors
  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color surface = Color.fromARGB(255, 242, 242, 242);
  static const Color primary = Color.fromARGB(255, 47, 172, 219);
  static const Color onPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color onSurfaceHigh = Color.fromARGB(255, 13, 13, 13);
  static const Color onSurfaceMedium = Color.fromARGB(255, 89, 89, 89);
  static const Color onSurfaceLow = Color.fromARGB(255, 128, 128, 128);

  static const Color icon = onSurfaceMedium;

  static const Color disabledButtonForeground = Color.fromARGB(255, 170, 170, 170);

  // Other colors

  static const Color border = Color.fromARGB(255, 225, 225, 225);
  static const Color shadowGreen = Color.fromARGB(255, 114, 200, 117);
  static const Color shadow = Color.fromARGB(255, 187, 187, 187);
  static const Color error = Color.fromARGB(255, 252, 49, 49);
  static const Color darkBlue = Color.fromARGB(255, 23, 44, 73);
  static const Color yellow = Color.fromARGB(255, 233, 207, 48);
  static const Color darkGray = Color.fromARGB(255, 83, 90, 114);
  static const Color lightColor = Color.fromARGB(255, 251, 252, 255);
  static const Color green = Color.fromARGB(255, 59, 169, 53);
}
