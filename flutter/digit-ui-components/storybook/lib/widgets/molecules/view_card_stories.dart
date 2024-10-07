import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:digit_ui_components/widgets/atoms/timeline.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/molecules/form_card.dart';
import 'package:digit_ui_components/widgets/atoms/dropdown_wrapper.dart';

List<Story> viewCardStories() {
  return [
    Story(
        name: 'Molecule/Card/View Card/1',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.horizontal,
          columnCount: 2,
          showDivider: true,
          children: [
            const LabeledField(
                label: 'Text Field',
                child: DigitTextFormInput(
                  initialValue: 'Initial Value',
                )),
            const LabeledField(
                label: 'Numeric Field',
                child: DigitNumericFormInput(
                  initialValue: '10',
                )),
            const LabeledField(
                label: 'Location Field',
                child: DigitLocationFormInput(
                 initialValue: '20.34534, 30.34534',
                )),
            LabeledField(
              label: "Dropdown with Description",
              child: DigitDropdown(
                onSelect: (item) => {},
                selectedOption:
                  const DropdownItem(name: 'one', code: '1', description: 'This is just example description'),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.docx',
                name: 'Sample',
                fileType: 'doc',
              ),
              openFile: true,
            ),
          ),
          Flexible(
            child: TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.docx',
                name: 'Sample',
                fileType: 'doc',
              ),
              openFile: true,
            ),
          ),
          Flexible(
            child: TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.docx',
                name: 'Sample',
                fileType: 'doc',
              ),
              openFile: true,
            ),
          ),
          Flexible(
            child: TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.docx',
                name: 'Sample',
                fileType: 'doc',
              ),
              openFile: true,
            ),
          ),
          Flexible(
            child: TimelineFileWidget(
              file: TimelineFiles(
                url: 'https://example.com/sample.docx',
                name: 'Sample',
                fileType: 'doc',
              ),
              openFile: true,
            ),
          ),
        ],
      ),
          ],
        )
    ),
    Story(
        name: 'Molecule/Card/View Card/2',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
              ],
            ),
          ],
        )
    ),
    Story(
        name: 'Molecule/Card/View Card/3',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.vertical,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
              ],
            ),
            DigitCheckbox(label: 'Click to know more', onChanged: (value) {}),
          ],
        )
    ),
    Story(
        name: 'Molecule/Card/View Card/4',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.vertical,
          columnCount: 1,
          showDivider: true,
          children: [
            const DigitTextBlock(
              heading: 'Heading',
            ),
            LabelValueList(
              items: [
                LabelValuePair(label: 'start date', value: '22/03/2025'),
                LabelValuePair(label: 'start date', value: '22/03/2025'),
                LabelValuePair(label: 'start date', value: '22/03/2025'),
                LabelValuePair(label: 'start date', value: '22/03/2025'),
                LabelValuePair(label: 'start date', value: '22/03/2025'),
              ],
            ),
            const DigitDivider(),
            Text('Add Sample Documents', style: Theme.of(context).digitTextTheme(context).headingL.copyWith(color: Theme.of(context).colorTheme.primary.primary2),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
                Flexible(
                  child: TimelineFileWidget(
                    file: TimelineFiles(
                      url: 'https://example.com/sample.docx',
                      name: 'Sample',
                      fileType: 'doc',
                    ),
                    openFile: true,
                  ),
                ),
              ],
            ),
          ],
        )
    ),
  ];
}