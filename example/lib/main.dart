import 'package:flutter/material.dart';
import 'package:amicons/amicons.dart';

import '../../lib/flutter_design_system.dart';
import '../../lib/src/components/buttons-sample.dart' as sample;

void main() {
  runApp(const DesignSystemExampleApp());
}

class DesignSystemExampleApp extends StatelessWidget {
  const DesignSystemExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Design System Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSliverScaffold(
      title: const Text('Design System'),
      pinned: false,
      floating: true,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _NavCard(
            icon: Amicons.lucide_layout_dashboard,
            label: 'Sliver Scaffold',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SliverDemoPage()));
            },
          ),
          const SizedBox(height: 12),
          _NavCard(
            icon: Amicons.lucide_notebook_tabs,
            label: 'Tab Scaffold',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TabDemoPage()));
            },
          ),
          const SizedBox(height: 12),
          _NavCard(
            icon: Amicons.lucide_layout_panel_top,
            label: 'Nested Scroll Scaffold',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const NestedScrollDemoPage()));
            },
          ),
          const SizedBox(height: 12),
          _NavCard(
            icon: Amicons.lucide_shapes,
            label: 'Buttons & Cards',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ComponentsPage()));
            },
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text(label, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          Icon(Amicons.lucide_chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class SliverDemoPage extends StatelessWidget {
  const SliverDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSliverScaffold(
      title: const Text('Sliver Scaffold'),
      expandedHeight: 200,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF52bc49), Color(0xFF2d7a27)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      pinned: true,
      actions: [
        IconButton(
            icon: const Icon(Amicons.lucide_search),
            onPressed: () {}),
        IconButton(
            icon: const Icon(Amicons.flaticon_menu_dots_rounded),
            onPressed: () {}),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Content Section',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text(
                  'This uses AppSliverScaffold with a gradient flexible space. '
                  'The app bar collapses as you scroll.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                sample.AppButton(
                  onPressed: () {},
                  variant: sample.AppButtonVariant.tonal,
                  icon: Amicons.lucide_arrow_left,
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          delegate: SliverChildListDelegate(
            List.generate(8,
                (i) => AppCard(onTap: () {}, child: Center(child: Text('Item ${i + 1}')))),
          ),
        ),
      ],
    );
  }
}

