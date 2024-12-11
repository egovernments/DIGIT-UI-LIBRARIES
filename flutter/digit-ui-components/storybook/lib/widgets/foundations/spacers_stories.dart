import 'package:digit_ui_components/theme/ColorTheme/color_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> spacerStories() {
  return [
    Story(
      name: 'Foundations/Spacers',
      builder: (context) {
        final theme = Theme.of(context);
        final spacerTheme = theme.spacerTheme; // Get the spacer theme

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Spacers',
                  style: theme.digitTextTheme(context).headingL.copyWith(color: theme.colorTheme.primary.primary2),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 24),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer1', spacerTheme.spacer1),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer2', spacerTheme.spacer2),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer3', spacerTheme.spacer3),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer4', spacerTheme.spacer4),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer5', spacerTheme.spacer5),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer6', spacerTheme.spacer6),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer7', spacerTheme.spacer7),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer8', spacerTheme.spacer8),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer9', spacerTheme.spacer9),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer10', spacerTheme.spacer10),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer11', spacerTheme.spacer11),
                _buildSpacerRow(context, 'theme.spacerTheme.spacer12', spacerTheme.spacer12),
              ],
            ),
          ),
        );
      },
    ),
  ];
}

Widget _buildSpacerRow(BuildContext context, String name, double spacerValue) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: SelectableText(
            name,
            style: Theme.of(context).digitTextTheme(context).headingXS.copyWith(color: Theme.of(context).colorTheme.text.primary),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Container(
                height: spacerValue,
                color: Theme.of(context).colorTheme.generic.divider, // Example color for visual representation
              ),
              const SizedBox(height: 4), // Space between container and text
              Text(
                '${spacerValue.toString()} px',
                style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: Theme.of(context).colorTheme.text.secondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
