import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/molecules/label_value_summary.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';

import '../../iframe/iframe_widget.dart';

List<Story> listViewSummaryStories() {
  return [
    Story(
      name: 'Molecule/Card/Summary Card',
      builder: (context) {

        // Knob for inline layout
        final bool isInline = context.knobs.options(
            label: 'Layout',
            initial: true,
            options: [
              Option(label: 'Horizontal', value: true),
              Option(label: 'Vertical', value: false),
            ]
        );

        // Knob for card
        final bool withoutCard = context.knobs.boolean(
          label: 'Without Card',
          initial: false,
        );

        // Knob for header
        final String header = context.knobs.text(
          label: 'Header',
          initial: 'Summary',
        );

        // Knob to show profile pictures
        final bool isImage = context.knobs.boolean(
          label: 'Show Profile Pictures',
          initial: true,
        );

        // Knob to show tags
        final bool isTags = context.knobs.boolean(
          label: 'Show Tags',
          initial: true,
        );

        final bool action = context.knobs.boolean(
          label: 'Action',
          initial: false,
        );

        const int valueFlex = 5;

        // Prepare items for LabelValueSummary
        List<LabelValueItem> items = [
          LabelValueItem(
            valueFlex: valueFlex,
            label: 'Name',
            value: 'John Doe',
            isInline: isInline, // Set inline property based on knob
          ),
        ];

        // Add Profile Pictures only if the isImage knob is true
        if (isImage) {
          items.add(LabelValueItem(
            valueFlex: valueFlex,
            label: 'Profile Picture',
            value: [
              Container(
                height: 50,
                width: 50,
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 50,
                width: 50,
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  fit: BoxFit.fill,
                ),
              ),
            ],
            isInline: isInline, // Set inline property based on knob
          ));
        }

        // Add Tags only if the isTags knob is true
        if (isTags) {
          items.add(LabelValueItem(
            valueFlex: valueFlex,
            label: 'Tags',
            value: 'Tag1, Tag2, Tag3',
            isInline: isInline, // Set inline property based on knob
          ));
        }

        // Return the LabelValueSummary with the items
        return Center(
          child: LabelValueSummary(
            heading: header.isNotEmpty ? header : null,
            withCard: !withoutCard,
            withDivider: context.knobs.boolean(label: 'Divider', initial: true),
            items: items,
            action: action ? [
              DigitButton(label: 'Cancel', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large),
              DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.primary, size: DigitButtonSize.large),
            ] : null,
          ),
        );
      },
    ),
  ];
}
