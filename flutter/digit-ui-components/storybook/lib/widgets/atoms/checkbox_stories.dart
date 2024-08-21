import 'package:flutter/material.dart';
import 'package:digit_ui_components/theme/ComponentTheme/checkbox_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> checkboxStories() {
  return [
    Story(
      name: 'Atom/Checkbox/Default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitCheckbox(
  label: Checkbox,
  onChanged: (value) {},
  isDisabled: false,
)
          ''');
        });

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DigitCheckbox(
                label: context.knobs.text(
                  label: 'Label',
                  initial:
                      'The HTML defaultChecked property is used to return the default value of the checked attribute. It has a boolean value that returns true if the checkbox is checked by default, otherwise returns false.',
                ),
                onChanged: (value) {},
                isDisabled: context.knobs.boolean(
                  label: 'Disabled',
                  initial: false,
                ),
              ),
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/Checkbox/Reverse',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitCheckbox(
  checkboxThemeData: const DigitCheckboxThemeData().copyWith(
    context: context,
    labelTextDirection: TextDirection.rtl,
  ),
  label: Checkbox,
  onChanged: (value) {},
  isDisabled: false,
)
          ''');
        });

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: DigitCheckbox(
                checkboxThemeData: const DigitCheckboxThemeData().copyWith(
                  context: context,
                  labelTextDirection: TextDirection.rtl,
                ),
                label: context.knobs.text(
                  label: 'Label',
                  initial:
                      'The HTML defaultChecked property is used to return the default value of the checked attribute. It has a boolean value that returns true if the checkbox is checked by default, otherwise returns false.',
                ),
                onChanged: (value) {},
                isDisabled: context.knobs.boolean(
                  label: 'Disabled',
                  initial: false,
                ),
              ),
            ),
          ],
        );
      },
    ),
  ];
}
