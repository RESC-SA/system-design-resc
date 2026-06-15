import 'package:flutter/material.dart';

import 'solar_theme_extension.dart';

extension AppColorsX on BuildContext {
  SolarThemeExtension get colors {
    final ext = Theme.of(this).extension<SolarThemeExtension>();
    if (ext != null) return ext;
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? SolarThemeExtension.defaultDark : SolarThemeExtension.defaultLight;
  }
}

extension ScaffoldBgX on BuildContext {
  Color get scaffoldBg => colors.scaffoldBg;
}

extension AppBrightnessX on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;
  bool get isDark => brightness == Brightness.dark;
  bool get isLight => brightness == Brightness.light;
}