class TabDemoPage extends StatelessWidget {
  const TabDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabScaffold(
      title: const Text('Tab Scaffold'),
      tabs: const [
        Tab(icon: Icon(Amicons.iconly_home), text: 'Home'),
        Tab(icon: Icon(Amicons.lucide_search), text: 'Search'),
        Tab(icon: Icon(Amicons.iconly_user_2), text: 'Profile'),
      ],
      tabViews: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Home Tab', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            ...List.generate(
              5,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text('${i + 1}',
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text('Item ${i + 1}'),
                    subtitle: const Text('Tab view content'),
                  ),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Amicons.lucide_search, size: 48),
              const SizedBox(height: 16),
              Text('Search Tab', style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://i.pravatar.cc/80'),
              ),
              const SizedBox(height: 16),
              Text('Profile Tab', style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class NestedScrollDemoPage extends StatelessWidget {
  const NestedScrollDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNestedScrollScaffold(
      title: const Text('Nested Scroll'),
      expandedHeight: 180,
      flexibleBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF52bc49), Color(0xFF2d7a27)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      tabs: const [
        Tab(text: 'Posts'),
        Tab(text: 'Media'),
        Tab(text: 'Settings'),
      ],
      tabViews: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(
            10,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text('Post ${i + 1}'),
                  subtitle: const Text('Scrollable content inside tabs'),
                ),
              ),
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: const EdgeInsets.all(8),
          children: List.generate(
            12,
            (i) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('${i + 1}')),
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              leading: Icon(Amicons.lucide_bell),
              title: Text('Notifications'),
              trailing: Icon(Amicons.lucide_chevron_right),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Amicons.lucide_shield_alert),
              title: Text('Privacy'),
              trailing: Icon(Amicons.lucide_chevron_right),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Amicons.lucide_circle_help),
              title: Text('Help'),
              trailing: Icon(Amicons.lucide_chevron_right),
            ),
            const Divider(),
            const SizedBox(height: 24),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.outlined,
              expanded: true,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ],
    );
  }
}

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSliverScaffold(
      title: const Text('Components'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Button Variants',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.primary,
              child: const Text('Primary'),
            ),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.secondary,
              child: const Text('Secondary'),
            ),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.outlined,
              child: const Text('Outlined'),
            ),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.text,
              child: const Text('Text'),
            ),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.tonal,
              child: const Text('Tonal'),
            ),
          ]),
          const SizedBox(height: 24),
          Text('With Icons', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            sample.AppButton(
              onPressed: () {},
              icon: Amicons.lucide_arrow_right,
              child: const Text('Next'),
            ),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.outlined,
              icon: Amicons.iconly_download_broken,
              child: const Text('Download'),
            ),
            sample.AppButton(
              onPressed: () {},
              variant: sample.AppButtonVariant.tonal,
              icon: Amicons.lucide_search,
              child: const Text('Search'),
            ),
            sample.AppButton(
              onPressed: () {},
              iconPosition: sample.IconPosition.end,
              icon: Amicons.remix_external_link,
              child: const Text('Open'),
            ),
          ]),
          const SizedBox(height: 24),
          Text('Sizes', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            sample.AppButton(
              onPressed: () {},
              size: sample.AppButtonSize.sm,
              child: const Text('Small'),
            ),
            sample.AppButton(
              onPressed: () {},
              size: sample.AppButtonSize.md,
              child: const Text('Medium'),
            ),
            sample.AppButton(
              onPressed: () {},
              size: sample.AppButtonSize.lg,
              child: const Text('Large'),
            ),
          ]),
          const SizedBox(height: 24),
          Text('Full Width', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          sample.AppButton(
            onPressed: () {},
            expanded: true,
            icon: Amicons.iconly_send_fill,
            child: const Text('Submit'),
          ),
          const SizedBox(height: 24),
          Text('Icon Buttons', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            sample.AppIconButton(
              onPressed: () {},
              icon: Amicons.lucide_pen,
            ),
            sample.AppIconButton(
              onPressed: () {},
              icon: Amicons.iconly_delete_broken,
              variant: sample.AppButtonVariant.outlined,
            ),
            sample.AppIconButton(
              onPressed: () {},
              icon: Amicons.lucide_settings2,
              variant: sample.AppButtonVariant.tonal,
            ),
            sample.AppIconButton(
              onPressed: () {},
              icon: Amicons.iconly_heart_broken,
              variant: sample.AppButtonVariant.text,
            ),
          ]),
          const SizedBox(height: 24),
          Text('Cards', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          AppCard(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tappable Card',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                    'This is an AppCard with an onTap handler. Tap it to see the effect.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            elevation: 4,
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Icon(Amicons.lucide_star, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Custom Card',
                          style: Theme.of(context).textTheme.titleLarge),
                      Text('With elevation and padding overrides'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Liquid Glass Cards',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            SizedBox(
              width: 160,
              child: AppLiquidGlassCard(
                onTap: () {},
                child: Column(
                  children: [
                    const Icon(Amicons.lucide_droplets, size: 32),
                    const SizedBox(height: 8),
                    const Text('Pure Glass',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const Text('No packages'),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 160,
              child: AppLiquidGlassCard(
                onTap: () {},
                gradientColors: [
                  Colors.blue.withValues(alpha: 0.3),
                  Colors.purple.withValues(alpha: 0.1),
                ],
                child: Column(
                  children: [
                    const Icon(Amicons.lucide_star, size: 32),
                    const SizedBox(height: 8),
                    const Text('Custom Tint',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const Text('Any gradient'),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
