import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_theme.dart';

/// Main theme configuration for the design system
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: AppColorSchemes.light,
      textTheme: AppTextTheme.textTheme,
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorSchemes.light.primary,
        foregroundColor: AppColorSchemes.light.onPrimary,
        elevation: 4,
        centerTitle: false,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorSchemes.light.primary,
          foregroundColor: AppColorSchemes.light.onPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(64, 40),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColorSchemes.light.surface,
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: AppColorSchemes.dark,
      textTheme: AppTextTheme.textTheme,
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorSchemes.dark.surface,
        foregroundColor: AppColorSchemes.dark.onSurface,
        elevation: 4,
        centerTitle: false,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorSchemes.dark.primary,
          foregroundColor: AppColorSchemes.dark.onPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(64, 40),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColorSchemes.dark.surface,
        margin: const EdgeInsets.all(8),
      ),
    );
  }
}
