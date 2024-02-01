import 'package:digit_components/enum/app_enums.dart';
import 'package:digit_components/models/DropdownModels.dart';
import 'package:digit_components/models/RadioButtonModel.dart';
import 'package:digit_components/models/TreeModel.dart';
import 'package:digit_components/models/toggleButtonModel.dart';
import 'package:digit_components/utils/validators/validator.dart';
import 'package:digit_components/widgets/atoms/digit_button.dart';
import 'package:digit_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_components/widgets/atoms/digit_date_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_dropdown_input.dart';
import 'package:digit_components/widgets/atoms/digit_location_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_multiselect_dropdown.dart';
import 'package:digit_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_password_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_radio_list.dart';
import 'package:digit_components/widgets/atoms/digit_search_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_text_area_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_text_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_time_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_toggle_list.dart';
import 'package:digit_components/widgets/atoms/digit_tree_select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        AlignmentAddon(
          initialAlignment: Alignment.center,
        ),
        // ThemeAddon(themes: themes, themeBuilder: themeBuilder)
      ],
      directories: [
        WidgetbookFolder(
          name: 'input text component',
          children: [
            WidgetbookComponent(
              name: 'text',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitTextFormInput(
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: 'title',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
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
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitTextFormInput(
                      controller: TextEditingController(),
                      isDisabled: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                      validations: [
                        Validator(ValidatorType.maxLength, 10,
                            errorMessage: 'Maximum length is 10.'),
                        Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                            errorMessage: 'Invalid format.'),
                      ],
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitTextFormInput(
                      controller: TextEditingController(),
                      readOnly: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                      validations: [
                        Validator(ValidatorType.maxLength, 10,
                            errorMessage: 'Maximum length is 10.'),
                        Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                            errorMessage: 'Invalid format.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'date',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitDateFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: 'title',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitDateFormInput(
                      controller: TextEditingController(),
                      isDisabled: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitDateFormInput(
                      controller: TextEditingController(),
                      readOnly: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'time',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitTimeFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: Container(
                      height: 100,
                      child: DigitTimeFormInput(
                        isDisabled: true,
                        controller: TextEditingController(),
                        label: context.knobs.string(
                          label: 'Title',
                          initialValue: '',
                        ),
                        helpText: context.knobs.string(
                          label: 'help text',
                          initialValue: '',
                        ),
                        charCount: context.knobs.boolean(
                          label: 'char count',
                          initialValue: false,
                        ),
                        innerLabel: context.knobs.string(
                          label: 'inner label',
                          initialValue: '',
                        ),
                        info: context.knobs.boolean(
                          label: 'info',
                          initialValue: false,
                        ),
                        infoText: context.knobs.string(
                          label: 'infoText',
                          initialValue: 'this is info',
                        ),
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: Container(
                      height: 100,
                      child: DigitTimeFormInput(
                        controller: TextEditingController(),
                        readOnly: true,
                        label: context.knobs.string(
                          label: 'Title',
                          initialValue: '',
                        ),
                        helpText: context.knobs.string(
                          label: 'help text',
                          initialValue: '',
                        ),
                        charCount: context.knobs.boolean(
                          label: 'char count',
                          initialValue: false,
                        ),
                        innerLabel: context.knobs.string(
                          label: 'inner label',
                          initialValue: '',
                        ),
                        info: context.knobs.boolean(
                          label: 'info',
                          initialValue: false,
                        ),
                        infoText: context.knobs.string(
                          label: 'infoText',
                          initialValue: 'this is info',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Search',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: Container(
                      height: 100,
                      child: DigitSearchFormInput(
                        controller: TextEditingController(),
                        label: context.knobs.string(
                          label: 'Title',
                          initialValue: '',
                        ),
                        isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                        helpText: context.knobs.string(
                          label: 'help text',
                          initialValue: '',
                        ),
                        charCount: context.knobs.boolean(
                          label: 'char count',
                          initialValue: false,
                        ),
                        innerLabel: context.knobs.string(
                          label: 'inner label',
                          initialValue: '',
                        ),
                        info: context.knobs.boolean(
                          label: 'info',
                          initialValue: false,
                        ),
                        infoText: context.knobs.string(
                          label: 'infoText',
                          initialValue: 'this is info',
                        ),
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitSearchFormInput(
                      isDisabled: true,
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitSearchFormInput(
                      readOnly: true,
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Password',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitPasswordFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                      validations: [
                        Validator(ValidatorType.minLength, 6,
                            errorMessage:
                            'Password must be at least 6 characters.'),
                      ],
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitPasswordFormInput(
                      isDisabled: true,
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                      validations: [
                        Validator(ValidatorType.minLength, 6,
                            errorMessage:
                            'Password must be at least 6 characters.'),
                      ],
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitPasswordFormInput(
                      readOnly: true,
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                      validations: [
                        Validator(ValidatorType.minLength, 6,
                            errorMessage:
                            'Password must be at least 6 characters.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Numeric',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitNumericFormInput(
                      controller: TextEditingController(),
                      step: context.knobs.doubleOrNull
                          .slider(
                        label: 'step',
                        min: 0,
                        initialValue: 1,
                        max: 10,
                        divisions: 10,
                      )
                          ?.toInt() ??
                          0,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitNumericFormInput(
                      isDisabled: true,
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitNumericFormInput(
                      readOnly: true,
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Location',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitLocationFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitLocationFormInput(
                      controller: TextEditingController(),
                      isDisabled: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitLocationFormInput(
                      controller: TextEditingController(),
                      readOnly: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Text Area',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      isRequired: context.knobs.boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      isDisabled: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      readOnly: true,
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      charCount: context.knobs.boolean(
                        label: 'char count',
                        initialValue: false,
                      ),
                      innerLabel: context.knobs.string(
                        label: 'inner label',
                        initialValue: '',
                      ),
                      info: context.knobs.boolean(
                        label: 'info',
                        initialValue: false,
                      ),
                      infoText: context.knobs.string(
                        label: 'infoText',
                        initialValue: 'this is info',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Radio',
          children: [
            WidgetbookComponent(
              name: 'Radio Selection',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child:  DigitRadioList(
                      onChanged: (value) {
                        // print(value);
                      },
                      isDisabled: context.knobs.boolean(
                        label: 'disabled',
                        initialValue: false,
                      ),
                      radioButtons: [
                        RadioButtonModel(
                            code: '', name: context.knobs.string(label: 'name1', initialValue: "one")),
                        RadioButtonModel(code: '2', name: context.knobs.string(label: 'name2', initialValue: "two")),
                        RadioButtonModel(code: '3', name: context.knobs.string(label: 'name3', initialValue: "three")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Toggle Group',
              useCases: [
                WidgetbookUseCase(
                  name: 'Group',
                  builder: (context) => Center(
                    child: DigitToggleList(
                      selectedIndex: 0,
                      toggleButtons: [
                        ToggleButtonModel(
                            name: context.knobs.string(label: 'Toggle1', initialValue: 'toggle1'), key: 'key1', onSelected: (value) {print('${value}1');}),
                        ToggleButtonModel(
                            name: context.knobs.string(label: 'Toggle2', initialValue: 'toggle2'), key: 'key1', onSelected: (value) {print('${value}2');}),
                        ToggleButtonModel(
                            name: context.knobs.string(label: 'Toggle3', initialValue: 'toggle3'), key: 'key1', onSelected: (value) {print('${value}3');}),
                      ],
                      onChanged: (selectedValues) {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'dropdown',
          children: [
            WidgetbookComponent(
              name: 'Single Select',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitDropdown<int>(
                    isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false,),
                    onChange: (String value, String index) => print(value),
                    textEditingController: TextEditingController(),
                    isSearchable: context.knobs.boolean(label: 'Searchable', initialValue: false),
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
                      ),
                    )
                        .toList(),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'nested',
                  builder: (context) => DigitDropdown<int>(
                    isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false,),
                    onChange: (String value, String type) => {
                      print(value),
                      print(type),
                    },
                    textEditingController: TextEditingController(),
                    dropdownType: DropdownType.nestedSelect,
                    isSearchable: context.knobs.boolean(label: 'Searchable', initialValue: false),
                    items: const [
                      DropdownItem(
                        name: 'one',
                        code: '1',
                        type: 'group B',
                      ),
                      DropdownItem(
                        name: 'two',
                        code: '2',
                        type: 'group A',
                      ),
                      DropdownItem(
                        name: 'three',
                        code: '3',
                        type: 'group B',
                      ),
                      DropdownItem(
                        name: 'four',
                        code: '4',
                        type: 'group A',
                      ),
                      DropdownItem(
                        name: 'five',
                        code: '4',
                        type: 'group B',
                      ),
                      DropdownItem(
                        name: 'six',
                        code: '5',
                        type: 'group A',
                      ),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'nested text',
                  builder: (context) => DigitDropdown<int>(
                    isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false,),
                    onChange: (String value, String index) => {
                      print(value),
                      print(index),
                    },
                    isSearchable: context.knobs.boolean(label: 'Searchable', initialValue: false),
                    textEditingController: TextEditingController(),
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
                        description: 'description for ${item.value} one',
                      ),
                    )
                        .toList(),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'with icon',
                  builder: (context) => DigitDropdown<int>(
                    isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false,),
                    onChange: (String value, String index) => {
                      print(value),
                      print(index),
                    },
                    textEditingController: TextEditingController(),
                    isSearchable: context.knobs.boolean(label: 'Searchable', initialValue: false),
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
                        textIcon: Icons.article,
                      ),
                    )
                        .toList(),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'profile select',
                  builder: (context) => DigitDropdown<int>(
                    isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false,),
                    onChange: (String value, String index) => {
                      print(value),
                      print(index),
                    },
                    isSearchable: context.knobs.boolean(label: 'Searchable', initialValue: false),
                    textEditingController: TextEditingController(),
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
                        profileImage: const NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Multi Select',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: MultiSelectDropDown<int>(
                      isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                      onOptionSelected:
                          (List<DropdownItem> selectedOptions) {},
                      options: const [
                        DropdownItem(code: '1', name: 'one'),
                        DropdownItem(
                            code: '2', name: 'two'),
                        DropdownItem(code: '3', name: 'three'),
                        DropdownItem(code: '4', name: 'four'),
                        DropdownItem(code: '5', name: 'five'),
                      ],
                      selectionType: SelectionType.multiSelect,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'preSelected',
                  builder: (context) => Center(
                    child: MultiSelectDropDown<int>(
                      isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                      onOptionSelected:
                          (List<DropdownItem> selectedOptions) {},
                      selectedOptions: const [DropdownItem(code: '1', name: 'one'),DropdownItem(code: '3', name: 'three'),
                        DropdownItem(code: '4', name: 'four'),],
                      options: const [
                        DropdownItem(code: '1', name: 'one'),
                        DropdownItem(
                            code: '2', name: 'two'),
                        DropdownItem(code: '3', name: 'three'),
                        DropdownItem(code: '4', name: 'four'),
                        DropdownItem(code: '5', name: 'five'),
                      ],
                      selectionType: SelectionType.multiSelect,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'nested',
                  builder: (context) => Center(
                    child: MultiSelectDropDown<int>(
                      isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                      onOptionSelected:
                          (List<DropdownItem> selectedOptions) {},
                      options: const [
                        DropdownItem(
                            code: '1',
                            name: 'one',
                            description: 'description for one',
                            type: 'Group A'
                        ),
                        DropdownItem(
                            code: '2',
                            name: 'two',
                            description: 'description for two',
                            type: 'Group B'
                        ),
                        DropdownItem(
                            code: '3',
                            name: 'three',
                            description: 'description for third',
                            type: 'Group B'
                        ),
                        DropdownItem(
                            code: '4',
                            name: 'four',
                            description: 'description for four',
                            type: 'Group B'
                        ),
                        DropdownItem(
                            code: '5',
                            name: 'five',
                            description: 'description for five',
                            type: 'Group A'
                        ),
                      ],
                      selectionType: SelectionType.nestedMultiSelect,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'nested text',
                  builder: (context) => Center(
                    child: MultiSelectDropDown<int>(
                      isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                      onOptionSelected:
                          (List<DropdownItem> selectedOptions) {},
                      options: const [
                        DropdownItem(
                          code: '1',
                          name: 'first',
                          description: 'this is first',
                        ),
                        DropdownItem(
                          code: '2',
                          name: 'second',
                          description: 'this is second',
                        ),
                        DropdownItem(
                          code: '3',
                          name: 'third',
                          description: 'this is third',
                        ),
                        DropdownItem(
                          code: '4',
                          name: 'four',
                          description: 'this is fourth',
                        ),
                        DropdownItem(
                          code: '5',
                          name: 'five',
                          description: 'this is fifth',
                        ),
                      ],
                      selectionType: SelectionType.multiSelect,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'with icon',
                  builder: (context) => Center(
                    child: MultiSelectDropDown<int>(
                      isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                      onOptionSelected:
                          (List<DropdownItem> selectedOptions) {},
                      options: const [
                        DropdownItem(
                          code: '1',
                          name: 'first',
                          textIcon: Icons.article,
                        ),
                        DropdownItem(
                          code: '2',
                          name: 'second',
                          textIcon: Icons.article,
                        ),
                        DropdownItem(
                          code: '3',
                          name: 'third',
                          textIcon: Icons.article,
                        ),
                        DropdownItem(
                          code: '4',
                          name: 'four',
                          textIcon: Icons.article,
                        ),
                        DropdownItem(
                          code: '5',
                          name: 'five',
                          textIcon: Icons.article,
                        ),
                      ],
                      selectionType: SelectionType.multiSelect,
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Tree Select',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => TreeSelectDropDown<int>(
                    isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                    onOptionSelected: (List<TreeNode> selectedOptions) {
                      // print(selectedOptions);
                      for (TreeNode node in selectedOptions) {
                        // print("Node: ${node.value}");
                      }
                    },
                    options: [
                      TreeNode('A', 'A', [
                        TreeNode('A.A1', 'A1', [
                          TreeNode('A.A1.A3', 'A3', [
                            TreeNode('A.A1.A3.A5', 'A5', []),
                            TreeNode('A.A1.A3.A6', 'A6', []),
                          ]),
                          TreeNode('A.A1.A4', 'A4', []),
                        ]),
                        TreeNode('A.A2', 'A2', []),
                      ]),
                      TreeNode('B', 'B', [
                        TreeNode('B.B1', 'B1', []),
                        TreeNode('B.B2', 'B2', []),
                      ]),
                      TreeNode('C', 'C', [
                        TreeNode('C.C1', 'C1', []),
                        TreeNode('C.C2', 'C2', []),
                      ]),
                      TreeNode('D', 'D', [
                        TreeNode('D.D1', 'D1', []),
                        TreeNode('D.D2', 'D2', []),
                      ]),
                    ],
                    treeSelectionType: TreeSelectionType.singleSelect,
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Multi Select Tree',
                  builder: (context) => TreeSelectDropDown<int>(
                    isDisabled: context.knobs.boolean(label: 'disabled', initialValue: false),
                    onOptionSelected: (List<TreeNode> selectedOptions) {
                      for (TreeNode node in selectedOptions) {
                        // print("Node: ${node.value}");
                      }
                    },
                    options: [
                      TreeNode('A', 'A', [
                        TreeNode('A.A1', 'A1', [
                          TreeNode('A.A1.A3', 'A3', [
                            TreeNode('A.A1.A3.A5', 'A5', []),
                            TreeNode('A.A1.A3.A6', 'A6', []),
                          ]),
                          TreeNode('A.A1.A4', 'A4', []),
                        ]),
                        TreeNode('A.A2', 'A2', []),
                      ]),
                      TreeNode('B', 'B', [
                        TreeNode('B.B1', 'B1', []),
                        TreeNode('B.B2', 'B2', []),
                      ]),
                      TreeNode('C', 'C', [
                        TreeNode('C.C1', 'C1', []),
                        TreeNode('C.C2', 'C2', []),
                      ]),
                      TreeNode('D', 'D', [
                        TreeNode('D.D1', 'D1', []),
                        TreeNode('D.D2', 'D2', []),
                      ]),
                    ],
                    treeSelectionType: TreeSelectionType.MultiSelect,
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Buttons',
          children: [
            WidgetbookComponent(
              name: 'primary',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Primary Button'),
                    onPressed: () {
                      // Add your primary button logic here
                      print('Primary button pressed');
                    },
                    type: ButtonType.primary,
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'prefixIcon',
                  builder: (context) => DigitButton(
                    prefixIcon:
                    context.knobs.list(label: 'prefixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                    label: context.knobs.string(label: 'Label' , initialValue: 'Primary Button'),
                    onPressed: () {
                      // Add your primary button logic here
                      print('Primary button pressed');
                    },
                    type: ButtonType.primary,
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'suffixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Primary Button'),
                    onPressed: () {
                      // Add your primary button logic here
                      print('Primary button pressed');
                    },
                    type: ButtonType.primary,
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    suffixIcon:
                    context.knobs.list(label: 'suffixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'secondary',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Secondary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('Secondary button pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.secondary,
                  ),
                ),
                WidgetbookUseCase(
                  name: 'prefixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Secondary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('Secondary button pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.secondary,
                    prefixIcon:
                    context.knobs.list(label: 'prefixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'suffixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Secondary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('Secondary button pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.secondary,
                    suffixIcon:
                    context.knobs.list(label: 'suffixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'tertiary',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Tertiary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('tertiary button pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.tertiary,
                  ),
                ),
                WidgetbookUseCase(
                  name: 'prefixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Tertiary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('tertiary button pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.tertiary,
                    prefixIcon:
                    context.knobs.list(label: 'prefixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'suffixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'Tertiary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('tertiary button pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.tertiary,
                    suffixIcon:
                    context.knobs.list(label: 'suffixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'link',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'link'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('link pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.link,
                  ),
                ),
                WidgetbookUseCase(
                  name: 'prefixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'link'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('link pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.link,
                    prefixIcon:
                    context.knobs.list(label: 'prefixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'suffixIcon',
                  builder: (context) => DigitButton(
                    label: context.knobs.string(label: 'Label' , initialValue: 'link'),
                    onPressed: () {
                      // Add your secondary button logic here
                      print('link pressed');
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disable',
                      initialValue: false,
                    ),
                    type: ButtonType.link,
                    suffixIcon:
                    context.knobs.list(label: 'suffixIcon', options: [
                      Icons.arrow_forward,
                      Icons.add,
                      Icons.crop_square_sharp,
                      Icons.circle,
                      Icons.location_disabled_outlined,
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Checkbox ',
          children: [
            WidgetbookComponent(
              name: 'Checkbox',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => DigitCheckbox(
                    label: context.knobs.string(
                      label: 'Label',
                      initialValue: 'Checkbox Label',
                    ),
                    value: context.knobs.boolean(
                      label: 'Initial Value',
                      initialValue: false,
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                    disabled: context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
