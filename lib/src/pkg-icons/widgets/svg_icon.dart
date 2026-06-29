import 'package:flutter/material.dart';
import 'package:full_svg_flutter/full_svg_flutter.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final double size;
  final Color? color;
  final String? semanticLabel;

  const SvgIcon({
    super.key,
    required this.assetName,
    this.size = 24,
    this.color,
    this.semanticLabel,
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
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        semanticsLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
      ),
    );
  }
}
