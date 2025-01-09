import 'package:digit_ui_components/widgets/molecules/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> bottomSheetStories() {
  return [
    Story(
      name: 'Molecule/Bottom Sheet/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/Basic',
      builder: (context) {

        return DigitBottomSheet(
          content: Column(
            children: [
              Text('This is a basic bottom sheet'),
            ],
          ),
          disableDrag: context.knobs.boolean(label: "Disable Drag", initial: false),
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/With Actions',
      builder: (context) {

        return DigitBottomSheet(
          content: const Column(
            children: [
              Text('This is a bottom sheet with actions'),
              // Add more content here
            ],
          ),
          primaryActionLabel: 'Submit',
          secondaryActionLabel: 'Clear',
          onPrimaryAction: (context) {
            // Handle feedback submission
          },
          onSecondaryAction: (context) {
            // Handle feedback cancellation
          },
          disableDrag: context.knobs.boolean(label: "Disable Drag", initial: false),
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/Custom',
      builder: (context) {

        return DigitBottomSheet(
          content: const RegistrationForm(),
          fixedHeight: 400,
          primaryActionLabel: 'Submit',
          onPrimaryAction: (context) {
            // Handle registration
          },
          disableDrag: context.knobs.boolean(label: "Disable Drag", initial: false),
        );
      },
    ),
  ];
}


class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Registration Form'),
        TextField(decoration: InputDecoration(labelText: 'Username')),
        TextField(decoration: InputDecoration(labelText: 'Email')),
        TextField(decoration: InputDecoration(labelText: 'Password')),
      ],
    );
  }
}