import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/molecules/digit_timeline_molecule.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> timelineMoleculeStories() {
  return [
    Story(
      name: 'Molecule/Timeline Molecule/Basic',
      builder: (context) => TimelineMolecule(
        showAllSteps: true,
        steps: [
          TimelineStep(
            label: 'Step 1',
            description: [],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 2',
            description: [],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 3',
            description: [],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 4',
            description: [],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Step 5',
            description: [],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 6',
            description: [],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 7',
            description: [],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 8',
            description: [],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 9',
            description: [],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Timeline Molecule/Collapsible',
      builder: (context) => TimelineMolecule(
        steps: [
          TimelineStep(
            label: 'Step 1',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 2',
            description: ['Description for step 2'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 3',
            description: ['Description for step 3'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 4',
            description: ['Description for step 4'],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Step 5',
            description: ['Description for step 5'],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 6',
            description: ['Description for step 6'],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 7',
            description: ['Description for step 7'],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 8',
            description: ['Description for step 8'],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
  ];
}
