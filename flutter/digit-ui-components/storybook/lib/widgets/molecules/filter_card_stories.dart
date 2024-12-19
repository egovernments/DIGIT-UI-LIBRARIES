import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/utils/validators/validator.dart';
import 'package:digit_ui_components/widgets/atoms/digit_dropdown_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/filter_card.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> filterCardStories() {
  return [
    Story(
      name: 'Molecule/Filter Card/Horizontal/Basic',
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
      name: 'Molecule/Filter Card/Horizontal/With header icon',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        titleIcon: Icons.filter_alt,
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
      name: 'Molecule/Filter Card/Horizontal/With close icon',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        onCrossTap: (cont){},
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
          DigitSwitch(
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
      name: 'Molecule/Filter Card/Horizontal/As popUp',
      builder: (context) => ElevatedButton(
        onPressed: () {
          FilterCard.showFilterOverlay(
            titleIcon: Icons.filter_alt,
            context: context,
            title: 'Filter Options',
            onCrossTap: (currentContext){
              Navigator.of(currentContext).pop();
            },
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
      name: 'Molecule/Filter Card/Vertical/Basic',
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
      name: 'Molecule/Filter Card/Vertical/With header icon',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        titleIcon: Icons.filter_alt,
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
      name: 'Molecule/Filter Card/Vertical/With close icon',
      builder: (context) => FilterCard.buildFilterCard(
        context: context,
        title: 'Filter Options',
        onCrossTap: (cont){},
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
          DigitSwitch(
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
      name: 'Molecule/Filter Card/Vertical/As popUp',
      builder: (context) => ElevatedButton(
        onPressed: () {
          FilterCard.showFilterOverlay(
            titleIcon: Icons.filter_alt,
            context: context,
            title: 'Filter Options',
            onCrossTap: (currentContext){
              Navigator.of(currentContext).pop();
            },
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
  ];
}
