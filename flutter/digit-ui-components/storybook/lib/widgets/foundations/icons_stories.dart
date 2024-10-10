import 'package:digit_ui_components/theme/ColorTheme/color_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

class MaterialIconsStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorTheme = theme.colorTheme;

    // Using knobs from context to get the selected color
    final selectedColor = context.knobs.options(
      label: 'Select Color',
      initial: colorTheme.primary.primary1,
      options: _buildColorOptions(colorTheme),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 4, // Adjust the number of columns as needed
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Disable scrolling for inner GridView
          children: _buildIconWidgets(selectedColor),
        ),
      ),
    );
  }

  List<Widget> _buildIconWidgets(Color selectedColor) {
    // Predefined list of Material Icons
    final icons = [
      Icons.access_alarm,
      Icons.add,
      Icons.alarm,
      Icons.search,
      Icons.favorite,
      Icons.home,
      // Add more icons as needed
      Icons.settings,
      Icons.camera,
      Icons.call,
      Icons.check,
      Icons.cloud,
      Icons.edit,
      Icons.mail,
      Icons.notifications,
      Icons.person,
      Icons.star,
      Icons.share,
      // Continue adding all desired Material Icons
    ];

    return icons.map((iconData) {
      final iconName = iconData.toString().split(' ').last; // Get the icon name

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 48.0, // Default size, you can add size knob if needed
            color: selectedColor,
          ),
          const SizedBox(height: 8),
          Text(iconName.replaceAll('Icons.', ''), style: TextStyle(fontSize: 12)),
        ],
      );
    }).toList();
  }

  List<Option> _buildColorOptions(DigitColorTheme colorTheme) {
    // Define your color library options here
    return [
      Option(label: 'Primary1', value: colorTheme.primary.primary1),
      Option(label: 'Primary2', value: colorTheme.primary.primary2),
      Option(label: 'PrimaryBg', value: colorTheme.primary.primaryBg),
      Option(label: 'Paper Primary', value: colorTheme.paper.primary),
      Option(label: 'Paper Secondary', value: colorTheme.paper.secondary),
      Option(label: 'Success', value: colorTheme.alert.success),
      Option(label: 'Error', value: colorTheme.alert.error),
      Option(label: 'Warning', value: colorTheme.alert.warning),
    ];
  }
}

// Add the story to your story list
List<Story> materialIconStories() {
  return [
    Story(
      name: 'Foundations/Material Icons',
      builder: (context) {
        return MaterialIconsStory();
      },
    ),
  ];
}
