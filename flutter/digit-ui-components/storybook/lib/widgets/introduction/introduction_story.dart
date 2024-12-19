import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> introStories() {
  return [
    Story(
      name: 'Introduction/doc',
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title of the Intro Page
              Text(
                'Welcome to Flutter Storybook',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Overview Section
              _buildSectionTitle(context, 'Overview'),
              _buildDescriptionText(context,
                  'This Flutter Storybook is designed to help developers create and test UI components interactively. '
                      'It provides a way to preview widgets with different states and configurations.'),
              const SizedBox(height: 16),

              // Configuration Section
              _buildSectionTitle(context, 'Configuration'),
              _buildDescriptionText(context,
                  'To configure the Storybook for Flutter, follow these steps:'),
              const SizedBox(height: 16),

              // Code Snippet for Configuration
              _buildCodeSnippet(
                  context,
                  '''
dependencies:
  storybook_flutter: ^0.1.0
  flutter:
    sdk: flutter
                '''
              ),
              const SizedBox(height: 16),

              _buildDescriptionText(context,
                  'Once installed, wrap your root widget with `StorybookAppWrapper` to integrate Storybook into your Flutter project.'),

              // Code for wrapping widget
              _buildCodeSnippet(
                  context,
                  '''
void main() {
  runApp(StorybookAppWrapper(
    child: MyApp(),
  ));
}
                '''
              ),

              const SizedBox(height: 32),

              // Adding stories section
              _buildSectionTitle(context, 'Adding Stories'),
              _buildDescriptionText(context,
                  'To add stories, create a new story using the `Story` widget and add it to your Storybook list:'),
              _buildCodeSnippet(
                  context,
                  '''
Story(
  name: 'Button',
  builder: (_) => MyButton(),
),
                '''
              ),
            ],
          ),
        );
      },
    ),
  ];
}

// Helper function to build section titles
Widget _buildSectionTitle(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
  );
}

// Helper function to build description text
Widget _buildDescriptionText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
  );
}

// Helper function to build code snippets with styling
Widget _buildCodeSnippet(BuildContext context, String code) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: SelectableText(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14.0,
        color: Colors.black87,
      ),
    ),
  );
}
