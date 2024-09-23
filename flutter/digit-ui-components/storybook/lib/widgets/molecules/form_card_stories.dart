import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/molecules/form_card.dart';
import 'package:digit_ui_components/widgets/atoms/dropdown_wrapper.dart';

List<Story> cardStories() {
  return [
    Story(
      name: 'Molecule/form Card/1',
      builder: (context) => DigitCard(
        cardType: CardType.primary,
        children: [
          const DigitTextBlock(
            heading: 'Heading',
          ),
          LabeledField(
              label: 'Text Field',
              child: DigitTextFormInput(
                controller: TextEditingController(),
              )),
          const SizedBox(height: 8,),
          const DigitDivider(),
          const DigitTextBlock(
            subHeading: 'Add your start and end dates for cycles',
          ),
          FileUploadWidget2(
            label: 'Upload', onFilesSelected: (file){
            return {};
          },
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/form Card/2',
      builder: (context) => FlexibleDigitCard(
        layoutType: LayoutType.horizontal,
        columnCount: 2,
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
          const SizedBox(height: 8,),
          const DigitDivider(),
          const DigitTextBlock(
            subHeading: 'Add your start and end dates for cycles',
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
        name: 'Molecule/form Card/3',
        builder: (context) => FlexibleDigitCard(
          layoutType: LayoutType.vertical,
          columnCount: 2,
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
            const SizedBox(height: 8,),
            const DigitDivider(),
            const DigitTextBlock(
              subHeading: 'Add your start and end dates for cycles',
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