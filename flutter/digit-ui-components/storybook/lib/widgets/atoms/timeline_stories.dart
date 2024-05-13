import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/timeline.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> timeLineStories() {
  return [
    Story(
      name: 'Atom/Timeline/default',
      builder: (context) =>  Timeline(
        currentStep: context.knobs.options(label: 'Current Step', initial: TimelineStepState.present, options: const [
          Option(
            label: 'Current',
            value: TimelineStepState.present,
          ),
          Option(
            label: 'Completed',
            value: TimelineStepState.completed,
          ),
          Option(
            label: 'Future',
            value: TimelineStepState.future,
          ),
        ]),
        label: context.knobs.text(label: "label", initial: 'current state'),
        description: const ['18 / 02 / 2023'],
      ),
    ),
    Story(
      name: 'Atom/Timeline/list of description',
      builder: (context) => Timeline(
        currentStep: context.knobs.options(label: 'Current Step', initial: TimelineStepState.present, options: const [
          Option(
            label: 'Current',
            value: TimelineStepState.present,
          ),
          Option(
            label: 'Completed',
            value: TimelineStepState.completed,
          ),
          Option(
            label: 'Future',
            value: TimelineStepState.future,
          ),
        ]),
        label: context.knobs.text(label: "label", initial: 'current step'),
        description: const ['18 / 02 / 2023', '18 / 02 / 2023 11:00', '18 / 02 / 2023 11:00 PM Mon'],
      ),
    ),
    Story(
        name: 'Atom/Timeline/Additional widget',
        builder: (context) => Timeline(
          label: 'Sample Timeline',
          description: const ['Description 1', 'Description 2'],
          currentStep: TimelineStepState.completed,
          additionalWidgets: [
            TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.pdf',
                name: 'Document',
                fileType: 'pdf',
              ),
              openFile: true,
            ),
            TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg',
                name: 'Image',
                fileType: 'jpg',
              ),
              openFile: true,
            ),
            TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.png',
                name: 'Sample',
                fileType: 'png',
              ),
              openFile: true,
            ),
            TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.xlsx',
                name: 'Sample',
                fileType: 'xlsx',
              ),
              openFile: true,
            ),
            TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.doc',
                name: 'Sample',
                fileType: 'doc',
              ),
              openFile: true,
            ),
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
                title: "Info Text",
                type: InfoType.error,
                description: 'This is the warning')

          ],
        )
    ),
  ];
}