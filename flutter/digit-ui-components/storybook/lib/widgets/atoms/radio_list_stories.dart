import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/widgets/atoms/digit_radio_list.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> radioListStories() {
  return [
    Story(
      name: 'Atom/Radio List/Default',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RadioList(
              onChanged: (value) {
                // print(value);
              },
              isDisabled: context.knobs.boolean(
                label: 'disabled',
                initial: false,
              ),
              radioDigitButtons: [
                RadioButtonModel(
                    code: '',
                    name: context.knobs
                        .text(label: 'name1', initial: "one")),
                RadioButtonModel(
                    code: '2',
                    name: context.knobs
                        .text(label: 'name2', initial: "two")),
                RadioButtonModel(
                    code: '3',
                    name: context.knobs
                        .text(label: 'name3', initial: "three")),
              ],
            ),
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Radio List/Error Message',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RadioList(
              onChanged: (value) {
                // print(value);
              },
              isDisabled: context.knobs.boolean(
                label: 'disabled',
                initial: false,
              ),
              errorMessage: context.knobs.text(label: 'Error Message', initial: "Please select an option"),
              radioDigitButtons: [
                RadioButtonModel(
                    code: '',
                    name: context.knobs
                        .text(label: 'name1', initial: "one")),
                RadioButtonModel(
                    code: '2',
                    name: context.knobs
                        .text(label: 'name2', initial: "two")),
                RadioButtonModel(
                    code: '3',
                    name: context.knobs
                        .text(label: 'name3', initial: "three")),
              ],
            ),
          ),
        ],
      ),
    ),
  ];
}