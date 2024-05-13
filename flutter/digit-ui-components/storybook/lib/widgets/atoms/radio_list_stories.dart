import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/atoms/digit_radio_list.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> radioListStories() {
  return [
    Story(
      name: 'Atom/Radio List',
      builder: (context) => RadioList(
        onChanged: (value) {
          // print(value);
        },
        isDisabled: context.knobs.boolean(
          label: 'disabled',
          initial: false,
        ),
        radioButtons: [
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
  ];
}