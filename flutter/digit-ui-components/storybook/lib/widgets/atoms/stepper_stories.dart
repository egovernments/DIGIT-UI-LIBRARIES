import 'package:digit_ui_components/widgets/atoms/digit_stepper.dart';
import 'package:digit_ui_components/widgets/atoms/stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> stepperStories() {
  return [
    Story(
      name: 'stepper',
      builder: (context) => SizedBox(
        height: 140,
        child: Column(
          children: [
            EasyStepper(
              activeStep: context.knobs.sliderInt(label: 'active index', initial: 0,divisions: 20, max: 20),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              // stepRadius: 28,
              steps: [
                EasyStep(
                  title: 'step 1',
                ),
                EasyStep(
                    title: 'step 2',
                ),
                EasyStep(
                    title: 'step 3',
                ),
                EasyStep(
                    title: 'step 4',
                ),
                EasyStep(
                    title: 'step 5',
                ),
              ],
              // onStepReached: (index) => {},
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'stepper1',
      builder: (context) => SizedBox(
        height: 140,
        child: Column(
          children: [
            EasyStepper(
              activeStep: context.knobs.sliderInt(label: 'active index', initial: 0,divisions: 20, max: 20),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              // stepRadius: 28,
              steps: [
                EasyStep(
                  title: 'Cycle 1',
                ),
                EasyStep(
                  title: 'Cycle 2',
                ),
                EasyStep(
                  title: 'Cycle 3',
                ),
              ],
              // onStepReached: (index) => {},
            ),
          ],
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