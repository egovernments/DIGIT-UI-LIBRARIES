import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/dropdown_wrapper.dart';

import '../../iframe/iframe_widget.dart';

List<Story> cardStories() {
  return [
    Story(
      name: 'Molecule/Card/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/Card/Basic',
      builder: (context) => DigitCard(
        cardType: context.knobs.options(label: 'Card Type', initial: CardType.primary, options: [
          Option(label: 'Primary', value: CardType.primary),
          Option(label: 'Secondary', value: CardType.secondary)
        ]),
        children: [
          LabeledField(
              label: 'Text Field',
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
              label: 'Numeric Field',
              child: DigitNumericFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
              label: 'Search Field',
              child: DigitSearchFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
              label: 'Location Field',
              child: DigitLocationFormInput(
                controller: TextEditingController(),
              )),
          DigitCheckbox(label: 'Click to know more', onChanged: (value) {}),
          LabeledField(
            label: "Dropdown with Description",
            child: DigitDropdown(
              onSelect: (item) => {},
              items: [
                'one',
                'two',
                'three',
                'four',
              ]
                  .asMap()
                  .entries
                  .map(
                    (item) => DropdownItem(
                    name: item.value,
                    code: item.key.toString(),
                    description: 'This is just example description'),
              )
                  .toList(),
            ),
          ),
          LabeledField(
            label: "Dropdown with Description",
            child: DigitDropdown(
              items: [
                'one',
                'two',
                'three',
                'four',
              ]
                  .asMap()
                  .entries
                  .map(
                    (item) => DropdownItem(
                    name: item.value,
                    code: item.key.toString(),
                    description: 'This is just example description'),
              )
                  .toList(),
            ),
          ),
          LabeledField(
            label: "Dropdown with Description",
            child: DigitDropdown(
              items: [
                'one',
                'two',
                'three',
                'four',
              ]
                  .asMap()
                  .entries
                  .map(
                    (item) => DropdownItem(
                    name: item.value,
                    code: item.key.toString(),
                    description: 'This is just example description'),
              )
                  .toList(),
            ),
          ),
          LabeledField(
            label: "Dropdown with Description",
            child: DigitDropdown(
              items: [
                'one',
                'two',
                'three',
                'four',
              ]
                  .asMap()
                  .entries
                  .map(
                    (item) => DropdownItem(
                    name: item.value,
                    code: item.key.toString(),
                    description: 'This is just example description'),
              )
                  .toList(),
            ),
          ),
          const InfoCard(
            title: 'Info',
            type: InfoType.info,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
          const InfoCard(
            title: 'Success',
            type: InfoType.success,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
          const InfoCard(
            title: 'Error',
            type: InfoType.error,
            description:
            'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
          ),
        ],
      ),
    ),
  ];
}