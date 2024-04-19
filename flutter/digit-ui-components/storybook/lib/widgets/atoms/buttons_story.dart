import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> buttonStories() {
  return [
    Story(
      name: 'Buttons/Primary',
      builder: (context) => Button(
        label: context.knobs
            .text(label: 'Label', initial: 'Primary Button'),
        onPressed: () {
          // Add your primary button logic here
        },
        type: ButtonType.primary,
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        size: context.knobs.options(label: 'Size of Button', initial: ButtonSize.small,)
      ),
    ),
    Story(
      name: 'Buttons/Secondary',
      builder: (context) => Button(
        size: ButtonSize.large,
        label: context.knobs.text(
            label: 'Label', initial: 'Secondary Button'),
        onPressed: () {
          // Add your secondary button logic here
        },
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        type: ButtonType.secondary,
      ),
    ),
    Story(
      name: 'Buttons/Tertiary',
      builder: (context) => Button(
        size: ButtonSize.large,
        label: context.knobs.text(
            label: 'Label', initial: 'Tertiary Button'),
        onPressed: () {
          // Add your secondary button logic here
        },
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        type: ButtonType.tertiary,
      ),
    ),
    Story(
      name: 'Buttons/Link',
      builder: (context) => Button(
        size: ButtonSize.large,
        label: context.knobs
            .text(label: 'Label', initial: 'link'),
        onPressed: () {
          // Add your secondary button logic here
        },
        isDisabled: context.knobs.boolean(
          label: 'disable',
          initial: false,
        ),
        type: ButtonType.link,
      ),
    ),
  ];
}
