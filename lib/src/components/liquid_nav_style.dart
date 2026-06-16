import 'package:flutter/material.dart';

@immutable
class LiquidNavStyle {
  const LiquidNavStyle({
    this.backgroundColor = const Color(0x00000000),
    this.containerColor = const Color(0xFFF7F7F8),
    this.liquidColor = const Color(0xFF2D6BFF),
    this.activeIconColor = const Color(0xFFFFFFFF),
    this.inactiveIconColor = const Color(0xFF6B7280),
    this.border,
    this.borderSide = const BorderSide(color: Color(0x12000000), width: 0.8),
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
    this.boxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 18,
        offset: Offset(0, 6),
      ),
    ],
    this.labelStyle,
    this.activeLabelStyle,
    this.showLabel = false,
    this.blurSigma,
  });

  final Color backgroundColor;
  final Color containerColor;
  final Color liquidColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Border? border;
  final BorderSide? borderSide;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow> boxShadow;
  final TextStyle? labelStyle;
  final TextStyle? activeLabelStyle;
  final bool showLabel;

  /// Optional glass effect blur. Set null or 0 to disable.
  final double? blurSigma;

  Border? resolveBorder() {
    if (border != null) return border;
    if (borderSide != null) return Border.fromBorderSide(borderSide!);
    return null;
  }

  LiquidNavStyle copyWith({
    Color? backgroundColor,
    Color? containerColor,
    Color? liquidColor,
    Color? activeIconColor,
    Color? inactiveIconColor,
    Border? border,
    BorderSide? borderSide,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    TextStyle? labelStyle,
    TextStyle? activeLabelStyle,
    bool? showLabel,
    double? blurSigma,
  }) {
    return LiquidNavStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      containerColor: containerColor ?? this.containerColor,
      liquidColor: liquidColor ?? this.liquidColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
      border: border ?? this.border,
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      labelStyle: labelStyle ?? this.labelStyle,
      activeLabelStyle: activeLabelStyle ?? this.activeLabelStyle,
      showLabel: showLabel ?? this.showLabel,
      blurSigma: blurSigma ?? this.blurSigma,
    );
  }
}
