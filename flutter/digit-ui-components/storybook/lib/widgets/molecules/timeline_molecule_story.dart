import 'package:digit_ui_components/widgets/atoms/digit_timeline.dart';
import 'package:digit_ui_components/widgets/molecules/timeline_molecule.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> timelineMoleculeStories() {
  return [
    Story(
      name: 'Molecule/Timeline/1',
      builder: (context) =>TimelineMolecule(
        steps: [
          TimelineStep(
            label: 'Step 1',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 2',
            description: ['Description for step 2'],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Step 3',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Timeline/2',
      builder: (context) =>TimelineMolecule(
        steps: [
          TimelineStep(
            label: 'Step 1',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 2',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 3',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 4',
            description: ['Description for step 2'],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Step 5',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 6',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 7',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Step 8',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Timeline/3',
      builder: (context) =>TimelineMolecule(
        steps: [
          TimelineStep(
            label: 'Step 1',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
            additionalWidgets: [
              const Text('Additional Widget 1'),
              const Text('Additional Widget 2'),
              const Text('Additional Widget 3'),
              const Text('Additional Widget 4'),
              const Text('Additional Widget 5'),
              const Text('Additional Widget 6'),
            ]
          ),
          TimelineStep(
            label: 'Step 2',
            description: ['Description for step 2'],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Step 3',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Timeline/4',
      builder: (context) =>TimelineMolecule(
        steps: [
          TimelineStep(
            label: 'Step 1',
            description: ['Description for step 1'],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Step 2',
            description: ['Description for step 2'],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Step 3',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
  ];
}
