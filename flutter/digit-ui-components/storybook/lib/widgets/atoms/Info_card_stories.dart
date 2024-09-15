import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:digit_ui_components/widgets/atoms/info_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> infoCardStories() {
  return [
    Story(
      name: 'Atom/Info/Info',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
InfoCard(
  title: Info Card,
  type: InfoType.info,
  description: Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment.,
)
          ''');
        });

        return InfoCard(
          title: context.knobs.text(label: "Title", initial: 'Info'),
          type: context.knobs.options(
            label: "Type",
            initial: InfoType.info,
            options: const [
              Option(label: 'Info', value: InfoType.info),
              Option(label: 'Success', value: InfoType.success),
              Option(label: 'Error', value: InfoType.error),
              Option(label: 'Warning', value: InfoType.warning),
            ],
          ),
          description: context.knobs.text(
            label: "Description",
            initial:
                'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment.',
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Info/Info DigitButtons',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
InfoButton(
  size: DigitButtonSize.large,
  label: 'Primary DigitButton',
  onPressed: () {},
  type: InfoDigitButtonType.warning,
)
          ''');
        });

        return InfoButton(
          size: DigitButtonSize.large,
          label: 'Primary DigitButton',
          onPressed: () {},
          type: context.knobs.options(
            label: 'Type',
            initial: InfoDigitButtonType.warning,
            options: const [
              Option(label: 'Warning', value: InfoDigitButtonType.warning),
              Option(label: 'Info', value: InfoDigitButtonType.info),
              Option(label: 'Error', value: InfoDigitButtonType.error),
              Option(label: 'Success', value: InfoDigitButtonType.success),
            ],
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Info/Additional widgets',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
InfoCard(
  title: Info Card,
  type: InfoType.info,
  description: Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment.,
  additionalWidgets: [
    const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"),
    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
  ],
  inline: false,
)
          ''');
        });

        return InfoCard(
          title: context.knobs.text(label: "Title", initial: 'Info'),
          type: context.knobs.options(
            label: "Type",
            initial: InfoType.info,
            options: const [
              Option(label: 'Info', value: InfoType.info),
              Option(label: 'Success', value: InfoType.success),
              Option(label: 'Error', value: InfoType.error),
              Option(label: 'Warning', value: InfoType.warning),
            ],
          ),
          description: context.knobs.text(
            label: "Description",
            initial:
                'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment.',
          ),
          additionalWidgets: [
            const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
          ],
          inline: context.knobs
              .boolean(label: 'Inline Additional Widgets', initial: false),
        );
      },
    ),
    Story(
      name: 'Atom/Info/Additional widgets with DigitButtons',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
InfoCard(
  title: Info Card,
  type: InfoType.info,
  description: Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment.,
  inline: false,
  additionalWidgets: [
    const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"),
    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
    Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
    InfoDigitButton(
      label: 'Click To Know More',
      onPressed: () {},
      type: InfoDigitButtonType.info,
      size: DigitButtonSize.large,
    ),
  ],
)
          ''');
        });

        return InfoCard(
          title: context.knobs.text(label: "Title", initial: 'Info'),
          type: InfoType.info,
          description: context.knobs.text(
            label: "Description",
            initial:
                'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment.',
          ),
          inline: context.knobs
              .boolean(label: 'Inline Additional Widgets', initial: false),
          additionalWidgets: [
            const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
            InfoButton(
              label: 'Click To Know More',
              onPressed: () {},
              type: InfoDigitButtonType.info,
              size: DigitButtonSize.large,
            ),
          ],
        );
      },
    ),
  ];
}
