import 'package:flutter/widgets.dart';

enum LiquidIconType { iconData, image, svg }

/// Model for a single navigation item.
@immutable
class LiquidNavItem {
  final IconData? icon;

  final IconData? activeIcon;
  final IconData? inactiveIcon;
  final String? label;
  final String? semanticLabel;
  final Color? colorIconNavBar;
  final Color? colorSelected;
  final Color? colorUnselected;
  final TextStyle? labelStyle;
  final LiquidIconType iconType;
  final String? imagePath;
  final String? svgPath;
  final String? activeImagePath;
  final String? inactiveImagePath;
  const LiquidNavItem({
    this.icon,
    this.activeIcon,
    this.inactiveIcon,
    this.label,
    this.semanticLabel,
    this.colorIconNavBar,
    this.colorSelected,
    this.colorUnselected,
    this.labelStyle,
    this.iconType = LiquidIconType.iconData,
    this.imagePath,
    this.svgPath,
    this.activeImagePath,
    this.inactiveImagePath,
    
  });
}
