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
        name: 'Molecule/Card/form Card/1',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.horizontal,
          columnCount: 2,
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
    Story(
      name: 'Molecule/Card/form Card/2',
      builder: (context) => FlexibleDigitCard(
        layoutType: LayoutType.horizontal,
        columnCount: 2,
        showDivider: true,
        children: [
          LabeledField(
            labelInline: false,
              label: 'Text Field',
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
              labelInline: false,
              label: 'Numeric Field',
              child: DigitNumericFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
              labelInline: false,
              label: 'Search Field',
              child: DigitSearchFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
              labelInline: false,
              label: 'Location Field',
              child: DigitLocationFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            labelInline: false,
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
            labelInline: false,
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
            labelInline: false,
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
            labelInline: false,
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
    Story(
        name: 'Molecule/Card/form Card/3',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.vertical,
          columnCount: 1,
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
            DigitCheckbox(label: 'Click to know more', onChanged: (value) {}),
          ],
        )
    ),
    Story(
        name: 'Molecule/Card/form Card/4',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.vertical,
          columnCount: 1,
          showDivider: true,
          children: [
            const DigitTextBlock(
              heading: 'Heading',
            ),
            LabeledField(

                label: 'Text Field',
                child: DigitTextFormInput(
                  controller: TextEditingController(),
                )),
            LabeledField(

                label: 'Text Field',
                child: DigitTextFormInput(
                  controller: TextEditingController(),
                )),
            const SizedBox(height: 8,),
            const DigitDivider(),
            const DigitTextBlock(
              subHeading: 'Add Sample Documents',
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