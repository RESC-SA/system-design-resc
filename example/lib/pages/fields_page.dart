import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class FieldsPage extends StatefulWidget {
  const FieldsPage({super.key});

  @override
  State<FieldsPage> createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  bool _switchValue = true;
  double _sliderValue = 50;
  bool _checkboxValue = true;
  String _segmentedValue = 'Day';
  String? _dropdownValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Form Fields',
      floatingActionButton: ds.AppFAB(
        icon: Amicons.lucide_check,
        onPressed: () => _formKey.currentState?.validate(),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _section(theme, 'AppTextField', children: [
              ds.AppTextField(
                label: 'Standard',
                hint: 'Enter some text',
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              ds.AppTextField.email(
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              ds.AppTextField.password(
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              ds.AppTextField.phone(
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              ds.AppTextField.username(
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              ds.AppTextField.name(
                onChanged: (_) {},
              ),
              const SizedBox(height: 12),
              ds.AppTextField.multiline(
                label: 'Message',
                hint: 'Write a message...',
              ),
              const SizedBox(height: 12),
              ds.AppTextField.small(
                label: 'Compact',
                hint: 'Small variant',
              ),
            ]),
            _section(theme, 'AppSearchField', children: [
              ds.AppSearchField(
                hint: 'Search anything...',
                onChanged: (_) {},
              ),
            ]),
            _section(theme, 'AppDropdownField', children: [
              ds.AppDropdownField<String>(
                label: 'Select Option',
                hint: 'Choose one',
                value: _dropdownValue,
                items: ['Option A', 'Option B', 'Option C']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _dropdownValue = v),
                prefixIcon: Amicons.lucide_circle_dashed,
              ),
            ]),
            _section(theme, 'AppSwitchField', children: [
              ds.AppSwitchField(
                label: 'Wi-Fi',
                subtitle: 'Enable wireless connectivity',
                value: _switchValue,
                onChanged: (v) => setState(() => _switchValue = v),
              ),
              ds.AppSwitchField(
                label: 'Bluetooth',
                value: false,
                onChanged: (_) {},
              ),
              ds.AppSwitchField(
                label: 'Disabled',
                value: true,
                enabled: false,
                onChanged: null,
              ),
            ]),
            _section(theme, 'AppSliderField', children: [
              ds.AppSliderField(
                label: 'Volume',
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 10,
                unit: '%',
                onChanged: (v) => setState(() => _sliderValue = v),
              ),
            ]),
            _section(theme, 'AppCheckboxField', children: [
              ds.AppCheckboxField(
                label: 'Accept Terms',
                subtitle: 'I agree to the terms and conditions',
                value: _checkboxValue,
                onChanged: (v) => setState(() => _checkboxValue = v ?? false),
              ),
              ds.AppCheckboxField(
                label: 'Disabled',
                value: false,
                enabled: false,
                onChanged: null,
              ),
            ]),
            _section(theme, 'AppSegmentedField', children: [
              ds.AppSegmentedField<String>(
                label: 'Period',
                segments: {
                  'Day': const Text('Day'),
                  'Week': const Text('Week'),
                  'Month': const Text('Month'),
                },
                selected: _segmentedValue,
                onChanged: (v) => setState(() => _segmentedValue = v),
              ),
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _section(ThemeData theme, String title, {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
