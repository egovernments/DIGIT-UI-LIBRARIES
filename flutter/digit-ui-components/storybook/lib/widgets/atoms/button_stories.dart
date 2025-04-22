import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> buttonStories() {
  return [
    Story(
      name: 'Atom/Buttons/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components-v0.2.0/atom/checkbox',
        );
      },
    ),
    Story(
      name: 'Atom/Buttons/Primary',
      builder: (context) {

        // Create an option knob for disabled states
        final fieldState = context.knobs.options<String>(
          label: 'State',
          initial: 'Default', // Ensure an initial value is set
          options: [
            Option(label: 'Default', value: 'default'),
            Option(label: 'Disabled', value: 'disabled'),
          ],
        );

        // Set the values for isDisabled based on the selected option
        bool isDisabled = false;

        if (fieldState == 'disabled') {
          isDisabled = true;
        }

        return DigitButton(
          label: context.knobs.text(label: 'Label', initial: 'Primary Button'),
          onPressed: () {},
          type: DigitButtonType.primary,
          isDisabled: isDisabled,
          size: context.knobs.options(
            label: 'Size of button',
            initial: DigitButtonSize.large,
            options: const [
              Option(label: 'Small', value: DigitButtonSize.small),
              Option(label: 'Medium', value: DigitButtonSize.medium),
              Option(label: 'Large', value: DigitButtonSize.large),
            ],
          ),
          semanticLabel: 'Primary Button',
          suffixIcon: context.knobs.nullable.options(
              label: 'Suffix Icon',
              initial: Icons.arrow_forward,
              enabled: false,
              options: [
                const Option(label: 'Arrow', value: Icons.arrow_forward),
                const Option(label: 'Home', value: Icons.home),
                const Option(label: 'Article', value: Icons.article),
                const Option(label: 'Location', value: Icons.my_location)
              ]),
          prefixIcon: context.knobs.nullable.options(
              label: 'Prefix Icon',
              initial: Icons.arrow_back,
              enabled: false,
              options: [
                const Option(label: 'Arrow', value: Icons.arrow_back),
                const Option(label: 'Home', value: Icons.home),
                const Option(label: 'Article', value: Icons.article),
                const Option(label: 'Location', value: Icons.my_location)
              ]),
        );
      },
    ),
    Story(
        name: 'Atom/Buttons/Secondary',
        builder: (context) {

          // Create an option knob for disabled states
          final fieldState = context.knobs.options<String>(
            label: 'State',
            initial: 'Default', // Ensure an initial value is set
            options: [
              Option(label: 'Default', value: 'default'),
              Option(label: 'Disabled', value: 'disabled'),
            ],
          );

          // Set the values for isDisabled based on the selected option
          bool isDisabled = false;

          if (fieldState == 'disabled') {
            isDisabled = true;
          }


          return DigitButton(
            label:
                context.knobs.text(label: 'Label', initial: 'Secondary Button'),
            onPressed: () {
              // Add your secondary DigitButton logic here
            },
            isDisabled: isDisabled,
            type: DigitButtonType.secondary,
            size: context.knobs.options(
              label: 'Size of button',
              initial: DigitButtonSize.large,
              options: const [
                Option(
                  label: 'Small',
                  value: DigitButtonSize.small,
                ),
                Option(
                  label: 'Medium',
                  value: DigitButtonSize.medium,
                ),
                Option(
                  label: 'Large',
                  value: DigitButtonSize.large,
                ),
              ],
            ),
            suffixIcon: context.knobs.nullable.options(
                label: 'Suffix Icon',
                initial: Icons.arrow_forward,
                enabled: false,
                options: [
                  const Option(label: 'Arrow', value: Icons.arrow_forward),
                  const Option(label: 'Home', value: Icons.home),
                  const Option(label: 'Article', value: Icons.article),
                  const Option(label: 'Location', value: Icons.my_location)
                ]),
            prefixIcon: context.knobs.nullable.options(
                label: 'Prefix Icon',
                initial: Icons.arrow_back,
                enabled: false,
                options: [
                  const Option(label: 'Arrow', value: Icons.arrow_back),
                  const Option(label: 'Home', value: Icons.home),
                  const Option(label: 'Article', value: Icons.article),
                  const Option(label: 'Location', value: Icons.my_location)
                ]),
          );
        }),
    Story(
        name: 'Atom/Buttons/Tertiary',
        builder: (context) {

          // Create an option knob for disabled states
          final fieldState = context.knobs.options<String>(
            label: 'State',
            initial: 'Default', // Ensure an initial value is set
            options: [
              Option(label: 'Default', value: 'default'),
              Option(label: 'Disabled', value: 'disabled'),
            ],
          );

          // Set the values for isDisabled based on the selected option
          bool isDisabled = false;

          if (fieldState == 'disabled') {
            isDisabled = true;
          }


          return DigitButton(
            label:
                context.knobs.text(label: 'Label', initial: 'Tertiary Button'),
            onPressed: () {
              // Add your secondary DigitButton logic here
            },
            isDisabled: isDisabled,
            type: DigitButtonType.tertiary,
            size: context.knobs.options(
              label: 'Size of DigitButton',
              initial: DigitButtonSize.large,
              options: const [
                Option(
                  label: 'Small',
                  value: DigitButtonSize.small,
                ),
                Option(
                  label: 'Medium',
                  value: DigitButtonSize.medium,
                ),
                Option(
                  label: 'Large',
                  value: DigitButtonSize.large,
                ),
              ],
            ),
            suffixIcon: context.knobs.nullable.options(
                label: 'Suffix Icon',
                initial: Icons.arrow_forward,
                enabled: false,
                options: [
                  const Option(label: 'Arrow', value: Icons.arrow_forward),
                  const Option(label: 'Home', value: Icons.home),
                  const Option(label: 'Article', value: Icons.article),
                  const Option(label: 'Location', value: Icons.my_location)
                ]),
            prefixIcon: context.knobs.nullable.options(
                label: 'Prefix Icon',
                initial: Icons.arrow_back,
                enabled: false,
                options: [
                  const Option(label: 'Arrow', value: Icons.arrow_back),
                  const Option(label: 'Home', value: Icons.home),
                  const Option(label: 'Article', value: Icons.article),
                  const Option(label: 'Location', value: Icons.my_location)
                ]),
          );
        }),
    Story(
        name: 'Atom/Buttons/Link',
        builder: (context) {

          // Create an option knob for disabled states
          final fieldState = context.knobs.options<String>(
            label: 'State',
            initial: 'Default', // Ensure an initial value is set
            options: [
              Option(label: 'Default', value: 'default'),
              Option(label: 'Disabled', value: 'disabled'),
            ],
          );

          // Set the values for isDisabled based on the selected option
          bool isDisabled = false;

          if (fieldState == 'disabled') {
            isDisabled = true;
          }


          return DigitButton(
            label: context.knobs.text(label: 'Label', initial: 'link'),
            onPressed: () {
              // Add your secondary DigitButton logic here
            },
            isDisabled: isDisabled,
            type: DigitButtonType.link,
            size: context.knobs.options(
              label: 'Size of DigitButton',
              initial: DigitButtonSize.large,
              options: const [
                Option(
                  label: 'Small',
                  value: DigitButtonSize.small,
                ),
                Option(
                  label: 'Medium',
                  value: DigitButtonSize.medium,
                ),
                Option(
                  label: 'Large',
                  value: DigitButtonSize.large,
                ),
              ],
            ),
            suffixIcon: context.knobs.nullable.options(
                label: 'Suffix Icon',
                initial: Icons.arrow_forward,
                enabled: false,
                options: [
                  const Option(label: 'Arrow', value: Icons.arrow_forward),
                  const Option(label: 'Home', value: Icons.home),
                  const Option(label: 'Article', value: Icons.article),
                  const Option(label: 'Location', value: Icons.my_location)
                ]),
            prefixIcon: context.knobs.nullable.options(
                label: 'Prefix Icon',
                initial: Icons.arrow_back,
                enabled: false,
                options: [
                  const Option(label: 'Arrow', value: Icons.arrow_back),
                  const Option(label: 'Home', value: Icons.home),
                  const Option(label: 'Article', value: Icons.article),
                  const Option(label: 'Location', value: Icons.my_location)
                ]),
          );
        }),
  ];
}
