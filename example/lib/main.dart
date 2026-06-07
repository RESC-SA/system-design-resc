import 'package:flutter/material.dart';
import '../../lib/flutter_design_system.dart';

void main() {
  runApp(const DesignSystemExampleApp());
}

class DesignSystemExampleApp extends StatelessWidget {
  const DesignSystemExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Design System Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const ExampleHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Design System Demo'),
          actions: [
            IconButton(
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => setState(() => _isDark = !_isDark),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Your Design System!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Generated with colors: #52bc49, #ffffff, #f0f5f0',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              AppButton(
                onPressed: () {},
                variant: AppButtonVariant.primary,
                child: const Text('Primary Button'),
              ),
              const SizedBox(height: 8),
              AppButton(
                onPressed: () {},
                variant: AppButtonVariant.secondary,
                child: const Text('Secondary Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
