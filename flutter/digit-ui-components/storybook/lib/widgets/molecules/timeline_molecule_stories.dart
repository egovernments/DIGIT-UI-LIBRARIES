import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:digit_ui_components/widgets/atoms/timeline.dart';
import 'package:digit_ui_components/widgets/molecules/digit_timeline_molecule.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';

List<Story> timelineMoleculeStories() {
  return [
    Story(
      name: 'Molecule/Timeline Molecule/Variant 1',
      builder: (context) => TimelineMolecule(
        steps: [
          TimelineStep(
            label: 'Completed',
            description: [
              '26 / 03 / 2024',
              '11:00 PM',
              '26 / 03 / 2024 11:00 PM',
              '26 / 03 / 2024 11:00 PM Mon',
              '+91 **********',
            ],
            state: TimelineStepState.completed,
          ),
          TimelineStep(
            label: 'Present',
            description: [
              '26 / 03 / 2024',
              '11:00 PM',
              '26 / 03 / 2024 11:00 PM',
              '26 / 03 / 2024 11:00 PM Mon',
              '+91 **********',
            ],
            state: TimelineStepState.present,
          ),
          TimelineStep(
            label: 'Upcoming event 1',
            description: [
              '26 / 03 / 2024',
              '11:00 PM',
              '26 / 03 / 2024 11:00 PM',
              '26 / 03 / 2024 11:00 PM Mon',
              '+91 **********',
            ],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Upcoming event 2',
            description: [
              '26 / 03 / 2024',
              '11:00 PM',
              '26 / 03 / 2024 11:00 PM',
              '26 / 03 / 2024 11:00 PM Mon',
              '+91 **********',
            ],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Upcoming event 3',
            description: [
              '26 / 03 / 2024',
              '11:00 PM',
              '26 / 03 / 2024 11:00 PM',
              '26 / 03 / 2024 11:00 PM Mon',
              '+91 **********',
            ],
            state: TimelineStepState.future,
          ),
          TimelineStep(
            label: 'Upcoming event 4',
            description: [
              '26 / 03 / 2024',
              '11:00 PM',
              '26 / 03 / 2024 11:00 PM',
              '26 / 03 / 2024 11:00 PM Mon',
              '+91 **********',
            ],
            state: TimelineStepState.future,
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Timeline Molecule/Variant 2',
      builder: (context) => TimelineMolecule(
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
      name: 'Molecule/Timeline Molecule/Variant 3',
      builder: (context) => TimelineMolecule(
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
            ],
            additionalHideWidgets: [
              TimelineFileWidget(
                file: TimelineFiles(
                  url: 'https://example.com/sample.docx',
                  name: 'Sample',
                  fileType: 'doc',
                ),
                openFile: true,
              ),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              const InfoCard(
                  title: "Info",
                  type: InfoType.info,
                  description: 'This step is mandatory')

            ],
          ),
          TimelineStep(
            label: 'Step 2',
            description: ['Description for step 2'],
            state: TimelineStepState.present,
            additionalHideWidgets: [
              TimelineFileWidget(
                file: TimelineFiles(
                  url: 'https://example.com/sample.docx',
                  name: 'Sample',
                  fileType: 'doc',
                ),
                openFile: true,
              ),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              const InfoCard(
                  title: "Info",
                  type: InfoType.info,
                  description: 'This step is mandatory')

            ],
          ),
          TimelineStep(
            label: 'Step 3',
            description: ['Description for step 3'],
            state: TimelineStepState.future,
            additionalHideWidgets: [
              TimelineFileWidget(
                file: TimelineFiles(
                  url: 'https://example.com/sample.docx',
                  name: 'Sample',
                  fileType: 'doc',
                ),
                openFile: true,
              ),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
              const InfoCard(
                  title: "Info",
                  type: InfoType.info,
                  description: 'This step is mandatory')

            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Timeline Molecule/Variant 4(With all steps shown)',
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
  ];
}
