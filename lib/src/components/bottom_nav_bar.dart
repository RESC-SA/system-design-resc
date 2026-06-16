import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

/// Platform variant for bottom nav appearance.
enum BottomNavPlatform { android, ios }

/// A single item in [AppBottomNavBar].
class AppBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String? label;
  final int? badge;

  const AppBottomNavItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badge,
  });
}

/// Fully custom bottom navigation bar with liquid glass effect,
/// animated active indicator, and platform-adaptive layout.
class AppBottomNavBar extends StatefulWidget {
  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double height;
  final double borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final BottomNavPlatform? platform;
  final bool glassEffect;

  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 64,
    this.borderRadius = 20,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.platform,
    this.glassEffect = true,
  });

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _bounce = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  BottomNavPlatform get _platform =>
      widget.platform ??
      (Theme.of(context).platform == TargetPlatform.iOS
          ? BottomNavPlatform.ios
          : BottomNavPlatform.android);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDark;
    final isIOS = _platform == BottomNavPlatform.ios;

    final activeColor = widget.activeColor ?? colors.primary;
    final inactiveColor =
        widget.inactiveColor ?? (isDark ? colors.textDim : colors.textSecondary);
    final bgColor = widget.backgroundColor ?? colors.surface;
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalMargin = widget.borderRadius + (isIOS ? 8 : 0);
    final availableWidth = screenWidth - horizontalMargin * 2;
    final itemWidth = availableWidth / widget.items.length;
    final indicatorLeft =
        widget.currentIndex * itemWidth + (itemWidth - 32) / 2;

    Widget bar = SizedBox(
      height: widget.height + MediaQuery.of(context).padding.bottom,
      child: Stack(
        children: [
          // Animated indicator pill
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
            bottom: isIOS ? null : 0,
            top: isIOS ? 0 : null,
            left: indicatorLeft + horizontalMargin,
            child: AnimatedBuilder(
              animation: _bounce,
              builder: (context, _) {
                return Transform.scale(
                  scale: 1.0 + _bounce.value * 0.2,
                  child: Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
          ),
          // Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
            child: Row(
              children: List.generate(widget.items.length, (i) {
                final item = widget.items[i];
                final isActive = widget.currentIndex == i;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      widget.onTap(i);
                      _bounceController..reset()..forward();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: isIOS ? 6 : 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                isActive
                                    ? (item.activeIcon ?? item.icon)
                                    : item.icon,
                                size: isIOS ? 26 : 24,
                                color: isActive ? activeColor : inactiveColor,
                              ),
                              if (item.badge != null && item.badge! > 0)
                                PositionedDirectional(
                                  top: -4,
                                  end: -8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.neonRed,
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.badge! > 99
                                          ? '99+'
                                          : '${item.badge}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (item.label != null)
                            Padding(
                              padding: EdgeInsets.only(top: isIOS ? 2 : 4),
                              child: Text(
                                item.label!,
                                style: TextStyle(
                                  fontSize: isIOS ? 10 : 11,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color:
                                      isActive ? activeColor : inactiveColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );

    // Wrap in glass effect or plain container
    if (widget.glassEffect) {
      bar = ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.borderRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            decoration: BoxDecoration(
              color: (isDark ? Colors.white10 : Colors.white70)
                  .withValues(alpha: 0.85),
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white12 : Colors.white38,
                  width: 0.5,
                ),
              ),
            ),
            child: bar,
          ),
        ),
      );
    } else {
      bar = Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(widget.borderRadius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: bar,
      );
    }

    return bar;
  }
}
