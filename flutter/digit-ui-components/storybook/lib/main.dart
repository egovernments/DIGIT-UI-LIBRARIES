import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_timeline.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/atoms/stepper.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: 'Screens/Scaffold',
      wrapperBuilder: (context, child) => MaterialApp(
        title: 'Storybook Flutter',
        theme: DigitTheme.instance.mobileTheme,
        home: Scaffold(
          body: child,
        ),
      ),

      stories: [
        Story(
          name: 'Screens/Counter',
          description: 'Demo Counter app with about dialog.',
          builder: (context) => InputField(
            type: InputType.time,
            label: "Time Field",
            controller: TextEditingController(),
            innerLabel: 'innerlabel',
            helpText: 'help text',
          ),
        ),
        Story(
          name: 'Widgets/Buttons/Primary',
          description: 'Simple text widget.',
          builder: (context) => Button(
            label: context.knobs
                .text(label: 'Label', initial: 'Primary Button'),
            onPressed: () {
              // Add your primary button logic here
            },
            type: ButtonType.primary,
            isDisabled: context.knobs.boolean(
              label: 'disable',
              initial: false,
            ),
          ),
        ),
        Story(
          name: 'Widgets/Buttons/Secondary',
          description: 'Simple text widget.',
          builder: (context) => Button(
            label: context.knobs.text(
                label: 'Label', initial: 'Secondary Button'),
            onPressed: () {
              // Add your secondary button logic here
            },
            isDisabled: context.knobs.boolean(
              label: 'disable',
              initial: false,
            ),
            type: ButtonType.secondary,
          ),
        ),
        Story(
          name: 'Widgets/Buttons/Tertiary',
          description: 'Simple text widget.',
          builder: (context) => Button(
            label: context.knobs.text(
                label: 'Label', initial: 'Tertiary Button'),
            onPressed: () {
              // Add your secondary button logic here
            },
            isDisabled: context.knobs.boolean(
              label: 'disable',
              initial: false,
            ),
            type: ButtonType.tertiary,
          ),
        ),
        Story(
          name: 'Widgets/Buttons/Link',
          description: 'Simple text widget.',
          builder: (context) => Button(
            label: context.knobs
                .text(label: 'Label', initial: 'link'),
            onPressed: () {
              // Add your secondary button logic here
            },
            isDisabled: context.knobs.boolean(
              label: 'disable',
              initial: false,
            ),
            type: ButtonType.link,
          ),
        ),
        Story(
          name: 'Widgets/Checkbox',
          builder: (context) => DigitCheckbox(
            label: context.knobs.text(
              label: 'Label',
              initial: 'Checkbox Label',
            ),
            value: context.knobs.boolean(
              label: 'Initial Value',
              initial: false,
            ),
            onChanged: (value) {},
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initial: false,
            ),
          ),
        ),
        Story(
          name: 'Widgets/Toast/Success',
          builder: (context) => ElevatedButton(
            onPressed: () {
              Toast.show(context,
                  options: ToastOptions(
                      "Your successour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning message message",
                      ToastType.success));
            },
            child: const Text("Show Toast"),
          ),
        ),
        Story(
          name: 'Widgets/Toast/Error',
          builder: (context) => ElevatedButton(
            onPressed: () {
              Toast.show(context,
                  options: ToastOptions(
                      "Your error message", ToastType.error));
            },
            child: const Text("Show Toast"),
          ),
        ),
        Story(
          name: 'Widgets/Toast/Warning',
          builder: (context) => ElevatedButton(
            onPressed: () {
              Toast.show(context,
                  options: ToastOptions(
                    "Your Warning message",
                    ToastType.warning,
                  ));
            },
            child: const Text("Show Toast"),
          ),
        ),
        Story(
          name: 'Widgets/Info/Info',
          builder: (context) => const InfoCard(
            title: 'Info',
            type: InfoType.info,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
        ),
        Story(
          name: 'Widgets/Info/Success',
          builder: (context) => const InfoCard(
            title: 'Success',
            type: InfoType.success,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
        ),
        Story(
          name: 'Widgets/Info/Error',
          builder: (context) => const InfoCard(
            title: 'Error',
            type: InfoType.error,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
        ),
        Story(
          name: 'Widgets/Info/Warning',
          builder: (context) => const InfoCard(
            title: 'Warning',
            type: InfoType.warning,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
        ),
        Story(
          name: 'Widgets/Timeline/Completed',
          builder: (context) => const Timeline(
            currentStep: TimelineStepState.completed,
            label: 'Completed',
            description: ['18 / 02 / 2023'],
          ),
        ),
        Story(
          name: 'Widgets/Timeline/Current',
          builder: (context) => const Timeline(
            currentStep: TimelineStepState.present,
            label: 'Completed',
            description: ['18 / 02 / 2023'],
          ),
        ),
        Story(
          name: 'Widgets/Timeline/Future',
          builder: (context) => const Timeline(
            currentStep: TimelineStepState.future,
            label: 'Completed',
            description: ['18 / 02 / 2023'],
          ),
        ),
        Story(
          name: 'Widgets/Stepper',
          builder: (context) => DigitStepper(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.start,
            endChild: Container(
              color: Colors.amberAccent,
            ),
          ),
        ),
      ],
    );
  }
}

