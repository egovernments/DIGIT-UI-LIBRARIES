import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/helper_widget/button_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> digitButtonListStories() {
  return [
    Story(
      name: 'Molecule/Button Group/default',
      builder: (context) {

        return DigitButtonListTile(
          buttons: [
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
          ],
        );
      },
    ),
    Story(
      name: 'Molecule/Button Group/start',
      builder: (context) {

        return DigitButtonListTile(
          alignment: MainAxisAlignment.start,
          buttons: [
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
          ],
        );
      },
    ),
    Story(
      name: 'Molecule/Button Group/end',
      builder: (context) {

        return DigitButtonListTile(
          alignment: MainAxisAlignment.end,
          buttons: [
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            DigitButton(label: 'Primary', onPressed: () {}, type: DigitButtonType.primary, size: DigitButtonSize.large),
          ],
        );
      },
    ),
  ];
}
