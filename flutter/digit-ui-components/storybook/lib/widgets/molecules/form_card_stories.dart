import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/molecules/form_card.dart';

List<Story> formCardStories() {
  return [
    Story(
        name: 'Molecule/Card/form Card',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.horizontal,
          columnCount: context.knobs.sliderInt(label: 'Column', initial: 2, min: 1, max: 2, divisions: 1),
          showDivider: true,
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
            FileUploadWidget2(
              label: 'Upload', onFilesSelected: (file){
              return {};
            },
            ),
          ],
        )
    ),
  ];
}