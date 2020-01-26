import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';

// example appTheme() https://github.com/ConProgramming/flutter-example/blob/master/lib/theme/style.dart

ThemeData appTheme() {
  return ThemeData(
    primaryColor: themeColors["emoryBlue"],
    accentColor: themeColors["gold"],
  );
}
