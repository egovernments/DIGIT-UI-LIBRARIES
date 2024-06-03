import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/atoms/digit_header.dart';
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
      builder: (context) => const DigitDivider(
        thickness: 2.0,
        color: Colors.red,
        width: 100.0, // Custom width
      ),
    ),
  ];
}
