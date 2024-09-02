import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/digit_theme_wrapper.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> buttonStories() {
  return [
    Story(
      name: 'Atom/Buttons/Primary',
      wrapperBuilder: (context, child) => DigitThemeWrapper(
        child: child ?? Container(),
      ),
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Button(
  label: 'Primary Button',
  onPressed: () {},
  type: ButtonType.primary,
  isDisabled: false,
  size: ButtonSize.large,
)
          ''');
        });

        return Button(
          label: context.knobs.text(label: 'Label', initial: 'Primary Button'),
          onPressed: () {},
          type: ButtonType.primary,
          isDisabled: context.knobs.boolean(
            label: 'disable',
            initial: false,
          ),
          size: context.knobs.options(
            label: 'Size of Button',
            initial: ButtonSize.large,
            options: const [
              Option(label: 'Small', value: ButtonSize.small),
              Option(label: 'Medium', value: ButtonSize.medium),
              Option(label: 'Large', value: ButtonSize.large),
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
      },
    ),
    Story(
        name: 'Atom/Buttons/Secondary',
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
Button(
  label: 'Secondary Button',
  onPressed: () {},
  type: ButtonType.secondary,
  isDisabled: false,
  size: ButtonSize.large,
)
          ''');
          });
          return Button(
            label:
                context.knobs.text(label: 'Label', initial: 'Secondary Button'),
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
              initial: ButtonSize.large,
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
Button(
  label: 'Tertiary Button',
  onPressed: () {},
  type: ButtonType.tertiary,
  isDisabled: false,
  size: ButtonSize.large,
)
          ''');
          });
          return Button(
            label:
                context.knobs.text(label: 'Label', initial: 'Tertiary Button'),
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
              initial: ButtonSize.large,
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
Button(
  label: 'link',
  onPressed: () {},
  type: ButtonType.link,
  isDisabled: false,
  size: ButtonSize.large,
)
          ''');
          });
          return Button(
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
              initial: ButtonSize.large,
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
