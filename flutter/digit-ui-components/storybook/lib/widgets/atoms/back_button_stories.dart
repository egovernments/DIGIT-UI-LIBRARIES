import 'package:digit_ui_components/theme/ComponentTheme/back_button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_back_button.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';
import '../../iframe/iframe_widget.dart';


List<Story> digitBackButtonStories() {
  return [
    Story(
      name: 'Atom/Back Link/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Back Link/Backlink 1',
      builder: (context) {

        bool disabled = context.knobs.boolean(label: 'Disabled', initial: false);

        return Center(
          child: DigitBackButton(
            handleBack: disabled ? null : () {},
            digitBackButtonThemeData:
            const DigitBackButtonThemeData().copyWith(
              context: context,
              disabledBackDigitButtonIcon: Icon(
                Icons.arrow_left,
                size: MediaQuery.of(context).size.width < 500
                    ? Theme.of(context).spacerTheme.spacer5
                    : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.text.disabled,
              ),
              backDigitButtonIcon: Icon(
                Icons.arrow_left,
                size: MediaQuery.of(context).size.width < 500
                    ? Theme.of(context).spacerTheme.spacer5
                    : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.primary.primary2,
              ),
            ),
            label: context.knobs.text(label: 'Label', initial: 'Back'),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Link/Backlink 2',
      builder: (context) {
        bool disabled = context.knobs.boolean(label: 'Disabled', initial: false);

        return Center(
          child: DigitBackButton(
            digitBackButtonThemeData:
            const DigitBackButtonThemeData().copyWith(
              context: context,
              disabledBackDigitButtonIcon: Icon(
              Icons.arrow_circle_left_outlined,
              size: MediaQuery.of(context).size.width < 500
                  ? Theme.of(context).spacerTheme.spacer5
                  : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.text.disabled,
            ),
              backDigitButtonIcon: Icon(
                Icons.arrow_circle_left_outlined,
                size: MediaQuery.of(context).size.width < 500
                    ? Theme.of(context).spacerTheme.spacer5
                    : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.primary.primary2,
              ),
            ),
            handleBack: disabled ? null : () {},
            label: context.knobs.text(label: 'Label', initial: 'Back'),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Link/Backlink 3',
      builder: (context) {

        bool disabled = context.knobs.boolean(label: 'Disabled', initial: false);

        return Center(
          child: DigitBackButton(
            handleBack: disabled ? null : () {},
            label: context.knobs.text(label: 'Label', initial: 'Back'),
          ),
        );
      },
    ),
  ];
}
