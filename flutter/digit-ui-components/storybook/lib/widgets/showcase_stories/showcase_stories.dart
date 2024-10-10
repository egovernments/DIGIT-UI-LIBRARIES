import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/showcase/showcase.dart';
import 'package:digit_ui_components/widgets/showcase/showcase_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> showcaseStories() {
  final showcaseKey = GlobalKey<ShowcaseState>();

  return [
    Story(
      name: 'ShowCase',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Showcase Example'),
            actions: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  showcaseKey.currentState?.startShowcaseDemo();
                },
              ),
            ],
          ),
          body: Column(
            children: [
              ShowcaseWrapper(
                contentHeading: 'Floating Action Button',
                contentDescription: 'This button is used to add new items.',
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              ),
              SizedBox(height: 20),
              ShowcaseWrapper(
                contentHeading: 'Sample Button',
                contentDescription:
                    'This is a sample button that demonstrates a typical user action.',
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Click Me'),
                ),
              ),
              SizedBox(height: 20),
              ShowcaseWrapper(
                contentHeading: 'Info Icon',
                contentDescription:
                    'This is an information icon to provide additional context.',
                child: Icon(
                  Icons.info,
                  size: 32,
                  color: theme.primaryColor,
                ),
              )
            ],
          ),
        );
      },
    )
  ];
}
