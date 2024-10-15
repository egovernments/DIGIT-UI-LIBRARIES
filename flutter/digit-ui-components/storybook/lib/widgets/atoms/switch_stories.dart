import 'package:digit_ui_components/theme/ComponentTheme/switch_theme.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> switchStories() {
  return [
    Story(
      name: 'Atom/Switch/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Switch/Basic',
      builder: (context) {
        bool isSwitched = false;

        // Create an option knob for read-only and disabled states
        final fieldState = context.knobs.options<String>(
          label: 'Field State',
          initial: 'Default', // Ensure an initial value is set
          options: [
            Option(label: 'Default', value: 'default'),
            Option(label: 'Non Editable', value: 'readOnly'),
            Option(label: 'Disabled', value: 'disabled'),
          ],
        );

        return StatefulBuilder(
          builder: (context, setState) {
            return DigitSwitch(
              value: context.knobs.boolean(label: 'value', initial: false),
              label: context.knobs.text(label: 'Switch label', initial: 'Label'),
              readonly: fieldState == 'readOnly',
              disabled: fieldState == 'disabled',
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/with symbol',
      builder: (context) {
        bool isSwitched = false;

        // Create an option knob for read-only and disabled states
        final fieldState = context.knobs.options<String>(
          label: 'Field State',
          initial: 'Default',
          options: [
            Option(label: 'Default', value: 'default'),
            Option(label: 'Non Editable', value: 'readOnly'),
            Option(label: 'Disabled', value: 'disabled'),
          ],
        );

        return StatefulBuilder(
          builder: (context, setState) {
            return DigitSwitch(
              value: context.knobs.boolean(label: 'value', initial: false),
              showSymbol: true,
              label: context.knobs.text(label: 'Switch label', initial: 'Label'),
              readonly: fieldState == 'readOnly',
              disabled: fieldState == 'disabled',
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/Custom',
      builder: (context) {
        bool isSwitched = false;

        // Create an option knob for read-only and disabled states
        final fieldState = context.knobs.options<String>(
          label: 'Field State',
          initial: 'Default',
          options: [
            Option(label: 'Default', value: 'default'),
            Option(label: 'Non Editable', value: 'readOnly'),
            Option(label: 'Disabled', value: 'disabled'),
          ],
        );

        return StatefulBuilder(
          builder: (context, setState) {
            return DigitSwitch(
              value: context.knobs.boolean(label: 'value', initial: false),
              label: context.knobs.text(label: 'Switch label', initial: 'Label'),
              themeData: const DigitSwitchThemeData().copyWith(
                activeColor: Colors.red,
                trackWidth: 50,
                trackHeight: 24,
                symbolColor: Colors.blue,
                animationValue: 27,
              ),
              readonly: fieldState == 'readOnly',
              disabled: fieldState == 'disabled',
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
  ];
}
