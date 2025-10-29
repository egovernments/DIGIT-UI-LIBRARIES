import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';

import '../../iframe/iframe_widget.dart';

List<Story> inputFieldStories() {
  return [
    Story(
      name: 'Atom/Input Field/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
        name: 'Atom/Input Field/Simple Text',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            wrapLabel:
                context.knobs.boolean(label: 'Wrap Label', initial: false),
            type: InputType.text,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Text with Prefix',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.text,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            prefixText:
                context.knobs.text(label: 'Prefix Text', initial: "####"),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Text with Suffix',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.text,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            controller: TextEditingController(),
            suffixText:
                context.knobs.text(label: 'Suffix Text', initial: "####"),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Text Area Field',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.textArea,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            textAreaScroll: context.knobs.options(
              label: 'Scroll Type',
              initial: TextAreaScroll.smart,
              options: const [
                Option(
                  label: 'Smart',
                  value: TextAreaScroll.smart,
                ),
                Option(
                  label: 'Vertical',
                  value: TextAreaScroll.vertical,
                ),
                Option(
                  label: 'None',
                  value: TextAreaScroll.none,
                ),
              ],
            ),
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Numeric Field',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.numeric,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            editable: context.knobs.boolean(label: 'Editable', initial: false),
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Date Field',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.date,
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            editable: context.knobs.boolean(label: 'Editable', initial: false),
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Time Field',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.time,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            editable: context.knobs.boolean(label: 'Editable', initial: false),
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
      name: 'Atom/Input Field/Search Field',
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
        final errorMessage = context.knobs.text(
          label: 'Error Message',
          initial: '',
        );

        return InputField(
          type: InputType.search,
          label: context.knobs.text(label: 'Label', initial: 'Label'),
          infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
          isRequired: context.knobs.boolean(label: 'Required', initial: false),
          helpText:
              context.knobs.text(label: 'Help Text', initial: 'help text'),
          innerLabel:
              context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
          isDisabled: isDisabled,
          readOnly: isReadOnly,
          errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
        );
      },
    ),
    Story(
        name: 'Atom/Input Field/Password Field',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );
          return InputField(
            type: InputType.password,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
    Story(
        name: 'Atom/Input Field/Location Field',
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
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          return InputField(
            type: InputType.location,
            label: context.knobs.text(label: 'Label', initial: 'Label'),
            infoText: context.knobs.text(label: 'tooltip', initial: 'info'),
            isRequired:
                context.knobs.boolean(label: 'Required', initial: false),
            helpText:
                context.knobs.text(label: 'Help Text', initial: 'help text'),
            innerLabel:
                context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
            isDisabled: isDisabled,
            readOnly: isReadOnly,
            editable: context.knobs.boolean(label: 'Editable', initial: false),
            errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
          );
        }),
  ];
}
