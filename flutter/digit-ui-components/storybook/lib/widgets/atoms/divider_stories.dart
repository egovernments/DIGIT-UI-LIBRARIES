import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> dividerStories() {
  return [
    Story(
      name: 'Atom/Divider/small',
      builder: (context) => const DigitDivider(dividerType: DividerType.small,
      ),
    ),
    Story(
      name: 'Atom/Divider/medium',
      builder: (context) => const DigitDivider(),
    ),
    Story(
      name: 'Atom/Divider/large',
      builder: (context) => const DigitDivider(
        dividerType: DividerType.large,
      ),
    ),
    Story(
      name: 'Atom/Divider/custom',
      builder: (context) =>  DigitDivider(
        dividerThemeData: const DigitDividerThemeData().copyWith(
          color: Colors.blue,
          indent: 20,
          endIndent: 30,
          width: 400,
        ),
      ),
    ),
  ];
}