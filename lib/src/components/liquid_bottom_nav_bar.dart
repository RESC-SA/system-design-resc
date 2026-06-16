import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'liquid_nav_item.dart';
import 'liquid_nav_style.dart';

typedef LiquidNavItemIconBuilder = IconData Function(LiquidNavItem item);

/// A liquid-like bottom navigation bar with physics-based blob animation,
/// drag support, and glass-effect background.
///
/// The blob stretches, wobbles, and slides between tabs with velocity-based
/// deformation for a fluid, organic feel.
@immutable
class LiquidBottomNavBar extends StatefulWidget {
  const LiquidBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.onChanged,
    this.onDrag,
    this.badges,
    this.style = const LiquidNavStyle(),
    this.backgroundColor,
    this.containerColor,
    this.liquidColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.border,
    this.borderSide,
    this.borderRadius,
    this.height = 80,
    this.width,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutQuint,
    this.boxShadow,
    this.labelStyle,
    this.activeLabelStyle,
    this.showLabel,
    this.activeIcon,
    this.inactiveIcon,
    this.blurSigma,
    this.badgeColor = const Color(0xFFE53935),
    this.badgeTextColor = const Color(0xFFFFFFFF),
    this.badgeBorderColor,
    this.badgeTextStyle,
    this.blobBaseWidthFactor = 0.88,
    this.blobExpandedWidthFactor = 1.15,
    this.blobBaseHeight = 48,
    this.blobExpandedHeight = 65,
    this.blobStretchMultiplier = 35,
    this.blobMaxStretch = 45,
    this.blobWobbleInfluenceOnWidth = 1,
    this.blobWobbleInfluenceOnHeight = 0.3,
  })  : assert(items.length >= 2, 'items must contain at least 2 entries'),
        assert(onTap != null || onChanged != null,
            'Provide onTap or onChanged callback');

  final int currentIndex;
  final List<LiquidNavItem> items;

  /// Preferred callback for tab selection.
  final ValueChanged<int>? onTap;

  /// Backward compatibility callback.
  final ValueChanged<int>? onChanged;

  /// Called when drag gesture ends at nearest tab.
  final ValueChanged<int>? onDrag;

  /// Optional badges map by index.
  final Map<int, int>? badges;

  final LiquidNavStyle style;

  final Color? backgroundColor;
  final Color? containerColor;
  final Color? liquidColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Border? border;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;

  final double height;
  final double? width;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final Duration animationDuration;
  final Curve curve;
  final List<BoxShadow>? boxShadow;

  final TextStyle? labelStyle;
  final TextStyle? activeLabelStyle;
  final bool? showLabel;

  final LiquidNavItemIconBuilder? activeIcon;
  final LiquidNavItemIconBuilder? inactiveIcon;

  /// Optional blur (glass effect). Null or 0 disables.
  final double? blurSigma;

  final Color badgeColor;
  final Color badgeTextColor;
  final Color? badgeBorderColor;
  final TextStyle? badgeTextStyle;

  final double blobBaseWidthFactor;
  final double blobExpandedWidthFactor;
  final double blobBaseHeight;
  final double blobExpandedHeight;
  final double blobStretchMultiplier;
  final double blobMaxStretch;
  final double blobWobbleInfluenceOnWidth;
  final double blobWobbleInfluenceOnHeight;

  @override
  State<LiquidBottomNavBar> createState() => _LiquidBottomNavBarState();
}

