import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> bottomSheetStories() {
  return [
    Story(
      name: 'Molecule/Bottom Sheet/default',
      builder: (context) {

        return const DigitBottomSheet(
          content: Column(
            children: [
              Text('This is a default bottom sheet'),
            ],
          ),
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with action',
      builder: (context) {

        return DigitBottomSheet(
          content: const Column(
            children: [
              Text('Content with Actions'),
              // Add more content here
            ],
          ),
          primaryActionLabel: 'Submit',
          onPrimaryAction: (context) {
            // Handle primary action
          },
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Drag Disabled',
      builder: (context) {

        return const DigitBottomSheet(
          content: Text('Drag Disabled Content'),
          initialHeightPercentage: 50,
          disableDrag: true,
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Login Form',
      builder: (context) {

        return DigitBottomSheet(
          content: LoginForm(),
          initialHeightPercentage: 30,
          primaryActionLabel: 'Submit',
          onPrimaryAction: (context) {
            // Handle login
          },
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Feedback Form',
      builder: (context) {

        return DigitBottomSheet(
          content: FeedbackForm(),
          primaryActionLabel: 'Submit',
          secondaryActionLabel: 'Clear',
          initialHeightPercentage: 30,
          onPrimaryAction: (context) {
            // Handle feedback submission
          },
          onSecondaryAction: (context) {
            // Handle feedback cancellation
          },
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with 30% height and Contact Form',
      builder: (context) {

        return DigitBottomSheet(
          content: ContactForm(),
          initialHeightPercentage: 30,
          onPrimaryAction: (context) {
            // Handle contact form submission
          },
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Scrolling Content and Survey',
      builder: (context) {

        return DigitBottomSheet(
          content: SurveyForm(),
          initialHeightPercentage: 50,
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Fixed Height and Registration Form',
      builder: (context) {

        return DigitBottomSheet(
          content: const RegistrationForm(),
          fixedHeight: 400,
          primaryActionLabel: 'Submit',
          onPrimaryAction: (context) {
            // Handle registration
          },
        );
      },
    ),
  ];
}

// Placeholder widgets for the forms used in the stories
class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Login Form'),
        const TextField(decoration: InputDecoration(labelText: 'Username')),
        const TextField(decoration: InputDecoration(labelText: 'Password')),
        const SizedBox(
          height: 16,
        ),
        DigitCheckbox(label: 'Click to accept', onChanged: (value) {})
      ],
    );
  }
}

class FeedbackForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Feedback Form'),
        TextField(decoration: InputDecoration(labelText: 'Feedback')),
      ],
    );
  }
}

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Contact Form'),
        TextField(decoration: InputDecoration(labelText: 'Name')),
        TextField(decoration: InputDecoration(labelText: 'Email')),
        TextField(decoration: InputDecoration(labelText: 'Message')),
      ],
    );
  }
}

class SurveyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        10,
            (index) => CheckboxListTile(
          title: Text('Survey Question $index'),
          value: false,
          onChanged: (bool? value) {},
        ),
      ),
    );
  }
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