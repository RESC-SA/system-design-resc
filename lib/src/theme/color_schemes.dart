import 'package:flutter/material.dart';

/// Material Design 3 color schemes for the design system
class AppColorSchemes {
  AppColorSchemes._();

  /// Light color scheme
  static const ColorScheme light = ColorScheme.light(
    primary: Color(0xFF52bc49),
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFFb8ffaf),
    onPrimaryContainer: Color(0xFF000000),
    
    secondary: Color(0xFFffffff),
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFFffffff),
    onSecondaryContainer: Color(0xFF000000),
    
    tertiary: Color(0xFFf0f5f0),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFFffffff),
    onTertiaryContainer: Color(0xFF000000),
    
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1C1B1F),
    
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    
    outline: Color(0xFF79747E),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  /// Dark color scheme
  static const ColorScheme dark = ColorScheme.dark(
    primary: Color(0xFF52bc49),
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFF067000),
    onPrimaryContainer: Color(0xFFffffff),
    
    secondary: Color(0xFFffffff),
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFFb3b3b3),
    onSecondaryContainer: Color(0xFF000000),
    
    tertiary: Color(0xFFf0f5f0),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFFa3a9a3),
    onTertiaryContainer: Color(0xFF000000),
    
    surface: Color(0xFF0F0F0F),
    onSurface: Color(0xFFE6E1E5),
    
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    
    outline: Color(0xFF938F99),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
