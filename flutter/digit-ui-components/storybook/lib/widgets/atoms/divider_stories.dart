import 'package:flutter/material.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> dividerStories() {
  return [
    Story(
      name: 'Atom/Divider/small',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitDivider(
  dividerType: DividerType.small,
)
          ''');
        });

        return DigitDivider(
          dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
            const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
            const Option(label: 'Vertical', value: DividerOrientation.vertical),
          ]),
          dividerType: DividerType.small,
        );
      },
    ),
    Story(
      name: 'Atom/Divider/medium',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitDivider()
          ''');
        });

        return DigitDivider(
          dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
            const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
            const Option(label: 'Vertical', value: DividerOrientation.vertical),
          ]),
        );
      },
    ),
    Story(
      name: 'Atom/Divider/large',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitDivider(
  dividerType: DividerType.large,
)
          ''');
        });

        return DigitDivider(
          dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
            const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
            const Option(label: 'Vertical', value: DividerOrientation.vertical),
          ]),
          dividerType: DividerType.large,
        );
      },
    ),
    Story(
      name: 'Atom/Divider/custom',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitDivider(
  dividerThemeData: const DigitDividerThemeData().copyWith(
    color: Colors.blue,
    indent: 20,
    endIndent: 30,
    width: 400,
  ),
)
          ''');
        });

        return DigitDivider(
          dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
            const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
            const Option(label: 'Vertical', value: DividerOrientation.vertical),
          ]),
          dividerThemeData: const DigitDividerThemeData().copyWith(
            color: Colors.blue,
            indent: 20,
            endIndent: 30,
            width: 400,
          ),
        );
      },
    ),
  ];
}
