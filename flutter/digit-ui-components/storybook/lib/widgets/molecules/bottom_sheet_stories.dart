import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> bottomSheetStories() {
  return [
    Story(
      name: 'Molecule/Bottom Sheet/default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: Column(
    children: [
      Text('This is a default bottom sheet'),
      // Add more content here
    ],
  ),
)
          ''');
        });

        return const CustomBottomSheet(
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: Column(
    children: [
      Text('Content with Actions'),
      // Add more content here
    ],
  ),
  primaryActionLabel: 'Submit',
  onPrimaryAction: (context) {
    // Handle primary action
  },
)
          ''');
        });

        return CustomBottomSheet(
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: Text('Drag Disabled Content'),
  initialHeightPercentage: 50,
  disableDrag: true,
)
          ''');
        });

        return const CustomBottomSheet(
          content: Text('Drag Disabled Content'),
          initialHeightPercentage: 50,
          disableDrag: true,
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Login Form',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: LoginForm(),
  initialHeightPercentage: 30,
  primaryActionLabel: 'Submit',
  onPrimaryAction: (context) {
    // Handle login
  },
)
          ''');
        });

        return CustomBottomSheet(
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: FeedbackForm(),
  initialHeightPercentage: 30,
  primaryActionLabel: 'Submit',
  secondaryActionLabel: 'Clear',
  onPrimaryAction: (context) {
    // Handle feedback submission
  },
  onSecondaryAction: (context) {
    // Handle feedback cancellation
  },
)
          ''');
        });

        return CustomBottomSheet(
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: ContactForm(),
  initialHeightPercentage: 30,
  onPrimaryAction: (context) {
    // Handle contact form submission
  },
)
          ''');
        });

        return CustomBottomSheet(
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: SurveyForm(),
  initialHeightPercentage: 50,
)
          ''');
        });

        return CustomBottomSheet(
          content: SurveyForm(),
          initialHeightPercentage: 50,
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet/with Fixed Height and Registration Form',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomBottomSheet(
  content: RegistrationForm(),
  fixedHeight: 400,
  primaryActionLabel: 'Submit',
  onPrimaryAction: (context) {
    // Handle registration
  },
)
          ''');
        });

        return CustomBottomSheet(
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
