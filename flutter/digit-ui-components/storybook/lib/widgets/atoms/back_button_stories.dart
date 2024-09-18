import 'package:digit_ui_components/theme/ComponentTheme/back_button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_back_button.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> digitBackButtonStories() {
  return [
    Story(
      name: 'Atom/Back Navigation Button/Variant 1',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBackButton(
  handleBack: () {},
  backDigitButtonText: 'Back',
)
          ''');
        });

        return Center(
          child: DigitBackButton(
            handleBack: () {},
            backDigitButtonText: 'Back',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Navigation Button/Variant 2',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBackButton(
  digitBackButtonThemeData: DigitBackButtonThemeData().copyWith(
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
  backDigitButtonText: 'Back',
)
          ''');
        });

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
            backDigitButtonText: 'Back',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Navigation Button/Variant 3',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBackButton(
  handleBack: () {},
  digitBackButtonThemeData: DigitBackButtonThemeData().copyWith(
    context: context,
    backDigitButtonIcon: Icon(
      Icons.arrow_left,
      size: MediaQuery.of(context).size.width < 500
          ? Theme.of(context).spacerTheme.spacer5
          : Theme.of(context).spacerTheme.spacer6,
      color: Theme.of(context).colorTheme.primary.primary2,
    ),
  ),
  backDigitButtonText: 'Back',
)
          ''');
        });

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
            backDigitButtonText: 'Back',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Navigation Button/Disabled',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBackDigitButton()
          ''');
        });

        return const Center(
          child: DigitBackButton(),
        );
      },
    ),
  ];
}
