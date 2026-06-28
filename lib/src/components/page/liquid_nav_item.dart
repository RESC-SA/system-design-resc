import 'package:flutter/widgets.dart';

/// Model for a single navigation item.
@immutable
class LiquidNavItem {
  const LiquidNavItem({
    required this.icon,
    this.activeIcon,
    this.inactiveIcon,
    this.label,
    this.semanticLabel,
    this.colorIconNavBar,
    this.colorSelected,
    this.colorUnselected,
    this.labelStyle,
  });

  final IconData icon;
  final IconData? activeIcon;
  final IconData? inactiveIcon;
  final String? label;
  final String? semanticLabel;
  final Color? colorIconNavBar;
  final Color? colorSelected;
  final Color? colorUnselected;
  final TextStyle? labelStyle;
}
