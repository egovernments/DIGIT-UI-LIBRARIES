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
      initial: colorTheme.primary.primary2,
      options: _buildColorOptions(colorTheme),
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Top description
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Explore Material Icons to enhance your app interface. '
                    'Click on any icon to see how to implement it in your code, '
                    'and feel free to customize the color to fit your design!',
                style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(
                  color: Theme.of(context).colorTheme.text.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Icons grid
            Wrap(
              spacing: 24.0, // Spacing between icons horizontally
              runSpacing: 24.0, // Spacing between icons vertically
              children: _buildIconWidgets(selectedColor, context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIconWidgets(Color selectedColor, BuildContext context) {
    // Predefined list of Material Icons
    final icons = [
      {'name': 'add', 'icon': Icons.add},
      {'name': 'auto_delete', 'icon': Icons.auto_delete},
      {'name': 'call', 'icon': Icons.call},
      {'name': 'camera', 'icon': Icons.camera},
      {'name': 'check', 'icon': Icons.check},
      {'name': 'check_circle', 'icon': Icons.check_circle},
      {'name': 'close', 'icon': Icons.close},
      {'name': 'edit', 'icon': Icons.edit},
      {'name': 'event', 'icon': Icons.event},
      {'name': 'file_download', 'icon': Icons.file_download},
      {'name': 'filter_alt', 'icon': Icons.filter_alt},
      {'name': 'forum', 'icon': Icons.forum},
      {'name': 'home', 'icon': Icons.home},
      {'name': 'info_outline', 'icon': Icons.info_outline},
      {'name': 'mail', 'icon': Icons.mail},
      {'name': 'near_me', 'icon': Icons.near_me},
      {'name': 'notifications', 'icon': Icons.notifications},
      {'name': 'person', 'icon': Icons.person},
      {'name': 'refresh', 'icon': Icons.refresh},
      {'name': 'search', 'icon': Icons.search},
      {'name': 'sentiment_satisfied_alt', 'icon': Icons.sentiment_satisfied_alt},
      {'name': 'settings', 'icon': Icons.settings},
      {'name': 'share', 'icon': Icons.share}, // Duplicate share, only one kept
      {'name': 'star', 'icon': Icons.star},
      {'name': 'text_snippet', 'icon': Icons.text_snippet},
      {'name': 'thumb_up', 'icon': Icons.thumb_up},
      {'name': 'toc', 'icon': Icons.toc},
      {'name': 'view_carousel', 'icon': Icons.view_carousel},
    ];

    return icons.map((iconData) {
      final iconName = iconData['name'] as String; // Access the name of the icon
      final icon = iconData['icon'] as IconData; // Access the icon itself

      return InkWell(
        onTap: () => _showIconDialog(context, iconName, selectedColor), // Show dialog on tap
        child: Container(
          width: 200, // Set fixed width for each icon container
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorTheme.paper.secondary, // Correct color scheme
            border: Border.all(color: Theme.of(context).colorTheme.generic.inputBorder, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon, // Use the actual icon here
                size: 48.0, // Default size for icons
                color: selectedColor, // You can define this color or keep the default
              ),
              const SizedBox(height: 16),
              Text(
                iconName, // Display the name of the icon
                style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: Theme.of(context).colorTheme.text.primary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  void _showIconDialog(BuildContext context, String iconName, Color color) {
    String codeSnippet = '''
Icon(
  Icons.$iconName,
  size: 48.0, // Set the size for the icon
  color: $color, 
)''';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          AlertDialog(
          backgroundColor: Theme.of(context).colorTheme.paper.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          title: Text(iconName),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Usage Example:'),
                SizedBox(height: 8),
                // Display the code snippet
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[100], // Light grey background for the code snippet
                  ),
                  child: SelectableText(
                    codeSnippet,  // Make it selectable for copying
                    style: TextStyle(fontFamily: 'monospace'), // Monospace font for code
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  List<Option> _buildColorOptions(DigitColorTheme colorTheme) {
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
