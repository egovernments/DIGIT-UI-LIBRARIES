import 'package:digit_ui_components/widgets/atoms/digit_chip.dart';
import 'package:digit_ui_components/widgets/atoms/digit_tab.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';
List<Story> tabStories() {
  return [
    Story(
        name: 'Atom/Tab/Default',
        builder: (context) => DigitTabBar(
          tabs:  [context.knobs.text(label: 'Tab 1', initial: 'Tab 1'), context.knobs.text(label: 'Tab 2', initial: 'Tab 2'), context.knobs.text(label: 'Tab 3', initial: 'Tab 3')],
          initialIndex: 1, // Preselect the second tab
          onTabSelected: (index) {
            print('Selected Tab Index: $index');
            // Handle tab selection change
          },
        )
    ),
  ];
}