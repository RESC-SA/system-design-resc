import 'package:flutter/material.dart';

/// Design system button component
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.size = AppButtonSize.md,
    this.expanded = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final AppButtonVariant variant;
  final IconData? icon;
  final IconPosition iconPosition;
  final AppButtonSize size;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final effectiveIcon = icon;

    final button = ElevatedButton(
      onPressed: onPressed,
      style: _getStyle(colors),
      child: _buildContent(effectiveIcon),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _buildContent(IconData? icon) {
    if (icon == null) return child;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPosition == IconPosition.start) ...[
          Icon(icon, size: _iconSize),
          const SizedBox(width: 8),
        ],
        child,
        if (iconPosition == IconPosition.end) ...[
          const SizedBox(width: 8),
          Icon(icon, size: _iconSize),
        ],
      ],
    );
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.sm:
        return 16;
      case AppButtonSize.md:
        return 20;
      case AppButtonSize.lg:
        return 24;
    }
  }

  ButtonStyle _getStyle(ColorScheme colors) {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      case AppButtonVariant.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      case AppButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: colors.primary,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      case AppButtonVariant.tonal:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }
}

enum AppButtonVariant { primary, secondary, outlined, text, tonal }

enum AppButtonSize { sm, md, lg }

enum IconPosition { start, end }

/// Icon-only button
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = AppButtonSize.md,
    this.variant = AppButtonVariant.primary,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final AppButtonSize size;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final iconSize = switch (size) {
      AppButtonSize.sm => 20.0,
      AppButtonSize.md => 24.0,
      AppButtonSize.lg => 32.0,
    };
    final buttonSize = switch (size) {
      AppButtonSize.sm => 36.0,
      AppButtonSize.md => 48.0,
      AppButtonSize.lg => 56.0,
    };

    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize),
      iconSize: iconSize,
      style: _getStyle(colors),
      constraints: BoxConstraints(
        minWidth: buttonSize,
        minHeight: buttonSize,
      ),
    );
  }

  ButtonStyle? _getStyle(ColorScheme colors) {
    switch (variant) {
      case AppButtonVariant.primary:
        return IconButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        );
      case AppButtonVariant.secondary:
        return IconButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
        );
      case AppButtonVariant.outlined:
        return IconButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
        );
      case AppButtonVariant.text:
        return IconButton.styleFrom(
          foregroundColor: colors.primary,
        );
      case AppButtonVariant.tonal:
        return IconButton.styleFrom(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
        );
    }
  }
}