class _LiquidBottomNavBarState extends State<LiquidBottomNavBar>
    with TickerProviderStateMixin {
  late final AnimationController _expansionController;
  late final AnimationController _snapController;
  late final AnimationController _wobbleController;
  late final AnimationController _dragWobbleController;

  double _dragPosition = 0;
  bool _isDragging = false;
  double _velocity = 0;
  double? _snapTarget;
  Animation<double>? _currentAnimation;
  VoidCallback? _snapListener;

  @override
  void initState() {
    super.initState();
    _dragPosition = widget.currentIndex.toDouble();

    _expansionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _snapController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _dragWobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void didUpdateWidget(covariant LiquidBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animationDuration != widget.animationDuration) {
      _snapController.duration = widget.animationDuration;
    }

    if (oldWidget.currentIndex != widget.currentIndex && !_isDragging) {
      if (_snapTarget == widget.currentIndex.toDouble()) {
        return;
      }
      _animateTo(widget.currentIndex);
    }
  }

  void _selectIndex(int index) {
    widget.onTap?.call(index);
    widget.onChanged?.call(index);
  }

  void _animateTo(int index) {
    final clampedIndex = index.clamp(0, widget.items.length - 1);
    final target = clampedIndex.toDouble();
    _removeSnapListener();

    if (_dragPosition == target) {
      _wobbleController.forward(from: 0);
      return;
    }

    _snapController.stop();
    _wobbleController.stop();
    _snapTarget = target;

    final animation = Tween<double>(begin: _dragPosition, end: target).animate(
      CurvedAnimation(parent: _snapController, curve: widget.curve),
    );

    _currentAnimation = animation;

    void listener() {
      if (_currentAnimation == animation && mounted) {
        setState(() {
          _dragPosition = animation.value;
        });
      }
    }

    _snapListener = listener;
    animation.addListener(listener);
    _snapController.addStatusListener(_snapStatusListener);
    _snapController.forward(from: 0);
  }

  void _snapStatusListener(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _removeSnapListener();
    _snapTarget = null;
    if (mounted) {
      _wobbleController.forward(from: 0);
    }
  }

  void _removeSnapListener() {
    final listener = _snapListener;
    final animation = _currentAnimation;
    if (listener != null && animation != null) {
      animation.removeListener(listener);
    }
    _snapListener = null;
    _snapController.removeStatusListener(_snapStatusListener);
  }

  @override
  void dispose() {
    _removeSnapListener();
    _expansionController.dispose();
    _snapController.dispose();
    _wobbleController.dispose();
    _dragWobbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int safeIndex = widget.currentIndex.clamp(0, widget.items.length - 1);

    final style = widget.style.copyWith(
      backgroundColor: widget.backgroundColor,
      containerColor: widget.containerColor,
      liquidColor: widget.liquidColor,
      activeIconColor: widget.activeIconColor,
      inactiveIconColor: widget.inactiveIconColor,
      border: widget.border,
      borderSide: widget.borderSide,
      borderRadius: widget.borderRadius,
      boxShadow: widget.boxShadow,
      labelStyle: widget.labelStyle,
      activeLabelStyle: widget.activeLabelStyle,
      showLabel: widget.showLabel,
      blurSigma: widget.blurSigma,
    );

    return Container(
      color: style.backgroundColor,
      margin: widget.margin,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : MediaQuery.sizeOf(context).width;
          final maxWidth = math.max(0.0, widget.width ?? availableWidth);
          final totalWidth =
              math.max(0.0, maxWidth - _horizontalPadding(widget.padding));
          final itemWidth = totalWidth / widget.items.length;
          final resolvedPadding =
              widget.padding.resolve(Directionality.of(context));
          final innerHeight =
              math.max(48.0, widget.height - resolvedPadding.vertical);

          Widget navBar = SizedBox(
            width: maxWidth,
            height: widget.height,
            child: Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onPanStart: (_) {
                  setState(() => _isDragging = true);
                  _expansionController.forward();
                  _wobbleController.stop();
                  _snapController.stop();
                  _dragWobbleController.repeat();
                },
                onPanUpdate: (details) {
                  setState(() {
                    _velocity = details.delta.dx / itemWidth;
                    _dragPosition = (_dragPosition + _velocity).clamp(
                      0.0,
                      (widget.items.length - 1).toDouble(),
                    );
                  });
                },
                onPanEnd: (_) {
                  setState(() {
                    _isDragging = false;
                    _velocity = 0;
                  });
                  _dragWobbleController.stop();
                  _expansionController.reverse();
                  final nearestTab =
                      _dragPosition.round().clamp(0, widget.items.length - 1);
                  _animateTo(nearestTab);
                  widget.onDrag?.call(nearestTab);
                  _selectIndex(nearestTab);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: style.borderRadius,
                    boxShadow: style.boxShadow,
                  ),
                  child: Container(
                    height: innerHeight,
                    decoration: BoxDecoration(
                      borderRadius: style.borderRadius,
                      border: style.resolveBorder(),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: style.borderRadius,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: style.blurSigma ?? 0,
                                sigmaY: style.blurSigma ?? 0,
                              ),
                              child: ColoredBox(color: style.containerColor),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: Listenable.merge([
                              _expansionController,
                              _snapController,
                              _wobbleController,
                              _dragWobbleController,
                            ]),
                            builder: (context, _) {
                              final wobbleVal = math.sin(
                                      _wobbleController.value * math.pi * 4) *
                                  (1 - _wobbleController.value) *
                                  15.0;
                              return CustomPaint(
                                painter: _IOSLiquidPainter(
                                  position: _dragPosition,
                                  itemWidth: itemWidth,
                                  velocity: _isDragging ? _velocity : 0,
                                  expansion: _expansionController.value,
                                  wobble: wobbleVal,
                                  dragWobble: _isDragging
                                      ? _dragWobbleController.value
                                      : 0,
                                  horizontalInset: resolvedPadding.left,
                                  primaryColor: style.liquidColor,
                                  surfaceColor: style.containerColor,
                                  blobBaseWidthFactor:
                                      widget.blobBaseWidthFactor,
                                  blobExpandedWidthFactor:
                                      widget.blobExpandedWidthFactor,
                                  blobBaseHeight: widget.blobBaseHeight,
                                  blobExpandedHeight:
                                      widget.blobExpandedHeight,
                                  blobStretchMultiplier:
                                      widget.blobStretchMultiplier,
                                  blobMaxStretch: widget.blobMaxStretch,
                                  blobWobbleInfluenceOnWidth:
                                      widget.blobWobbleInfluenceOnWidth,
                                  blobWobbleInfluenceOnHeight:
                                      widget.blobWobbleInfluenceOnHeight,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: widget.padding,
                          child: Row(
                            children:
                                List.generate(widget.items.length, (index) {
                              final item = widget.items[index];
                              final distance = (index - _dragPosition).abs();
                              final isSelected = index == safeIndex;

                              final iconData = isSelected
                                  ? (widget.activeIcon?.call(item) ??
                                      item.activeIcon ??
                                      item.icon)
                                  : (widget.inactiveIcon?.call(item) ??
                                      item.inactiveIcon ??
                                      item.icon);

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _selectIndex(index);
                                    _animateTo(index);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Icon(
                                            iconData,
                                            size: widget.iconSize,
                                            color: Color.lerp(
                                              style.inactiveIconColor,
                                              style.activeIconColor,
                                              (1.0 - distance).clamp(0.0, 1.0),
                                            ),
                                          ),
                                          if (_showBadge(index))
                                            Positioned(
                                              right: -6,
                                              top: -6,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: widget.badgeColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: widget
                                                            .badgeBorderColor ??
                                                        style.containerColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth: 16,
                                                  minHeight: 16,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${widget.badges![index]}',
                                                    style: widget
                                                            .badgeTextStyle ??
                                                        TextStyle(
                                                          color: widget
                                                              .badgeTextColor,
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (style.showLabel &&
                                          (item.label?.isNotEmpty ?? false))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Text(
                                            item.label!,
                                            style: isSelected
                                                ? (style.activeLabelStyle ??
                                                    TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: style.liquidColor,
                                                    ))
                                                : (style.labelStyle ??
                                                    TextStyle(
                                                      fontSize: 9,
                                                      color: style
                                                          .inactiveIconColor,
                                                    )),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

          return navBar;
        },
      ),
    );
  }

  bool _showBadge(int index) {
    final badges = widget.badges;
    if (badges == null || !badges.containsKey(index)) return false;
    return (badges[index] ?? 0) > 0;
  }

  double _horizontalPadding(EdgeInsetsGeometry geometry) {
    final resolved = geometry.resolve(Directionality.of(context));
    return resolved.left + resolved.right;
  }
}

class _IOSLiquidPainter extends CustomPainter {
  _IOSLiquidPainter({
    required this.position,
    required this.itemWidth,
    required this.velocity,
    required this.expansion,
    required this.wobble,
    required this.dragWobble,
    required this.horizontalInset,
    required this.primaryColor,
    required this.surfaceColor,
    required this.blobBaseWidthFactor,
    required this.blobExpandedWidthFactor,
    required this.blobBaseHeight,
    required this.blobExpandedHeight,
    required this.blobStretchMultiplier,
    required this.blobMaxStretch,
    required this.blobWobbleInfluenceOnWidth,
    required this.blobWobbleInfluenceOnHeight,
  });

  final double position;
  final double itemWidth;
  final double velocity;
  final double expansion;
  final double wobble;
  final double dragWobble;
  final double horizontalInset;
  final Color primaryColor;
  final Color surfaceColor;
  final double blobBaseWidthFactor;
  final double blobExpandedWidthFactor;
  final double blobBaseHeight;
  final double blobExpandedHeight;
  final double blobStretchMultiplier;
  final double blobMaxStretch;
  final double blobWobbleInfluenceOnWidth;
  final double blobWobbleInfluenceOnHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX =
        horizontalInset + (position * itemWidth) + (itemWidth / 2);

    final baseWidth = itemWidth * blobBaseWidthFactor;
    final expandedWidth = itemWidth * blobExpandedWidthFactor;
    var currentWidth =
        lerpDouble(baseWidth, expandedWidth, expansion) ?? baseWidth;

    final stretch =
        (velocity.abs() * blobStretchMultiplier).clamp(0.0, blobMaxStretch);
    currentWidth += stretch + (wobble * blobWobbleInfluenceOnWidth);

    final baseHeight = blobBaseHeight;
    final expandedHeight = blobExpandedHeight;
    var currentHeight =
        lerpDouble(baseHeight, expandedHeight, expansion) ?? baseHeight;

    currentHeight -= wobble * blobWobbleInfluenceOnHeight;
    final dragWave =
        math.sin(dragWobble * math.pi * 2) * velocity.abs().clamp(0.0, 1.0);
    currentHeight += dragWave * 3.5;

    final rect = Rect.fromCenter(
      center: Offset(centerX, (size.height / 2) + (dragWave * 1.4)),
      width: currentWidth,
      height: currentHeight,
    );

    final rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(currentHeight / 2));

    final liquidPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          surfaceColor.withValues(alpha: 0.95),
          primaryColor.withValues(alpha: 0.18),
          primaryColor.withValues(alpha: 0.45),
        ],
      ).createShader(rect);

    canvas.drawRRect(
      rrect.shift(const Offset(0, 3)),
      Paint()
        ..color = primaryColor.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    canvas.drawRRect(rrect, liquidPaint);

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = surfaceColor.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _IOSLiquidPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.itemWidth != itemWidth ||
        oldDelegate.velocity != velocity ||
        oldDelegate.expansion != expansion ||
        oldDelegate.wobble != wobble ||
        oldDelegate.dragWobble != dragWobble ||
        oldDelegate.horizontalInset != horizontalInset ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.surfaceColor != surfaceColor ||
        oldDelegate.blobBaseWidthFactor != blobBaseWidthFactor ||
        oldDelegate.blobExpandedWidthFactor != blobExpandedWidthFactor ||
        oldDelegate.blobBaseHeight != blobBaseHeight ||
        oldDelegate.blobExpandedHeight != blobExpandedHeight ||
        oldDelegate.blobStretchMultiplier != blobStretchMultiplier ||
        oldDelegate.blobMaxStretch != blobMaxStretch ||
        oldDelegate.blobWobbleInfluenceOnWidth !=
            blobWobbleInfluenceOnWidth ||
        oldDelegate.blobWobbleInfluenceOnHeight !=
            blobWobbleInfluenceOnHeight;
  }
}
