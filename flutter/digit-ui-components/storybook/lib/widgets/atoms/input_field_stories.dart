import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';

List<Story> inputFieldStories() {
  return [
    Story(
      name: 'Atom/Input Field/Text Field/default',
      builder: (context) => InputField(
        wrapLabel: context.knobs.boolean(label: 'Wrap Label', initial: false),
        type: InputType.text,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Text Field/prefix',
      builder: (context) => InputField(
        type: InputType.text,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        prefixText: context.knobs.text(label: 'Prefix Text', initial: "####"),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Text Field/suffix',
      builder: (context) => InputField(
        type: InputType.text,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        controller: TextEditingController(),
        suffixText: context.knobs.text(label: 'Suffix Text', initial: "####"),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Date Field',
      builder: (context) => DigitDateFormInput(
        dateSelectionType: context.knobs.options(label: 'Date Selection', initial: DateSelectionType.single, options: [const Option(label: 'Date Range', value: DateSelectionType.range),
        const Option(label: 'Single Date', value: DateSelectionType.single)]),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
        editable: context.knobs.boolean(label: 'Editable', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Time Field',
      builder: (context) => InputField(
        type: InputType.time,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
        editable: context.knobs.boolean(label: 'Editable', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Text Area Field',
      builder: (context) => InputField(
        type: InputType.textArea,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
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
      ),
    ),
    Story(
      name: 'Atom/Input Field/Search Field',
      builder: (context) => InputField(
        type: InputType.search,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Password Field',
      builder: (context) => InputField(
        type: InputType.password,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Numeric Field',
      builder: (context) => InputField(
        type: InputType.numeric,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
        editable: context.knobs.boolean(label: 'Editable', initial: false),
      ),
    ),
    Story(
      name: 'Atom/Input Field/Location Field',
      builder: (context) => InputField(
        type: InputType.location,
        label: context.knobs.text(label: 'Label', initial: 'Label'),
        infoText: context.knobs.text(label: 'Info Text', initial: 'info'),
        isRequired: context.knobs.boolean(label: 'Required', initial: true),
        helpText: context.knobs.text(label: 'Help Text', initial: 'help text'),
        innerLabel: context.knobs.text(label: 'Inner Label', initial: 'innerlabel'),
        isDisabled: context.knobs.boolean(label: 'Disable', initial: false),
        readOnly: context.knobs.boolean(label: 'Read Only', initial: false),
        editable: context.knobs.boolean(label: 'Editable', initial: false),
      ),
    ),
  ];
}
