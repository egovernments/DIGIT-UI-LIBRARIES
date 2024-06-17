import 'dart:ui';

import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> checkboxStories() {
  return [
    Story(
      name: 'Atom/Checkbox/Default',
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
      name: 'Atom/Checkbox/Reverse',
      builder: (context) => DigitCheckbox(
        label: context.knobs.text(
          label: 'Label',
          initial: 'Checkbox Label',
        ),
        textDirection: TextDirection.rtl,
        onChanged: (value) {},
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
      ),
    ),
  ];
}