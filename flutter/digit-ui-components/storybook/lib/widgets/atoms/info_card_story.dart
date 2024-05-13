import 'dart:ui';

import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:digit_ui_components/widgets/atoms/digit_text_form_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> infoCardStories() {
  return [
    Story(
      name: 'Atom/Info/Info',
      builder: (context) => InfoCard(
        title: context.knobs.text(label: "Title", initial: 'Info'),
        type: context.knobs
            .options(label: "Type", initial: InfoType.info, options: const [
          Option(
            label: 'Info',
            value: InfoType.info,
          ),
          Option(
            label: 'Success',
            value: InfoType.success,
          ),
          Option(
            label: 'error',
            value: InfoType.error,
          ),
          Option(
            label: 'Warning',
            value: InfoType.warning,
          ),
        ]),
        description: context.knobs.text(label: "Description", initial: 'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.'),
      ),
    ),
    Story(
      name: 'Atom/Info/Additional widgets',
      builder: (context) =>  InfoCard(
        title: context.knobs.text(label: "Title", initial: 'Info'),
        type: context.knobs
            .options(label: "Type", initial: InfoType.info, options: const [
          Option(
            label: 'Info',
            value: InfoType.info,
          ),
          Option(
            label: 'Success',
            value: InfoType.success,
          ),
          Option(
            label: 'error',
            value: InfoType.error,
          ),
          Option(
            label: 'Warning',
            value: InfoType.warning,
          ),
        ]),
        description: context.knobs.text(label: "Description", initial: 'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.'),
        additionalWidgets: [
          const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"),
          Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
          Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
          const InfoCard(
              title: "Info Text",
              type: InfoType.error,
              description: 'This is the warning'),
          Button(
            label: 'button',
            onPressed: () {},
            type: ButtonType.secondary, size: ButtonSize.medium,
          )
        ],
      ),
    ),
  ];
}
