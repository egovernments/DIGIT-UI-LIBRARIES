import 'package:digit_ui_components/models/toggleButtonModel.dart';
import 'package:digit_ui_components/widgets/atoms/digit_toggle_list.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> toggleGroupStories() {
  return [
    Story(
      name: 'Atom/Toggle/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Toggle/Basic',
      builder: (context) => ToggleList(
        mainAxisAlignment: MainAxisAlignment.center,
        selectedIndex: 0,
        toggleDigitButtons: [
          ToggleButtonModel(
              name: context.knobs.text(
                  label: 'Toggle1', initial: 'toggle1'),
              code: 'key1'),
          ToggleButtonModel(
              name: context.knobs.text(
                  label: 'Toggle2', initial: 'toggle2'),
              code: 'key1'),
          ToggleButtonModel(
              name: context.knobs.text(
                  label: 'Toggle3', initial: 'toggle3'),
              code: 'key1'),
        ],
        onChanged: (selectedValues) {
          print(Theme.of(context).primaryColor);
        },
      ),
    ),
    Story(
      name: 'Atom/Toggle/Custom',
      builder: (context) => ToggleList(
        mainAxisAlignment: MainAxisAlignment.center,
        selectedIndex: 0,
        toggleDigitButtons: [
          ToggleButtonModel(
              name: context.knobs.text(
                  label: 'Toggle1', initial: 'toggle1'),
              code: 'key1'),
          ToggleButtonModel(
              name: context.knobs.text(
                  label: 'Toggle2', initial: 'toggle2'),
              code: 'key1'),
          ToggleButtonModel(
              name: context.knobs.text(
                  label: 'Toggle3', initial: 'toggle3'),
              code: 'key1'),
        ],
        onChanged: (selectedValues) {},
      ),
    ),
  ];
}