import 'package:flutter/material.dart';

/// Design system card component
class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.child,
    this.onTap,
    this.elevation,
    this.margin,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: elevation ?? 2,
      margin: margin ?? const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
