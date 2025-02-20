import 'package:digit_ui_components/widgets/atoms/digit_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> stepperStories() {
  return [
    Story(
      name: 'Atom/Stepper/horizontal/1',
      builder: (context) => SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: DigitStepper(
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0,divisions: 20, max: 20),
          stepperList:  [
            StepperData(
              title: 'title',
              onStepTap: (){},
            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',
            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',
            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',
            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',

            ),
            const StepperData(
              title: 'title',
            ),
          ],
          stepperDirection: Axis.horizontal,
          inverted: true,
        ),
      ),
    ),
    Story(
      name: 'Atom/Stepper/horizontal/2',
      builder: (context) => SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: DigitStepper(
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0,divisions: 20, max: 20),
          stepperList:  [
            StepperData(
              title: 'vendor details',
              onStepTap: (){},
            ),
            const StepperData(
              title: 'contact details',
            ),
            const StepperData(
              title: 'service details',
            ),
            const StepperData(
              title: 'worker details',
            ),
            const StepperData(
              title: 'Summary',
            ),

          ],
          stepperDirection: Axis.horizontal,
          inverted: true,
        ),
      ),
    ),
    Story(
      name: 'Atom/Stepper/horizontal/3',
      builder: (context) => DigitStepper(
        activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0,divisions: 20, max: 20),
        stepperList:  [
          StepperData(
            title: 'cycle 1',
            onStepTap: (){},
          ),
          const StepperData(
            title: 'cycle 2',
          ),
          const StepperData(
            title: 'cycle 3',
          ),

        ],
        stepperDirection: Axis.horizontal,
        inverted: true,
      ),
    ),
    Story(
      name: 'Atom/Stepper/vertical',
      builder: (context) => SizedBox(
        height: 600,
        width: 400,
        child: DigitStepper(
          activeIndex: context.knobs.sliderInt(label: 'active index', initial: 0),
          stepperList:  [
            StepperData(
              title: "title",
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