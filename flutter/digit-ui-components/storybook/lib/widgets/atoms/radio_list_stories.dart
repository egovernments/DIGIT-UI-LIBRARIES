import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/widgets/atoms/digit_radio_list.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> radioListStories() {
  return [
    Story(
      name: 'Atom/Radio/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Radio/Active',
      builder: (context) {
        // Create an option knob for read-only and disabled states
        final fieldState = context.knobs.options<String>(
          label: 'Field State',
          initial: 'Default', // Ensure an initial value is set
          options: [
            Option(label: 'Default', value: 'default'),
            Option(label: 'Non Editable', value: 'readOnly'),
            Option(label: 'Disabled', value: 'disabled'),
          ],
        );

        // Set the values for readOnly and isDisabled based on the selected option
        bool isReadOnly = false;
        bool isDisabled = false;

        if (fieldState == 'readOnly') {
          isReadOnly = true;
        } else if (fieldState == 'disabled') {
          isDisabled = true;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RadioList(
                onChanged: (value) {
                  // print(value);
                },
                textDirection: context.knobs.options(label: 'Alignment', initial: TextDirection.ltr, options: [
                  Option(label: 'Left', value: TextDirection.ltr),
                  Option(label: 'Right', value: TextDirection.rtl),
                ]),
                isDisabled: isDisabled,
                readOnly: isReadOnly,
                groupValue: '1',
                radioDigitButtons: [
                  RadioButtonModel(
                      code: '1',
                      name: context.knobs
                          .text(label: 'Label', initial: "Radio")),
                ],
              ),
            ),
          ],
        );
      }
    ),
    Story(
        name: 'Atom/Radio/Inactive',
        builder: (context) {
          // Create an option knob for read-only and disabled states
          final fieldState = context.knobs.options<String>(
            label: 'Field State',
            initial: 'Default', // Ensure an initial value is set
            options: [
              Option(label: 'Default', value: 'default'),
              Option(label: 'Non Editable', value: 'readOnly'),
              Option(label: 'Disabled', value: 'disabled'),
            ],
          );

          // Set the values for readOnly and isDisabled based on the selected option
          bool isReadOnly = false;
          bool isDisabled = false;

          if (fieldState == 'readOnly') {
            isReadOnly = true;
          } else if (fieldState == 'disabled') {
            isDisabled = true;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RadioList(
                  onChanged: (value) {
                    // print(value);
                  },
                  isDisabled: isDisabled,
                  readOnly: isReadOnly,
                  groupValue: '1',
                  textDirection: context.knobs.options(label: 'Alignment', initial: TextDirection.ltr, options: [
                    Option(label: 'Left', value: TextDirection.ltr),
                    Option(label: 'Right', value: TextDirection.rtl),
                  ]),
                  radioDigitButtons: [
                    RadioButtonModel(
                        code: '',
                        name: context.knobs
                            .text(label: 'Label', initial: "Radio")),
                  ],
                ),
              ),
            ],
          );
        }
    ),
    // Story(
    //   name: 'Atom/Radio List/Error Message',
    //   builder: (context) => Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Center(
    //         child: RadioList(
    //           onChanged: (value) {
    //             // print(value);
    //           },
    //           isDisabled: context.knobs.boolean(
    //             label: 'disabled',
    //             initial: false,
    //           ),
    //           errorMessage: context.knobs.text(label: 'Error Message', initial: "Please select an option"),
    //           radioDigitButtons: [
    //             RadioButtonModel(
    //                 code: '',
    //                 name: context.knobs
    //                     .text(label: 'name1', initial: "one")),
    //             RadioButtonModel(
    //                 code: '2',
    //                 name: context.knobs
    //                     .text(label: 'name2', initial: "two")),
    //             RadioButtonModel(
    //                 code: '3',
    //                 name: context.knobs
    //                     .text(label: 'name3', initial: "three")),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  ];
}