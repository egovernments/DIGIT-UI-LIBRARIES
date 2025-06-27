import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import '../../iframe/iframe_widget.dart';

List<Story> checkboxStories() {
  return [
    Story(
      name: 'Atom/Checkbox/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components-v0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Checkbox/Unchecked',
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DigitCheckbox(
                value: false,
                label: context.knobs.text(
                  label: 'Label',
                  initial: 'checkbox label',
                ),
                onChanged: (value) {},
                readOnly: context.knobs.boolean(
                  label: 'Read Only',
                  initial: false,
                ),
                isDisabled: context.knobs.boolean(
                  label: 'Disabled',
                  initial: false,
                ),
                alignRight: context.knobs.boolean(label: 'Align Right', initial: false),
                isRequired: context.knobs.boolean(label: 'Required', initial: false),
              ),
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/Checkbox/Checked',
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DigitCheckbox(
                label: context.knobs.text(
                  label: 'Label',
                  initial: 'checkbox label',
                ),
                value: true,
                onChanged: (value) {},
                readOnly: context.knobs.boolean(
                  label: 'Read Only',
                  initial: false,
                ),
                isDisabled: context.knobs.boolean(
                  label: 'Disabled',
                  initial: false,
                ),
                alignRight: context.knobs.boolean(label: 'Align Right', initial: false),
              ),
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/Checkbox/Intermediate',
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DigitCheckbox(
                label: context.knobs.text(
                  label: 'Label',
                  initial: 'checkbox label',
                ),
                onChanged: (value) {},
                readOnly: context.knobs.boolean(
                  label: 'Read Only',
                  initial: false,
                ),
                isDisabled: context.knobs.boolean(
                  label: 'Disabled',
                  initial: false,
                ),
                alignRight: context.knobs.boolean(label: 'Align Right', initial: false),
              ),
            ),
          ],
        );
      },
    ),
  ];
}
