import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/theme_extensions.dart';

enum AppIconButtonVariant { standard, neon, glass, danger }

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double size;
  final double iconSize;
  final String? tooltip;
  final bool isLoading;
  final bool isCircle;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = AppIconButtonVariant.standard,
    this.size = 44,
    this.iconSize = 22,
    this.tooltip,
    this.isLoading = false,
    this.isCircle = true,
  });

  factory AppIconButton.neon({
    required IconData icon,
    VoidCallback? onPressed,
    double size = 44,
    double iconSize = 22,
    String? tooltip,
  }) =>
      AppIconButton(
        icon: icon,
        onPressed: onPressed,
        variant: AppIconButtonVariant.neon,
        size: size,
        iconSize: iconSize,
        tooltip: tooltip,
      );

  factory AppIconButton.danger({
    required IconData icon,
    VoidCallback? onPressed,
    double size = 44,
    double iconSize = 22,
    String? tooltip,
  }) =>
      AppIconButton(
        icon: icon,
        onPressed: onPressed,
        variant: AppIconButtonVariant.danger,
        size: size,
        iconSize: iconSize,
        tooltip: tooltip,
      );

  factory AppIconButton.glass({
    required IconData icon,
    VoidCallback? onPressed,
    double size = 44,
    double iconSize = 22,
    String? tooltip,
  }) =>
      AppIconButton(
        icon: icon,
        onPressed: onPressed,
        variant: AppIconButtonVariant.glass,
        size: size,
        iconSize: iconSize,
        tooltip: tooltip,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDisabled = onPressed == null || isLoading;

    Color bgColor;
    Color iconColor;
    var shadows = <BoxShadow>[];

    switch (variant) {
      case AppIconButtonVariant.neon:
        bgColor = colors.primary.withValues(alpha: 0.12);
        iconColor = colors.neonGreen;
        shadows = [
          BoxShadow(
            color: colors.neonGreen.withValues(alpha: 0.35),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ];
        break;
      case AppIconButtonVariant.glass:
        bgColor = colors.surface2.withValues(alpha: 0.4);
        iconColor = colors.neonCyan;
        break;
      case AppIconButtonVariant.danger:
        bgColor = colors.neonRed.withValues(alpha: 0.12);
        iconColor = colors.neonRed;
        break;
      default:
        bgColor = colors.surface2;
        iconColor = colors.textSecondary;
    }

    Widget button = Opacity(
      opacity: isDisabled ? 0.45 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius:
              BorderRadius.circular(isCircle ? size / 2 : 12),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bgColor,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircle
                  ? null
                  : BorderRadius.circular(12),
              border: variant == AppIconButtonVariant.glass
                  ? Border.all(
                      color: colors.border.withValues(alpha: 0.5),
                    )
                  : null,
              boxShadow: shadows,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: iconSize - 4,
                      height: iconSize - 4,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: iconColor,
                      ),
                    )
                  : Icon(icon, size: iconSize, color: iconColor),
            ),
          ),
        ),
      ),
    ).animate().scale(
          duration: 180.ms,
          curve: Curves.easeOut,
          begin: const Offset(1, 1),
        );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData? leadingIcon;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.leadingIcon,
  });

  factory AppTextButton.danger({
    required String text,
    VoidCallback? onPressed,
    IconData? leadingIcon,
  }) =>
      _DangerTextButton(
          text: text, onPressed: onPressed, leadingIcon: leadingIcon);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveColor = color ?? colors.primary;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: effectiveColor,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 16, color: effectiveColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: effectiveColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}

class _DangerTextButton extends AppTextButton {
  const _DangerTextButton({
    required super.text,
    super.onPressed,
    super.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppTextButton(
      text: text,
      onPressed: onPressed,
      color: colors.neonRed,
      leadingIcon: leadingIcon,
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? width;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final bool isLoading;
  final bool isFullWidth;

  const AppOutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.borderColor,
    this.textColor,
    this.isLoading = false,
    this.isFullWidth = true,
  });

  factory AppOutlineButton.danger({
    required String text,
    VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isFullWidth = true,
  }) =>
      _DangerOutlineButton(
        text: text,
        onPressed: onPressed,
        icon: icon,
        width: width,
        isFullWidth: isFullWidth,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDisabled = onPressed == null || isLoading;
    final effectiveBorder = borderColor ?? colors.primary;
    final effectiveText = textColor ?? colors.primary;

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveText,
          side: BorderSide(
            color: isDisabled
                ? colors.border.withValues(alpha: 0.4)
                : effectiveBorder,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: effectiveText,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: effectiveText),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color: effectiveText,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _DangerOutlineButton extends AppOutlineButton {
  const _DangerOutlineButton({
    required super.text,
    super.onPressed,
    super.icon,
    super.width,
    super.isFullWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppOutlineButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isFullWidth: isFullWidth,
      borderColor: colors.neonRed,
      textColor: colors.neonRed,
    );
  }
}

class AppFAB extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback? onPressed;
  final bool isPulseEnabled;
  final bool isExtended;

  const AppFAB({
    super.key,
    required this.icon,
    this.label,
    this.onPressed,
    this.isPulseEnabled = false,
    this.isExtended = false,
  });

  factory AppFAB.extended({
    required IconData icon,
    required String label,
    VoidCallback? onPressed,
    bool isPulseEnabled = false,
  }) =>
      AppFAB(
        icon: icon,
        label: label,
        onPressed: onPressed,
        isPulseEnabled: isPulseEnabled,
        isExtended: true,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget fab = isExtended
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: colors.primary,
            foregroundColor: Colors.white,
            icon: Icon(icon),
            label: Text(
              label ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: colors.primary,
            foregroundColor: Colors.white,
            child: Icon(icon),
          );

    if (isPulseEnabled) {
      fab = fab
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(
            begin: 1.0,
            end: 1.05,
            duration: 900.ms,
            curve: Curves.easeInOut,
          )
          .boxShadow(
            begin: BoxShadow(
              color: colors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
            ),
            end: BoxShadow(
              color: colors.primary.withValues(alpha: 0.7),
              blurRadius: 24,
              spreadRadius: 4,
            ),
            duration: 900.ms,
          );
    }

    return fab;
  }
}
