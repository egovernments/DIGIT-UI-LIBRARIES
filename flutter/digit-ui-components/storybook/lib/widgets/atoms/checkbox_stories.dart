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
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
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
