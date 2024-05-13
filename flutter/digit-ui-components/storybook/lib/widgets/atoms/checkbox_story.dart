import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> checkboxStories() {
  return [
    Story(
      name: 'Atom/Checkbox/default',
      builder: (context) => DigitCheckbox(
        label: context.knobs.text(
          label: 'Label',
          initial: 'Checkbox Label',
        ),
        onChanged: (value) {},
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
      ),
    ),
    Story(
      name: 'Atom/Checkbox/Selected',
      builder: (context) => DigitCheckbox(
        label: context.knobs.text(
          label: 'Label',
          initial: 'Checkbox Label',
        ),
        value: true,
        onChanged: (value) {},
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
      ),
    ),
  ];
}
