import 'package:flutter/material.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> dividerStories() {
  return [
    Story(
      name: 'Atom/Divider/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Divider/small',
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DigitDivider(
            dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
              const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
              const Option(label: 'Vertical', value: DividerOrientation.vertical),
            ]),
            dividerType: DividerType.small,
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Divider/medium',
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DigitDivider(
            dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
              const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
              const Option(label: 'Vertical', value: DividerOrientation.vertical),
            ]),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Divider/large',
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DigitDivider(
            dividerOrientation: context.knobs.options(label: 'Orientation', initial: DividerOrientation.horizontal, options: [
              const Option(label: 'Horizontal', value: DividerOrientation.horizontal),
              const Option(label: 'Vertical', value: DividerOrientation.vertical),
            ]),
            dividerType: DividerType.large,
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Divider/custom',
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DigitDivider(
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
          ),
        );
      },
    ),
  ];
}
