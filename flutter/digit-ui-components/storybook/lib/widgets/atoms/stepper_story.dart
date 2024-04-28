import 'package:digit_ui_components/widgets/atoms/digit_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> stepperStories() {
  return [
    Story(
      name: 'Stepper/horizontal',
      builder: (context) => SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: DigitStepper(
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0, divisions: 10,max: 10),
          stepperList:  [
            StepperData(
              title: context.knobs.text(label: 'Stepper1', initial: 'sdfsdfsdfsd'),
              onStepTap: (){},
            ),
             StepperData(
              title: context.knobs.text(label: 'Stepper2', initial: 'sdfsdfsdfsd'),
            ),
             StepperData(
              title: context.knobs.text(label: 'Stepper3', initial: 'sdfsdfsdfsd'),
            ),
             StepperData(
              title: context.knobs.text(label: 'Stepper4', initial: 'sdfsdfsdfsd'),
            ),
             StepperData(
              title: context.knobs.text(label: 'Stepper5', initial: 'sdfsdfsdfsd'),
            ),
             StepperData(
              title: context.knobs.text(label: 'Stepper6', initial: 'sdfsdfsdfsd'),
            ),
             StepperData(
              title: context.knobs.text(label: 'Stepper7', initial: 'sdfsdfsdfsd'),
            ),

          ],
          stepperDirection: Axis.horizontal,
          inverted: true,
        ),
      ),
    ),
    Story(
      name: 'Stepper/horizontal max',
      builder: (context) => SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: DigitStepper(
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0,divisions: 20, max: 20),
          stepperList:  [
            StepperData(
              title: context.knobs.text(label: 'Stepper1', initial: 'sdfsdfsdfsd'),
              onStepTap: (){},
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper2', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper3', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper4', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper5', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper6', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper7', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper2', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper3', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper4', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper5', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper6', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper7', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper2', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper3', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper4', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper5', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper6', initial: 'sdfsdfsdfsd'),
            ),
            StepperData(
              title: context.knobs.text(label: 'Stepper7', initial: 'sdfsdfsdfsd'),
            ),
          ],
          stepperDirection: Axis.horizontal,
          inverted: true,
        ),
      ),
    ),
    Story(
      name: 'Stepper/vertical',
      builder: (context) => SizedBox(
        height: 600,
        width: 400,
        child: DigitStepper(
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0),
          stepperList:  [
            StepperData(
              title: "Preparisdfkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjdsfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjng",
              onStepTap: (){},
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
            const StepperData(
              title: "Preparing",
            ),
          ],
          stepperDirection: Axis.vertical,
          inverted: true,
        ),
      ),
    ),
  ];
}
