import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/utils/validators/validator.dart';
import 'package:digit_ui_components/widgets/atoms/digit_dropdown_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_search_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_text_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/filter_card.dart';
import 'package:digit_ui_components/widgets/atoms/group_menu_card.dart';
import 'package:digit_ui_components/widgets/atoms/labelled_fields.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> filterCardStories() {
  return [
    Story(
      name: 'Atom/filter Card/Horizontal/1',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        contentList: [
          LabeledField(
              label: 'Text Field',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
        ],
        secondaryActionLabel: 'clear filters',
        onSecondaryPressed: (){},
        primaryActionLabel: 'Apply Filters',
        onPrimaryPressed: () {
          // Handle the button press
          // For example, you might want to save the selected filters
          print('Filters applied!');
        },
        layoutType: FilterCardLayout.horizontal,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Horizontal/2',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        titleIcon: Icons.filter_alt,
        onCrossTap: (){},
        contentList: [
          LabeledField(
              label: 'Text Field',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
        ],
        secondaryActionLabel: 'clear filters',
        onSecondaryPressed: (){},
        primaryActionLabel: 'Apply Filters',
        onPrimaryPressed: () {
          // Handle the button press
          // For example, you might want to save the selected filters
          print('Filters applied!');
        },
        layoutType: FilterCardLayout.horizontal,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Horizontal/3',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        contentList: [
          LabeledField(
              label: 'Text Field',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
          CustomSwitch(
            mainAxisAlignment: MainAxisAlignment.center,
            value: false,
            onChanged: (value) {
              // setState(() {
              //   isSwitched = value;
              // });
            },
          ),
          RadioList(
              containerPadding: const EdgeInsets.only(right: 16, bottom: 16),
              radioDigitButtons: [
                RadioButtonModel(
                    code:'1',
                    name: 'first'
                ),
                RadioButtonModel(
                    code:'2',
                    name: 'second'
                ),
                RadioButtonModel(
                    code:'3',
                    name: 'third'
                ),
              ], onChanged: (value){}),
        ],
        secondaryActionLabel: 'clear filters',
        onSecondaryPressed: (){},
        primaryActionLabel: 'Apply Filters',
        onPrimaryPressed: () {
          // Handle the button press
          // For example, you might want to save the selected filters
          print('Filters applied!');
        },
        layoutType: FilterCardLayout.horizontal,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Horizontal/4',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        contentList: [
          LabeledField(
              label: 'Text field with min 10 char validation',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
                validations: [
                  Validator(ValidatorType.minValue, 10, errorMessage: 'Minimum length is 10 characters'),
                ],
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
          CustomSwitch(
            mainAxisAlignment: MainAxisAlignment.center,
            value: false,
            onChanged: (value) {
              // setState(() {
              //   isSwitched = value;
              // });
            },
          ),
          RadioList(
              containerPadding: const EdgeInsets.only(right: 16, bottom: 16),
              radioDigitButtons: [
                RadioButtonModel(
                    code:'1',
                    name: 'first'
                ),
                RadioButtonModel(
                    code:'2',
                    name: 'second'
                ),
                RadioButtonModel(
                    code:'3',
                    name: 'third'
                ),
              ], onChanged: (value){}),
        ],
        layoutType: FilterCardLayout.horizontal,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Horizontal/5',
      builder: (context) => ElevatedButton(
        onPressed: () {
          FilterCard.showFilterOverlay(
            titleIcon: Icons.filter_alt,
            context: context,
            title: 'Filter Options',
            contentList: [
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              RadioList(
                  containerPadding: const EdgeInsets.only(right: 8),
                  radioDigitButtons: [
                    RadioButtonModel(
                        code:'1',
                        name: 'first'
                    ),
                    RadioButtonModel(
                        code:'2',
                        name: 'second'
                    ),
                    RadioButtonModel(
                        code:'3',
                        name: 'third'
                    ),
                  ], onChanged: (value){}),

            ],
            primaryActionLabel: 'Apply Filters',
            onPrimaryPressed: () {
              // Handle the button press
              Navigator.of(context).pop(); // Close the dialog
            },
            layoutType: FilterCardLayout.horizontal,
          );
        },
        child: Text('Open Filter Overlay'),
      ),
    ),
    Story(
      name: 'Atom/filter Card/Horizontal/6',
      builder: (context) => ElevatedButton(
        onPressed: () {
          FilterCard.showFilterOverlay(
            titleIcon: Icons.filter_alt,
            context: context,
            title: 'Filter Options',
            contentList: [
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
            ],
            primaryActionLabel: 'Apply Filters',
            onPrimaryPressed: () {
              // Handle the button press
              Navigator.of(context).pop(); // Close the dialog
            },
            secondaryActionLabel: 'Clear Filters',
            onSecondaryPressed: () {

            },
            layoutType: FilterCardLayout.horizontal,
          );
        },
        child: Text('Open Filter Overlay'),
      ),
    ),



    Story(
      name: 'Atom/filter Card/Vertical/1',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        contentList: [
          LabeledField(
              label: 'Text Field',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
        ],
        secondaryActionLabel: 'clear filters',
        onSecondaryPressed: (){},
        primaryActionLabel: 'Apply Filters',
        onPrimaryPressed: () {
          // Handle the button press
          // For example, you might want to save the selected filters
          print('Filters applied!');
        },
        layoutType: FilterCardLayout.vertical,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Vertical/2',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        titleIcon: Icons.filter_alt,
        onCrossTap: (){},
        contentList: [
          LabeledField(
              label: 'Text Field',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
        ],
        secondaryActionLabel: 'clear filters',
        onSecondaryPressed: (){},
        primaryActionLabel: 'Apply Filters',
        onPrimaryPressed: () {
          // Handle the button press
          // For example, you might want to save the selected filters
          print('Filters applied!');
        },
        layoutType: FilterCardLayout.vertical,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Vertical/3',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        contentList: [
          LabeledField(
              label: 'Text Field',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
          CustomSwitch(
            mainAxisAlignment: MainAxisAlignment.start,
            value: false,
            onChanged: (value) {
              // setState(() {
              //   isSwitched = value;
              // });
            },
          ),
          RadioList(
              containerPadding: const EdgeInsets.only(right: 8),
              radioDigitButtons: [
                RadioButtonModel(
                    code:'1',
                    name: 'first'
                ),
                RadioButtonModel(
                    code:'2',
                    name: 'second'
                ),
                RadioButtonModel(
                    code:'3',
                    name: 'third'
                ),
              ], onChanged: (value){}),
        ],
        secondaryActionLabel: 'clear filters',
        onSecondaryPressed: (){},
        primaryActionLabel: 'Apply Filters',
        onPrimaryPressed: () {
          // Handle the button press
          // For example, you might want to save the selected filters
          print('Filters applied!');
        },
        layoutType: FilterCardLayout.vertical,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Vertical/4',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        contentList: [
          LabeledField(
              label: 'Text field with min 10 char validation',
              labelInline: false,
              child: DigitTextFormInput(
                controller: TextEditingController(),
                validations: [
                  Validator(ValidatorType.minValue, 10, errorMessage: 'Minimum length is 10 characters'),
                ],
              )),
          LabeledField(
            label: 'Search Field',
            labelInline: false,
            child: DigitSearchFormInput(
              controller: TextEditingController(),
            ),
          ),
          CustomSwitch(
            mainAxisAlignment: MainAxisAlignment.start,
            value: false,
            onChanged: (value) {
              // setState(() {
              //   isSwitched = value;
              // });
            },
          ),
          RadioList(
              containerPadding: const EdgeInsets.only(right: 8),
              radioDigitButtons: [
                RadioButtonModel(
                    code:'1',
                    name: 'first'
                ),
                RadioButtonModel(
                    code:'2',
                    name: 'second'
                ),
                RadioButtonModel(
                    code:'3',
                    name: 'third'
                ),
              ], onChanged: (value){}),
        ],
        layoutType: FilterCardLayout.vertical,
      ),
    ),
    Story(
      name: 'Atom/filter Card/Vertical/5',
      builder: (context) => ElevatedButton(
        onPressed: () {
          FilterCard.showFilterOverlay(
            titleIcon: Icons.filter_alt,
            context: context,
            title: 'Filter Options',
            contentList: [
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              RadioList(
                  containerPadding: const EdgeInsets.only(right: 8),
                  radioDigitButtons: [
                    RadioButtonModel(
                        code:'1',
                        name: 'first'
                    ),
                    RadioButtonModel(
                        code:'2',
                        name: 'second'
                    ),
                    RadioButtonModel(
                        code:'3',
                        name: 'third'
                    ),
                  ], onChanged: (value){}),

            ],
            primaryActionLabel: 'Apply Filters',
            onPrimaryPressed: () {
              // Handle the button press
              Navigator.of(context).pop(); // Close the dialog
            },
            layoutType: FilterCardLayout.vertical,
          );
        },
        child: Text('Open Filter Overlay'),
      ),
    ),
    Story(
      name: 'Atom/filter Card/Vertical/6',
      builder: (context) => ElevatedButton(
        onPressed: () {
          FilterCard.showFilterOverlay(
            titleIcon: Icons.filter_alt,
            context: context,
            title: 'Filter Options',
            contentList: [
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
              LabeledField(
                  label: 'Text Field',
                  labelInline: false,
                  child: DigitTextFormInput(
                    controller: TextEditingController(),
                  )),
              LabeledField(
                label: 'Search Field',
                labelInline: false,
                child: DigitSearchFormInput(
                  controller: TextEditingController(),
                ),
              ),
            ],
            primaryActionLabel: 'Apply Filters',
            onPrimaryPressed: () {
              // Handle the button press
              Navigator.of(context).pop(); // Close the dialog
            },
            secondaryActionLabel: 'Clear Filters',
            onSecondaryPressed: () {

            },
            layoutType: FilterCardLayout.vertical,
          );
        },
        child: Text('Open Filter Overlay'),
      ),
    ),

  ];
}
