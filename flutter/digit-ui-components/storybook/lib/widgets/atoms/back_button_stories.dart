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
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Back Link/Double arrow',
      builder: (context) {

        return Center(
          child: DigitBackButton(
            handleBack: () {},
            label: context.knobs.text(label: 'Label', initial: 'Back'),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Link/Arrow with circle',
      builder: (context) {
        return Center(
          child: DigitBackButton(
            digitBackButtonThemeData:
            const DigitBackButtonThemeData().copyWith(
              context: context,
              backDigitButtonIcon: Icon(
                Icons.arrow_circle_left_outlined,
                size: MediaQuery.of(context).size.width < 500
                    ? Theme.of(context).spacerTheme.spacer5
                    : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.primary.primary2,
              ),
            ),
            handleBack: () {},
            label: context.knobs.text(label: 'Label', initial: 'Back'),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Link/Simple arrow',
      builder: (context) {

        return Center(
          child: DigitBackButton(
            handleBack: () {},
            digitBackButtonThemeData:
            const DigitBackButtonThemeData().copyWith(
              context: context,
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
      name: 'Atom/Back Link/Disabled',
      builder: (context) {
        return  Center(
          child: DigitBackButton(label:  context.knobs.text(label: 'Label', initial: 'Back'),),
        );
      },
    ),
  ];
}
