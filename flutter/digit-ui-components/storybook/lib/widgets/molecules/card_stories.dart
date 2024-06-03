import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/dropdown_wrapper.dart';

List<Story> cardStories() {
  return [
    Story(
      name: 'Molecule/Card/primary/1',
      builder: (context) => DigitCard(
        cardType: CardType.primary,
        children: [
          LabeledField(
              label: 'Text Field',
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),

        ],
      ),
    ),
    Story(
      name: 'Molecule/Card/primary/2',
      builder: (context) => DigitCard(
        cardType: CardType.primary,
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
          LabeledField(
            label: "MultiSelect Dropdown with nested Type",
            child: Dropdown(
              onOptionSelected: (List<DropdownItem> selectedOptions) {},
              options: const [
                DropdownItem(code: '1', name: 'first', type: "Type A"),
                DropdownItem(code: '2', name: 'second', type: "Type A"),
                DropdownItem(code: '3', name: 'third', type: "Type A"),
                DropdownItem(code: '4', name: 'four', type: "Type B"),
                DropdownItem(code: '5', name: 'five', type: "Type B"),
              ],
            ),
          ),
          LabeledField(
            label: "MultiSelect Dropdown with nested Type",
            child: Dropdown(
              onOptionSelected: (List<DropdownItem> selectedOptions) {},
              options: const [
                DropdownItem(code: '1', name: 'first', type: "Type A"),
                DropdownItem(code: '2', name: 'second', type: "Type A"),
                DropdownItem(code: '3', name: 'third', type: "Type A"),
                DropdownItem(code: '4', name: 'four', type: "Type B"),
                DropdownItem(code: '5', name: 'five', type: "Type B"),
              ],
            ),
          ),
          LabeledField(
            label: "MultiSelect Dropdown with nested Type",
            child: Dropdown(
              onOptionSelected: (List<DropdownItem> selectedOptions) {},
              options: const [
                DropdownItem(code: '1', name: 'first', type: "Type A"),
                DropdownItem(code: '2', name: 'second', type: "Type A"),
                DropdownItem(code: '3', name: 'third', type: "Type A"),
                DropdownItem(code: '4', name: 'four', type: "Type B"),
                DropdownItem(code: '5', name: 'five', type: "Type B"),
              ],
            ),
          ),
          LabeledField(
            label: "MultiSelect Dropdown with nested Type",
            child: Dropdown(
              onOptionSelected: (List<DropdownItem> selectedOptions) {},
              options: const [
                DropdownItem(code: '1', name: 'first', type: "Type A"),
                DropdownItem(code: '2', name: 'second', type: "Type A"),
                DropdownItem(code: '3', name: 'third', type: "Type A"),
                DropdownItem(code: '4', name: 'four', type: "Type B"),
                DropdownItem(code: '5', name: 'five', type: "Type B"),
              ],
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
    Story(
      name: 'Molecule/Card/primary/3',
      builder: (context) => DigitCard(
        cardType: CardType.primary,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Upload Target'),
              Button(label: 'Download', onPressed: (){}, type: ButtonType.secondary, size: ButtonSize.medium)
            ],
          ),
          FileUploadWidget2(
            showPreview: true,
            allowMultipleImages: false,
            label: 'Upload', onFilesSelected: (DroppedFile) {  },
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Card/primary/4',
      builder: (context) => DigitCard(
        inline: true,
        cardType: CardType.primary,
        children: [
          LabeledField(
              labelInline: false,
              label: 'Text Field',
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            labelInline: false,
            label: "Dropdown",
            child: MultiSelectDropDown<int>(
              isDisabled:
              context.knobs.boolean(label: 'disabled', initial: false),
              onOptionSelected: (List<DropdownItem> selectedOptions) {},
              options: const [
                DropdownItem(code: '1', name: 'one'),
                DropdownItem(code: '2', name: 'two'),
                DropdownItem(code: '3', name: 'three'),
                DropdownItem(code: '4', name: 'four'),
                DropdownItem(code: '5', name: 'five'),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                    label: 'Clear All',
                    onPressed: () {
                      print('clicked');
                    },
                    type: ButtonType.tertiary,
                    size: ButtonSize.large),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Container(
                      width: 300,
                      child: Button(
                          mainAxisSize: MainAxisSize.max,
                          label: 'Submit',
                          onPressed: () {
                            print('pressed');
                          },
                          type: ButtonType.primary,
                          size: ButtonSize.large)),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Story(
      name: 'Molecule/Card/Secondary/1',
      builder: (context) => DigitCard(
        cardType: CardType.secondary,
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
          DigitCheckbox(label: 'Click to know more', onChanged: (value) {})
        ],
      ),
    ),
    Story(
      name: 'Molecule/Card/Secondary/2',
      builder: (context) => DigitCard(
        cardType: CardType.primary,
        children: [
          DigitCard(
            cardType: CardType.secondary,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Resource 1'),
                  Icon(
                    Icons.delete,
                    color: const DigitColors().light.primary1,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: LabeledField(
                      labelInline: false,
                      label: "Dropdown",
                      child: MultiSelectDropDown<int>(
                        isDisabled: context.knobs
                            .boolean(label: 'disabled', initial: false),
                        onOptionSelected:
                            (List<DropdownItem> selectedOptions) {},
                        options: const [
                          DropdownItem(code: '1', name: 'one'),
                          DropdownItem(code: '2', name: 'two'),
                          DropdownItem(code: '3', name: 'three'),
                          DropdownItem(code: '4', name: 'four'),
                          DropdownItem(code: '5', name: 'five'),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: LabeledField(
                        label: 'Numeric Field',
                        labelInline: false,
                        child: DigitNumericFormInput(
                          controller: TextEditingController(),
                        )),
                  ),
                ],
              )
            ],
          ),
          DigitCard(
            cardType: CardType.secondary,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Resource 1'),
                  Icon(
                    Icons.delete,
                    color: const DigitColors().light.primary1,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: LabeledField(
                      labelInline: false,
                      label: "Dropdown",
                      child: MultiSelectDropDown<int>(
                        isDisabled: context.knobs
                            .boolean(label: 'disabled', initial: false),
                        onOptionSelected:
                            (List<DropdownItem> selectedOptions) {},
                        options: const [
                          DropdownItem(code: '1', name: 'one'),
                          DropdownItem(code: '2', name: 'two'),
                          DropdownItem(code: '3', name: 'three'),
                          DropdownItem(code: '4', name: 'four'),
                          DropdownItem(code: '5', name: 'five'),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: LabeledField(
                        label: 'Numeric Field',
                        labelInline: false,
                        child: DigitNumericFormInput(
                          controller: TextEditingController(),
                        )),
                  ),
                ],
              )
            ],
          ),
          DigitCard(
            cardType: CardType.secondary,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Resource 1'),
                  Icon(
                    Icons.delete,
                    color: const DigitColors().light.primary1,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: LabeledField(
                      labelInline: false,
                      label: "Dropdown",
                      child: MultiSelectDropDown<int>(
                        isDisabled: context.knobs
                            .boolean(label: 'disabled', initial: false),
                        onOptionSelected:
                            (List<DropdownItem> selectedOptions) {},
                        options: const [
                          DropdownItem(code: '1', name: 'one'),
                          DropdownItem(code: '2', name: 'two'),
                          DropdownItem(code: '3', name: 'three'),
                          DropdownItem(code: '4', name: 'four'),
                          DropdownItem(code: '5', name: 'five'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: LabeledField(
                        label: 'Numeric Field',
                        labelInline: false,
                        child: DigitNumericFormInput(
                          controller: TextEditingController(),
                        )),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  ];
}