import 'dart:js_interop';

import 'package:digit_ui_components/theme/ColorTheme/color_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> colorStories() {
  return [
    Story(
      name: 'Foundations/Colors',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        final colorTheme = theme.colorTheme;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Colors',
                  style: textTheme.headingL.copyWith(color: colorTheme.primary.primary2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildCategorySection(context, 'Primary', _buildPrimaryColors(context, colorTheme.primary)),
                _buildCategorySection(context, 'Text', _buildTextColors(context, colorTheme.text)),
                _buildCategorySection(context, 'Paper', _buildPaperColors(context, colorTheme.paper)),
                _buildCategorySection(context, 'Alert', _buildAlertColors(context, colorTheme.alert)),
                _buildCategorySection(context, 'Generic', _buildGenericColors(context, colorTheme.generic)),
              ],
            ),
          ),
        );
      },
    ),
  ];
}

// Helper function to create sections with a heading
Widget _buildCategorySection(BuildContext context, String heading, Widget child) {
  final theme = Theme.of(context);
  return Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: theme.colorTheme.paper.secondary,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: theme.colorTheme.generic.divider, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: theme.digitTextTheme(context).headingM.copyWith(color: theme.colorTheme.text.primary),
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget _buildColorRow(BuildContext context, String name, Widget colorSwatch) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: SelectableText(
              name,
              style: Theme.of(context).digitTextTheme(context).headingXS.copyWith(color: Theme.of(context).colorTheme.text.primary),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: colorSwatch,
        ),
      ],
    ),
  );
}

// Builds the alert color swatches grouped together (success & successBg, etc.) inside a container
Widget _buildAlertColors(BuildContext context, Alert alert) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildAlertGroupContainer(
        context,
        'Success Colors',
        _buildGroupedColorSwatches(context, alert.success, alert.successBg, 'theme.colorTheme.alert.success', 'theme.colorTheme.alert.successBg'),
      ),
      _buildAlertGroupContainer(
        context,
        'Error Colors',
        _buildGroupedColorSwatches(context, alert.error, alert.errorBg, 'theme.colorTheme.alert.error', 'theme.colorTheme.alert.errorBg'),
      ),
      _buildAlertGroupContainer(
        context,
        'Info Colors',
        _buildGroupedColorSwatches(context, alert.info, alert.infoBg, 'theme.colorTheme.alert.info', 'theme.colorTheme.alert.infoBg'),
      ),
      _buildAlertGroupContainer(
        context,
        'Warning Colors',
        _buildGroupedColorSwatches(context, alert.warning, alert.warningBg, 'theme.colorTheme.alert.warning', 'theme.colorTheme.alert.warningBg'),
      ),
    ],
  );
}

// Helper function to wrap alert color group in a container
Widget _buildAlertGroupContainer(BuildContext context, String title, Widget child) {
  final theme = Theme.of(context);
  return Container(
    margin: const EdgeInsets.only(top: 16.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: theme.colorTheme.paper.primary,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: theme.colorTheme.generic.divider, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).digitTextTheme(context).headingS.copyWith(color: theme.colorTheme.text.primary),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper function to create swatches for grouped colors (like success and successBg)
Widget _buildGroupedColorSwatches(BuildContext context, Color primary, Color background, String name, String name2) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildColorRow(context, name, _buildColorSwatch(context,'', primary)),
      _buildColorRow(context, name2, _buildColorSwatch(context,'Primary Text', background)),
    ],
  );
}

// Builds the text color swatches
Widget _buildTextColors(BuildContext context, Dtext text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildColorRow(context, 'theme.colorTheme.text.primary', _buildColorSwatch(context,'Primary Text', text.primary)),
      _buildColorRow(context, 'theme.colorTheme.text.secondary', _buildColorSwatch(context,'Secondary Text', text.secondary)),
      _buildColorRow(context, 'theme.colorTheme.text.disabled', _buildColorSwatch(context,'Disabled Text', text.disabled)),
    ],
  );
}

// Builds the primary color swatches
Widget _buildPrimaryColors(BuildContext context, Primary primary) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildColorRow(context, 'theme.colorTheme.primary.primary1', _buildColorSwatch(context, 'Primary 1', primary.primary1)),
      _buildColorRow(context, 'theme.colorTheme.primary.primary2', _buildColorSwatch(context, 'Primary 2', primary.primary2)),
      _buildColorRow(context, 'theme.colorTheme.primary.primaryBg', _buildColorSwatch(context, 'Primary Background', primary.primaryBg)),
    ],
  );
}

// Builds the paper color swatches
Widget _buildPaperColors(BuildContext context, Paper paper) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildColorRow(context, 'theme.colorTheme.paper.primary', _buildColorSwatch(context, 'Primary Paper', paper.primary)),
      _buildColorRow(context, 'theme.colorTheme.paper.secondary', _buildColorSwatch(context, 'Secondary Paper', paper.secondary)),
    ],
  );
}

// Builds the generic color swatches
Widget _buildGenericColors(BuildContext context, Generic generic) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildColorRow(context, 'theme.colorTheme.generic.background', _buildColorSwatch(context, 'Background', generic.background)),
      _buildColorRow(context, 'theme.colorTheme.generic.divider', _buildColorSwatch(context, 'Divider', generic.divider)),
      _buildColorRow(context, 'theme.colorTheme.generic.inputBorder', _buildColorSwatch(context,'Input Border', generic.inputBorder)),
      _buildColorRow(context, 'theme.colorTheme.generic.transparent', _buildColorSwatch(context, 'Transparent', generic.transparent)),
    ],
  );
}

// Helper function to build color swatches with selectable hex codes
Widget _buildColorSwatch(BuildContext context, String name, Color color, ) {
  final theme = Theme.of(context);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 600,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: theme.colorTheme.generic.inputBorder, width: 1),
        ),
      ),
      const SizedBox(height: 4),
      SelectableText(
        '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
        style: theme.digitTextTheme(context).bodyXS.copyWith(color: theme.colorTheme.text.secondary),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
