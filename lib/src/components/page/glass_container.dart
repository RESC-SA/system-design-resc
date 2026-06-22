import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double border;
  final EdgeInsetsGeometry? padding;
  final double sigma;
  final Color? backgroundColor;
  final bool isGlass;
  final bool? isBorder;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.border = 1,
    this.padding,
    this.sigma = 8,
    this.backgroundColor,
    this.boxShadow,
    this.isGlass = true,
    this.isBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tint = isDark ? Colors.white10 : Colors.white60;
    final borderColor = isDark ? Colors.white12 : Colors.white38;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: isGlass ? BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? tint,
            borderRadius: BorderRadius.circular(borderRadius),
            border: isBorder ?? true ? Border.all(color: borderColor, width: border) : null,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ) : Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? tint,
          borderRadius: BorderRadius.circular(borderRadius),
          border: isBorder ?? true ? Border.all(color: borderColor, width: border) : null,
          boxShadow: boxShadow ?? [],
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      )
    );
  }
}
