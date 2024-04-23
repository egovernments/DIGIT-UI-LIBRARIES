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
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0),
          stepperList:  [
            StepperData(
              title: "Preparing",
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
