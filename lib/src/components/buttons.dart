import 'package:flutter/material.dart';

/// Custom button component for the design system
class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.variant = AppButtonVariant.primary,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(colors),
      child: child,
    );
  }

  ButtonStyle _getButtonStyle(ColorScheme colors) {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
        );
    }
  }
}

enum AppButtonVariant { primary, secondary }
