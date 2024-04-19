import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> buttonStories() {
  return [
    Story(
      name: 'Buttons/Primary',
      builder: (context) => Button(
        label: context.knobs.text(label: 'Label', initial: 'Primary Button'),
        onPressed: () {
          // Add your primary button logic here
        },
        type: ButtonType.primary,
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        size: context.knobs.options(
          label: 'Size of Button',
          initial: ButtonSize.small,
          options: const [
            Option(
              label: 'Small',
              value: ButtonSize.small,
            ),
            Option(
              label: 'Medium',
              value: ButtonSize.medium,
            ),
            Option(
              label: 'Large',
              value: ButtonSize.large,
            ),
          ],
        ),
        suffixIcon: context.knobs.nullable.options(label: 'Suffix Icon', initial: Icons.arrow_forward),
        prefixIcon: context.knobs.nullable.options(label: 'Prefix Icon', initial: Icons.arrow_forward),
      ),
    ),

    Story(
      name: 'Buttons/Secondary',
      builder: (context) => Button(
        label: context.knobs.text(label: 'Label', initial: 'Secondary Button'),
        onPressed: () {
          // Add your secondary button logic here
        },
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        type: ButtonType.secondary,
        size: context.knobs.options(
          label: 'Size of Button',
          initial: ButtonSize.small,
          options: const [
            Option(
              label: 'Small',
              value: ButtonSize.small,
            ),
            Option(
              label: 'Medium',
              value: ButtonSize.medium,
            ),
            Option(
              label: 'Large',
              value: ButtonSize.large,
            ),
          ],
        ),
        suffixIcon: context.knobs.nullable.options(label: 'Suffix Icon', initial: Icons.arrow_forward),
        prefixIcon: context.knobs.nullable.options(label: 'Prefix Icon', initial: Icons.arrow_forward),
      ),
    ),
    Story(
      name: 'Buttons/Tertiary',
      builder: (context) => Button(
        label: context.knobs.text(label: 'Label', initial: 'Tertiary Button'),
        onPressed: () {
          // Add your secondary button logic here
        },
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        type: ButtonType.tertiary,
        size: context.knobs.options(
          label: 'Size of Button',
          initial: ButtonSize.small,
          options: const [
            Option(
              label: 'Small',
              value: ButtonSize.small,
            ),
            Option(
              label: 'Medium',
              value: ButtonSize.medium,
            ),
            Option(
              label: 'Large',
              value: ButtonSize.large,
            ),
          ],
        ),
        suffixIcon: context.knobs.nullable.options(label: 'Suffix Icon', initial: Icons.arrow_forward),
        prefixIcon: context.knobs.nullable.options(label: 'Prefix Icon', initial: Icons.arrow_forward),
      ),
    ),
    Story(
      name: 'Buttons/Link',
      builder: (context) => Button(
        label: context.knobs.text(label: 'Label', initial: 'link'),
        onPressed: () {
          // Add your secondary button logic here
        },
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        type: ButtonType.link,
        size: context.knobs.options(
          label: 'Size of Button',
          initial: ButtonSize.small,
          options: const [
            Option(
              label: 'Small',
              value: ButtonSize.small,
            ),
            Option(
              label: 'Medium',
              value: ButtonSize.medium,
            ),
            Option(
              label: 'Large',
              value: ButtonSize.large,
            ),
          ],
        ),
        suffixIcon: context.knobs.nullable.options(label: 'Suffix Icon', initial: Icons.arrow_forward),
        prefixIcon: context.knobs.nullable.options(label: 'Prefix Icon', initial: Icons.arrow_forward),
      ),
    ),
  ];
}
