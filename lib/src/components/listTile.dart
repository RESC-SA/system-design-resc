import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool? enabled;
  final Color? backgroundColorContainer;
  final double? borderRadiusNum;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Offset? shadowOffset;
  final Color? tileColor;
  const AppListTile(
      {super.key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap,
      this.enabled,
      this.backgroundColorContainer,
      this.borderRadiusNum,
      this.borderRadius,
      this.border,
      this.boxShadow,
      this.shadowOffset,
      this.tileColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColorContainer ?? Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(borderRadiusNum ?? 8),
        border: border,
        boxShadow: boxShadow ?? null,
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        enabled: enabled ?? true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(borderRadiusNum ?? 8),
        ),
        tileColor: tileColor ?? Colors.white,
      ),
    );
  }
}
