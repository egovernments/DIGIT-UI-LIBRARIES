import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_tab.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> tabStories() {
  return [
    Story(
      name: 'Atom/Tab/Default',
      builder: (context) {

        return DigitTabBar(
          tabs:  [context.knobs.text(label: 'Tab 1', initial: 'Tab 1'), context.knobs.text(label: 'Tab 2', initial: 'Tab 2'), context.knobs.text(label: 'Tab 3', initial: 'Tab 3')],
          initialIndex: 1,
          onTabSelected: (index) {
            // Handle tab selection change
          },
        );
      },
    ),
  ];
}
