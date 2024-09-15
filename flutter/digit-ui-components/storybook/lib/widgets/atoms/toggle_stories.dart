import 'package:digit_ui_components/models/toggleButtonModel.dart';
import 'package:digit_ui_components/widgets/atoms/digit_toggle_list.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> toggleGroupStories() {
  return [
    Story(
      name: 'Atom/Toggle Group',
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