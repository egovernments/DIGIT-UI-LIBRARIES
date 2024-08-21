import 'package:digit_ui_components/theme/ComponentTheme/back_button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_back_button.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> backNavigationButtonStories() {
  return [
    Story(
      name: 'Atom/Back Navigation Button/Variant 1',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
BackNavigationButton(
  handleBack: () {},
  backButtonText: 'Back',
)
          ''');
        });

        return Center(
          child: BackNavigationButton(
            handleBack: () {},
            backButtonText: 'Back',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Navigation Button/Variant 2',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
BackNavigationButton(
  backNavigationButtonThemeData: BackNavigationButtonThemeData().copyWith(
    context: context,
    backButtonIcon: Icon(
      Icons.arrow_circle_left_outlined,
      size: MediaQuery.of(context).size.width < 500
          ? Theme.of(context).spacerTheme.spacer5
          : Theme.of(context).spacerTheme.spacer6,
      color: Theme.of(context).colorTheme.primary.primary2,
    ),
  ),
  handleBack: () {},
  backButtonText: 'Back',
)
          ''');
        });

        return Center(
          child: BackNavigationButton(
            backNavigationButtonThemeData:
            const BackNavigationButtonThemeData().copyWith(
              context: context,
              backButtonIcon: Icon(
                Icons.arrow_circle_left_outlined,
                size: MediaQuery.of(context).size.width < 500
                    ? Theme.of(context).spacerTheme.spacer5
                    : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.primary.primary2,
              ),
            ),
            handleBack: () {},
            backButtonText: 'Back',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Navigation Button/Variant 3',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
BackNavigationButton(
  handleBack: () {},
  backNavigationButtonThemeData: BackNavigationButtonThemeData().copyWith(
    context: context,
    backButtonIcon: Icon(
      Icons.arrow_left,
      size: MediaQuery.of(context).size.width < 500
          ? Theme.of(context).spacerTheme.spacer5
          : Theme.of(context).spacerTheme.spacer6,
      color: Theme.of(context).colorTheme.primary.primary2,
    ),
  ),
  backButtonText: 'Back',
)
          ''');
        });

        return Center(
          child: BackNavigationButton(
            handleBack: () {},
            backNavigationButtonThemeData:
            const BackNavigationButtonThemeData().copyWith(
              context: context,
              backButtonIcon: Icon(
                Icons.arrow_left,
                size: MediaQuery.of(context).size.width < 500
                    ? Theme.of(context).spacerTheme.spacer5
                    : Theme.of(context).spacerTheme.spacer6,
                color: Theme.of(context).colorTheme.primary.primary2,
              ),
            ),
            backButtonText: 'Back',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Back Navigation Button/Disabled',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
BackNavigationButton()
          ''');
        });

        return const Center(
          child: BackNavigationButton(),
        );
      },
    ),
  ];
}
