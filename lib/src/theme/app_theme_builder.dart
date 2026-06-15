import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'solar_theme_extension.dart';

class AppThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme, Brightness brightness)? builder;
  final Widget? child;
  final ThemeMode themeMode;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;

  const AppThemeBuilder({
    super.key,
    this.builder,
    this.child,
    this.themeMode = ThemeMode.system,
    this.lightTheme,
    this.darkTheme,
  });

  factory AppThemeBuilder.auto({
    required Widget child,
    ThemeMode themeMode = ThemeMode.system,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) =>
      AppThemeBuilder(
        child: child,
        themeMode: themeMode,
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      );

  @override
  Widget build(BuildContext context) {
    final brightness = themeMode == ThemeMode.system
        ? ui.PlatformDispatcher.instance.platformBrightness
        : themeMode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light;

    final isDark = brightness == Brightness.dark;
    final theme = isDark
        ? (darkTheme ?? _defaultDarkTheme)
        : (lightTheme ?? _defaultLightTheme);

    if (builder != null) {
      return builder!(context, theme, brightness);
    }

    return Theme(
      data: theme,
      child: child!,
    );
  }

  static ThemeData get _defaultLightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        extensions: const [SolarThemeExtension.defaultLight],
      );

  static ThemeData get _defaultDarkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: const [SolarThemeExtension.defaultDark],
      );
}
