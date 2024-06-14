import 'package:digit_ui_components/widgets/atoms/back_button.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> backNavigationButtonStories() {
  return [
    Story(
      name: 'Atom/backNavigationButton/1',
      builder: (context) =>  Center(
        child: BackNavigationButton(
          handleBack: (){},
          backButtonText: 'Back',
        ),
      ),
    ),
    Story(
      name: 'Atom/backNavigationButton/2',
      builder: (context) =>  Center(
        child: BackNavigationButton(
          handleBack: (){},
          backButtonText: 'Back',
          // backButtonIcon: Icons.arrow_circle_left_outlined,
        ),
      ),
    ),
    Story(
      name: 'Atom/backNavigationButton/3',
      builder: (context) =>  Center(
        child: BackNavigationButton(
          handleBack: (){},
          backButtonText: 'Back',
          // backButtonIcon: Icons.arrow_left,
        ),
      ),
    ),
    Story(
      name: 'Atom/backNavigationButton/4',
      builder: (context) =>  const Center(
        child: BackNavigationButton(),
      ),
    ),
  ];
}
