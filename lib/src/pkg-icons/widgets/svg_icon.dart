import 'package:flutter/material.dart';
import 'package:full_svg_flutter/full_svg_flutter.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final double size;
  final Color? color;
  final String? semanticLabel;
  final BoxFit fit;
  final ColorFilter? colorFilter;
  final Color? backgroundColor;
  final bool? autoPlay;
  final double? playbackRate;

  const SvgIcon({
    super.key,
    required this.assetName,
    this.size = 24,
    this.color,
    this.semanticLabel,
    this.autoPlay,
    this.playbackRate,
    this.backgroundColor,
    this.colorFilter,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).iconTheme.color ?? Colors.black;

    return SizedBox(
      width: size,
      height: size,
      child: FSvgPicture.asset(
        assetName,
        width: size,
        height: size,
        fit: fit,
        colorFilter: colorFilter ?? ColorFilter.mode(iconColor, BlendMode.srcIn),
        semanticsLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        backgroundColor: backgroundColor,
        autoPlay: autoPlay ?? false,
        playbackRate: playbackRate ?? 1.0,
      ),
    );
  }
}
