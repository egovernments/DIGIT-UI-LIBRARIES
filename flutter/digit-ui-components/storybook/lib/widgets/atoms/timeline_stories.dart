import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/timeline.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> timeLineStories() {
  return [
    Story(
      name: 'Atom/Timeline/Ongoing',
      builder: (context) {

        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );


        bool showAdditionalCollapsibleWidget = context.knobs.boolean(
          label: "Show Additional Collapsible Widget",
          initial: false,
        );

        return DigitTimeline(
          currentStep: TimelineStepState.present,
          label: context.knobs.text(label: "label", initial: 'Ongoing state'),
          description: const ['18 / 02 / 2023'],
          additionalWidgets: [
            if(showAdditionalWidget)
              ...[
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
              ]
          ],
          additionalHideWidgets: showAdditionalCollapsibleWidget ? [
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
            ] : null,
        );
      }
    ),
    Story(
      name: 'Atom/Timeline/Completed',
      builder: (context) {

        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );


        bool showAdditionalCollapsibleWidget = context.knobs.boolean(
          label: "Show Additional Collapsible Widget",
          initial: false,
        );

        return DigitTimeline(
          currentStep: TimelineStepState.completed,
          label: context.knobs.text(label: "label", initial: 'Completed state'),
          description: const ['18 / 02 / 2023'],
          additionalWidgets: [
            if(showAdditionalWidget)
              ...[
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
              ]
          ],
          additionalHideWidgets: showAdditionalCollapsibleWidget ? [
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
            ] : null,
        );
      }
    ),
    Story(
      name: 'Atom/Timeline/Upcoming',
      builder: (context) {

        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );


        bool showAdditionalCollapsibleWidget = context.knobs.boolean(
          label: "Show Additional Collapsible Widget",
          initial: false,
        );

        return DigitTimeline(
          currentStep: TimelineStepState.future,
          label: context.knobs.text(label: "label", initial: 'Upcoming state'),
          description: const ['18 / 02 / 2023'],
          additionalWidgets: [
            if(showAdditionalWidget)
              ...[
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
              ]
          ],
          additionalHideWidgets: showAdditionalCollapsibleWidget ? [
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
              ] : null
        );
      }
    ),
    Story(
        name: 'Atom/Timeline/Failed',
        builder: (context) {

          bool showAdditionalWidget = context.knobs.boolean(
            label: "Show Additional Widget",
            initial: false,
          );


          bool showAdditionalCollapsibleWidget = context.knobs.boolean(
            label: "Show Additional Collapsible Widget",
            initial: false,
          );

          return DigitTimeline(
              currentStep: TimelineStepState.failed,
              label: context.knobs.text(label: "label", initial: 'Failed state'),
              description: const ['18 / 02 / 2023'],
              additionalWidgets: [
                if(showAdditionalWidget)
                  ...[
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
                  ]
              ],
              additionalHideWidgets: showAdditionalCollapsibleWidget ? [
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
              ] : null
          );
        }
    ),
  ];
}