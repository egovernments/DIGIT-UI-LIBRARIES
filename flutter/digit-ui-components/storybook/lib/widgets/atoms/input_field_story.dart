import 'package:digit_ui_components/utils/validators/validator.dart';
import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/atoms/digit_date_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_location_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_password_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_search_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_text_area_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_text_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_time_form_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> inputFieldStories() {
  return [
    Story(
      name: 'Input Field/Text Field/default',
      builder: (context) => DigitTextFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Text Field/prefix',
      builder: (context) => DigitTextFormInput(
        controller: TextEditingController(),
        prefixText: "####",
        label: context.knobs.text(
          label: 'Title',
          initial: '',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
      ),
    ),
    Story(
      name: 'Input Field/Text Field/suffix',
      builder: (context) => DigitTextFormInput(
        controller: TextEditingController(),
        suffixText: "####",
        label: context.knobs.text(
          label: 'Title',
          initial: '',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
      ),
    ),
    Story(
      name: 'Input Field/Date Field',
      builder: (context) => DigitDateFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Time Field',
      builder: (context) => DigitTimeFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Text Area Field',
      builder: (context) => DigitTextAreaFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Search Field',
      builder: (context) => DigitSearchFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Password Field',
      builder: (context) => DigitPasswordFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Numeric Field',
      builder: (context) => DigitNumericFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Location Field',
      builder: (context) => DigitLocationFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
    Story(
      name: 'Input Field/Password Field',
      builder: (context) => DigitPasswordFormInput(
        label: context.knobs.text(
          label: 'Title',
          initial: 'title',
        ),
        helpText: context.knobs.text(
          label: 'help text',
          initial: '',
        ),
        charCount: context.knobs.boolean(
          label: 'char count',
          initial: false,
        ),
        innerLabel: context.knobs.text(
          label: 'inner label',
          initial: '',
        ),
        info: context.knobs.boolean(
          label: 'info',
          initial: false,
        ),
        infoText: context.knobs.text(
          label: 'infoText',
          initial: 'this is info',
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initial: false,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initial: false,
        ),
        isRequired: context.knobs.boolean(
          label: 'Required',
          initial: false,
        ),
        controller: TextEditingController(),
        validations: [
          Validator(ValidatorType.maxLength, 10,
              errorMessage: 'Maximum length is 10.'),
          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
              errorMessage: 'Invalid format.'),
        ],
      ),
    ),
  ];
}
