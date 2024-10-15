import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> menuCardStories() {
  return [
    Story(
      name: 'Atom/Menu Card/Variant First/1',
      builder: (context) =>  MenuCard(
        icon: Icons.home,
        heading: context.knobs.text(label: 'Heading', initial: 'Home'),
        onTap: () {
          // Handle tap
        },
      ),
    ),
    Story(
      name: 'Atom/Menu Card/Variant First/2',
      builder: (context) =>  MenuCard(
        icon: Icons.settings,
        heading: context.knobs.text(label: 'Heading', initial: 'Settings'),
        description: context.knobs.text(label: 'Description', initial: 'This is the settings page.'),
        onTap: () {
          // Handle tap
        },
      ),
    ),
    Story(
      name: 'Atom/Menu Card/Variant First/3',
      builder: (context) =>  MenuCard(
        icon: Icons.settings,
        heading: context.knobs.text(label: 'Heading', initial: 'Settings'),
        description: context.knobs.text(label: 'Description', initial: 'This is the settings page.'),
      ),
    ),
  ];
}