import 'package:digit_flutter_components/digit_components.dart';
import 'package:digit_flutter_components/enum/app_enums.dart';
import 'package:digit_flutter_components/models/DropdownModels.dart';
import 'package:digit_flutter_components/models/RadioButtonModel.dart';
import 'package:digit_flutter_components/models/TreeModel.dart';
import 'package:digit_flutter_components/models/toggleButtonModel.dart';
import 'package:digit_flutter_components/utils/validators/validator.dart';
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                  name: 'Prefix',
                  builder: (context) => Center(
                    child: DigitTextFormInput(
                      controller: TextEditingController(),
                      prefixText: "####",
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
                  name: 'suffix',
                  builder: (context) => Center(
                    child: DigitTextFormInput(
                      controller: TextEditingController(),
                      suffixText: "####",
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
                      helpText: context.knobs.string(
                        label: 'help text',
                        initialValue: '',
                      ),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2024, 2, 25),
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
                  name: 'Editable',
                  builder: (context) => Center(
                    child: DigitDateFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      editable: true,
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                  name: 'Editable',
                  builder: (context) => Center(
                    child: DigitTimeFormInput(
                      controller: TextEditingController(),
                      editable: true,
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
                  name: 'disabled',
                  builder: (context) => Center(
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
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => Center(
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
              ],
            ),
            WidgetbookComponent(
              name: 'Search',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => Center(
                    child: DigitSearchFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                  name: 'Editable',
                  builder: (context) => Center(
                    child: DigitNumericFormInput(
                      editable: true,
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                  name: 'Editable',
                  builder: (context) => Center(
                    child: DigitLocationFormInput(
                      controller: TextEditingController(),
                      editable: true,
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
                      isRequired: context.knobs
                          .boolean(label: 'Required', initialValue: false),
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
                WidgetbookUseCase(
                  name: 'Scroll Non',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      textAreaScroll: TextAreaScroll.none,
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
                  name: 'Horizontal Scroll',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      textAreaScroll: TextAreaScroll.horizontal,
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
                  name: 'Vertical Scroll',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      textAreaScroll: TextAreaScroll.vertical,
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
                  name: 'Smart Scroll',
                  builder: (context) => Center(
                    child: DigitTextAreaFormInput(
                      controller: TextEditingController(),
                      label: context.knobs.string(
                        label: 'Title',
                        initialValue: '',
                      ),
                      textAreaScroll: TextAreaScroll.smart,
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
                    child: DigitRadioList(
                      onChanged: (value) {
                        // print(value);
                      },
                      isDisabled: context.knobs.boolean(
                        label: 'disabled',
                        initialValue: false,
                      ),
                      radioButtons: [
                        RadioButtonModel(
                            code: '',
                            name: context.knobs
                                .string(label: 'name1', initialValue: "one")),
                        RadioButtonModel(
                            code: '2',
                            name: context.knobs
                                .string(label: 'name2', initialValue: "two")),
                        RadioButtonModel(
                            code: '3',
                            name: context.knobs
                                .string(label: 'name3', initialValue: "three")),
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
                            name: context.knobs.string(
                                label: 'Toggle1', initialValue: 'toggle1'),
                            code: 'key1'),
                        ToggleButtonModel(
                            name: context.knobs.string(
                                label: 'Toggle2', initialValue: 'toggle2'),
                            code: 'key1'),
                        ToggleButtonModel(
                            name: context.knobs.string(
                                label: 'Toggle3', initialValue: 'toggle3'),
                            code: 'key1'),
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
                    isDisabled: context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    ),
                    onChange: (String value, String index) => {},
                    textEditingController: TextEditingController(),
                    isSearchable: context.knobs
                        .boolean(label: 'Searchable', initialValue: false),
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
                    isDisabled: context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    ),
                    onChange: (String value, String type) => {},
                    textEditingController: TextEditingController(),
                    dropdownType: DropdownType.nestedSelect,
                    isSearchable: context.knobs
                        .boolean(label: 'Searchable', initialValue: false),
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
                    isDisabled: context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    ),
                    onChange: (String value, String index) => {},
                    isSearchable: context.knobs
                        .boolean(label: 'Searchable', initialValue: false),
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
                    isDisabled: context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    ),
                    onChange: (String value, String index) => {},
                    textEditingController: TextEditingController(),
                    isSearchable: context.knobs
                        .boolean(label: 'Searchable', initialValue: false),
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
                    isDisabled: context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    ),
                    onChange: (String value, String index) => {},
                    isSearchable: context.knobs
                        .boolean(label: 'Searchable', initialValue: false),
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
                      isDisabled: context.knobs
                          .boolean(label: 'disabled', initialValue: false),
                      onOptionSelected: (List<DropdownItem> selectedOptions) {},
                      options: const [
                        DropdownItem(code: '1', name: 'one'),
                        DropdownItem(code: '2', name: 'two'),
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
                      isDisabled: context.knobs
                          .boolean(label: 'disabled', initialValue: false),
                      onOptionSelected: (List<DropdownItem> selectedOptions) {},
                      selectedOptions: const [
                        DropdownItem(code: '1', name: 'one'),
                        DropdownItem(code: '3', name: 'three'),
                        DropdownItem(code: '4', name: 'four'),
                      ],
                      options: const [
                        DropdownItem(code: '1', name: 'one'),
                        DropdownItem(code: '2', name: 'two'),
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
                      isDisabled: context.knobs
                          .boolean(label: 'disabled', initialValue: false),
                      onOptionSelected: (List<DropdownItem> selectedOptions) {},
                      options: const [
                        DropdownItem(
                            code: '1',
                            name: 'one',
                            description: 'description for one',
                            type: 'Group A'),
                        DropdownItem(
                            code: '2',
                            name: 'two',
                            description: 'description for two',
                            type: 'Group B'),
                        DropdownItem(
                            code: '3',
                            name: 'three',
                            description: 'description for third',
                            type: 'Group B'),
                        DropdownItem(
                            code: '4',
                            name: 'four',
                            description: 'description for four',
                            type: 'Group B'),
                        DropdownItem(
                            code: '5',
                            name: 'five',
                            description: 'description for five',
                            type: 'Group A'),
                      ],
                      selectionType: SelectionType.nestedMultiSelect,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'nested text',
                  builder: (context) => Center(
                    child: MultiSelectDropDown<int>(
                      isDisabled: context.knobs
                          .boolean(label: 'disabled', initialValue: false),
                      onOptionSelected: (List<DropdownItem> selectedOptions) {},
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
                      isDisabled: context.knobs
                          .boolean(label: 'disabled', initialValue: false),
                      onOptionSelected: (List<DropdownItem> selectedOptions) {},
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
                    isDisabled: context.knobs
                        .boolean(label: 'disabled', initialValue: false),
                    onOptionSelected: (List<TreeNode> selectedOptions) {},
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
                    isDisabled: context.knobs
                        .boolean(label: 'disabled', initialValue: false),
                    onOptionSelected: (List<TreeNode> selectedOptions) {},
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
                    label: context.knobs
                        .string(label: 'Label', initialValue: 'Primary Button'),
                    onPressed: () {
                      // Add your primary button logic here
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
                    label: context.knobs
                        .string(label: 'Label', initialValue: 'Primary Button'),
                    onPressed: () {
                      // Add your primary button logic here
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
                    label: context.knobs
                        .string(label: 'Label', initialValue: 'Primary Button'),
                    onPressed: () {
                      // Add your primary button logic here
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
                    label: context.knobs.string(
                        label: 'Label', initialValue: 'Secondary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs.string(
                        label: 'Label', initialValue: 'Secondary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs.string(
                        label: 'Label', initialValue: 'Secondary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs.string(
                        label: 'Label', initialValue: 'Tertiary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs.string(
                        label: 'Label', initialValue: 'Tertiary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs.string(
                        label: 'Label', initialValue: 'Tertiary Button'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs
                        .string(label: 'Label', initialValue: 'link'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs
                        .string(label: 'Label', initialValue: 'link'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    label: context.knobs
                        .string(label: 'Label', initialValue: 'link'),
                    onPressed: () {
                      // Add your secondary button logic here
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
                    onChanged: (value) {},
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
        WidgetbookFolder(
          name: 'Stepper',
          children: [
            WidgetbookComponent(
              name: 'Stepper',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) =>  AnotherStepper(
                    activeIndex: context.knobs.doubleOrNull
                        .slider(
                      label: 'step',
                      min: 0,
                      initialValue: 1,
                      max: 10,
                      divisions: 10,
                    )
                        ?.toInt() ??
                        0,
                    stepperList:  [
                      StepperData(
                        title: "Preparing",
                        onStepTap: (){},
                      ),
                      const StepperData(
                          title: "Preparing",
                          ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                      const StepperData(
                        title: "Preparing",
                      ),
                    ],
                    stepperDirection: Axis.horizontal,
inverted: true,
                  )
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Toast',
          children: [
            WidgetbookComponent(
              name: 'Toast',
              useCases: [
                WidgetbookUseCase(
                  name: 'Success',
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DigitToast.show(context,
                          options: DigitToastOptions(
                              "Your successour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning messageour Warning message message",
                              ToastType.success));
                    },
                    child: Text("Show Toast"),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Error',
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DigitToast.show(context,
                          options: DigitToastOptions(
                              "Your error message", ToastType.error));
                    },
                    child: Text("Show Toast"),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Warning',
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DigitToast.show(context,
                          options: DigitToastOptions(
                            "Your Warning message",
                            ToastType.warning,
                          ));
                    },
                    child: Text("Show Toast"),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Info Card',
          children: [
            WidgetbookComponent(
              name: 'Info Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Info',
                  builder: (context) => InfoCard(
                    title: 'Info',
                    type: InfoType.info,
                    description:
                        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Success',
                  builder: (context) => InfoCard(
                    title: 'Success',
                    type: InfoType.success,
                    description:
                        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Error',
                  builder: (context) => InfoCard(
                    title: 'Error',
                    type: InfoType.error,
                    description:
                        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Warning',
                  builder: (context) => InfoCard(
                    title: 'Warning',
                    type: InfoType.warning,
                    description:
                        'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Info Additional Widget',
                  builder: (context) => InfoCard(
                    title: 'Info',
                    type: InfoType.info,
                    inline: context.knobs
                        .boolean(label: "inline", initialValue: false),
                    description:
                        'Application process will take a minute to complete.',
                    additionalWidgets: [
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      DigitTextFormInput(
                        controller: TextEditingController(),
                        label: 'text',
                      ),
                      DigitButton(
                        label: 'button',
                        onPressed: () {},
                        type: ButtonType.secondary,
                      )
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Info Additional Widget Error',
                  builder: (context) => InfoCard(
                    title: 'Info',
                    type: InfoType.error,
                    inline: context.knobs
                        .boolean(label: "inline", initialValue: false),
                    description:
                        'Application process will take a minute to complete.',
                    additionalWidgets: [
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      DigitCheckbox(
                          label: "Click to understand", onChanged: (value) {}),
                      DigitCheckbox(
                          label: "Click to understand", onChanged: (value) {}),
                      DigitCheckbox(
                          label: "Click to understand", onChanged: (value) {}),
                      DigitCheckbox(
                          label: "Click to understand", onChanged: (value) {}),
                      DigitCheckbox(
                          label: "Click to understand", onChanged: (value) {}),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Info Additional Widget Success',
                  builder: (context) => InfoCard(
                    title: 'Info',
                    type: InfoType.success,
                    inline: context.knobs
                        .boolean(label: "inline", initialValue: false),
                    description:
                        'Application process will take a minute to complete.',
                    additionalWidgets: [
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Info Additional Widget Warning',
                  builder: (context) => InfoCard(
                    title: 'Info',
                    type: InfoType.warning,
                    inline: context.knobs
                        .boolean(label: "inline", initialValue: false),
                    description:
                        'Application process will take a minute to complete.',
                    additionalWidgets: [
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                        'https://digit.org/wp-content/uploads/2023/06/Digit-Logo-1.png',
                        scale: 1.0,
                      ),
                      InfoCard(
                          title: "Info Text",
                          type: InfoType.error,
                          description: 'This is the warning')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Timeline',
          children: [
            WidgetbookComponent(
              name: 'Completed',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const DigitTimeline(
                    currentStep: TimelineStepState.completed,
                    label: 'Completed',
                    description: '18 / 02 / 2023',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'with additional widget',
                  builder: (context) => DigitTimeline(
                    currentStep: TimelineStepState.completed,
                    label: 'Completed',
                    description: '18 / 02 / 2023',
                    additionalWidgets: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's"),
                          DigitButton(
                            label:'Click On The Link',
                            onPressed: () {},
                            type: ButtonType.link,
                          ),
                        ],
                      ),
                      InfoCard(
                          title: "Info Text",
                          type: InfoType.error,
                          description: 'This is the warning')
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'with additional hide widget',
                  builder: (context) => DigitTimeline(
                    currentStep: TimelineStepState.completed,
                    label: 'Completed',
                    description: '18 / 02 / 2023',
                    additionalHideWidgets: [
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                      InfoCard(
                          title: "Info Text",
                          type: InfoType.error,
                          description: 'This is the warning')
                    ],
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Current',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const DigitTimeline(
                    currentStep: TimelineStepState.present,
                    label: 'Current',
                    description: '18 / 02 / 2023',
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Future',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const DigitTimeline(
                    currentStep: TimelineStepState.future,
                    label: 'Future',
                    description: '18 / 02 / 2023',
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
