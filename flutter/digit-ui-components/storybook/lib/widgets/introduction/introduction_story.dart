import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:url_launcher/url_launcher.dart';

List<Story> IntroStories() {
  return [
    Story(
      name: 'Introduction/doc',
      builder: (context) {
        return ScrollableContent(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Welcome to Digit UI Components',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorTheme.text.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Overview
                  _buildSectionTitle(context, 'Overview'),
                  _buildDescriptionText(
                    context,
                    'Digit UI Components is a Flutter package that provides a collection of reusable UI components. '
                        'It includes:\n\n'
                        '- **Atoms**: Basic UI elements like buttons, icons, and text fields.\n'
                        '- **Molecules**: Combinations of atoms such as form fields and alerts.\n'
                        '- **Wrapper Components**: Higher-level structures ensuring consistency.',
                  ),
                  const SizedBox(height: 16),
                  // New Section: Storybook Overview
                  _buildSectionTitle(context, 'Storybook Showcase'),
                  _buildDescriptionText(
                    context,
                    'This Storybook serves as an interactive catalog of all the available widgets inside the Digit UI Components library. '
                        'Each widget is showcased with its properties and variations to help developers understand its usage and customization options.',
                  ),

                  const SizedBox(height: 24),

                  // Installation
                  _buildSectionTitle(context, 'Installation'),
                  _buildDescriptionText(
                    context,
                    'To install Digit UI Components, add the following dependency to your `pubspec.yaml`:',
                  ),
                  _buildCodeSnippet(context, """dependencies:\n  digit_ui_components: 0.2.0\n"""),
                  const SizedBox(height: 16),
                  _buildDescriptionText(context, 'Then, fetch dependencies using:'),
                  _buildCodeSnippet(context, "flutter pub get"),
                  const SizedBox(height: 16),

                  // Usage
                  _buildSectionTitle(context, 'Usage'),
                  _buildDescriptionText(context, 'Import the package in your Dart code:'),
                  _buildCodeSnippet(context, """import 'package:digit_ui_components/digit_components.dart';"""),
                  const SizedBox(height: 16),
                  _buildDescriptionText(context, 'Use a component in your project:'),
                  _buildCodeSnippet(
                    context,
                    """DigitTextFormInput(
  label: 'Text Field',
  initialValue: 'value',
  controller: TextEditingController(),
  innerLabel: 'label',
  helpText: 'help text',
  charCount: true,
);""",
                  ),
                  const SizedBox(height: 32),

                  // Features
                  _buildSectionTitle(context, 'Features'),
                  _buildFeatureList(context),
                  const SizedBox(height: 32),

                  // Component Overview
                  _buildSectionTitle(context, 'Component Overview'),
                  _buildDescriptionText(
                    context,
                    '### 🟢 Atoms (Basic UI Elements)\n'
                        '- Buttons\n'
                        '- Text Fields\n'
                        '- Icons\n'
                        '- Checkboxes\n'
                        '- And More\n\n'
                        '### 🔵 Molecules (Combinations of Atoms)\n'
                        '- Form Card\n'
                        '- Cards\n'
                        '- Table\n'
                        '- Hamburger\n'
                        '- And More\n\n'
                        '### 🟠 Wrapper Components (High-Level Structures)\n'
                        '- Table Wrapper\n'
                        '- And More',
                  ),
                  const SizedBox(height: 32),

                  // Documentation
                  _buildSectionTitle(context, 'Documentation'),
                  _buildDescriptionWithLink(
                    context,
                    'Find the full documentation here:',
                    'Digit UI Components Documentation',
                    'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components-v0.2.0',
                  ),
                  const SizedBox(height: 32),


                ],
              ),
            ),
          ],
        );
      },
    ),
  ];
}

// Section Title Widget
Widget _buildSectionTitle(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorTheme.primary.primary2,
    ),
  );
}

// Description Text Widget
Widget _buildDescriptionText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      height: 1.5,
      fontSize: 16,
    ),
  );
}

Widget _buildDescriptionWithLink(BuildContext context, String text, String linkText, String url) {
  return Row(
    children: [
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, fontSize: 16),
      ),
      const SizedBox(width: 4),
      InkWell(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text(
          linkText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.5,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );
}

// Code Snippet Widget with Improved Styling
Widget _buildCodeSnippet(BuildContext context, String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorTheme.paper.secondary,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: SelectableText(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14.0,
        color: Theme.of(context).colorTheme.text.secondary,
      ),
    ),
  );
}

// Feature List Widget with Bullet Points
Widget _buildFeatureList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildFeatureItem(context, '✅ 30+ Atoms (buttons, text fields, icons, etc.)'),
      _buildFeatureItem(context, '✅ 20+ Molecules (form fields, cards, alerts, etc.)'),
      _buildFeatureItem(context, '✅ 5+ Wrapper Components (modals, layouts, templates)'),
      _buildFeatureItem(context, '✅ Built-in validation and theming support'),
      _buildFeatureItem(context, '✅ Designed for scalability and reusability'),
    ],
  );
}

// Feature Item Widget
Widget _buildFeatureItem(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
    ),
  );
}
