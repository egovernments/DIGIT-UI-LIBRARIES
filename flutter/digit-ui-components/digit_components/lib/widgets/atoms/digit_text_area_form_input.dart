/// `DigitTextAreaFormInput` is a customizable formfield widget that extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitTextAreaFormInput(
/// controller: _textController,
/// label: 'Description',
/// innerLabel: 'Enter your details',
/// charCount: true,
/// helpText: 'This is a simple example of DigitTextAreaFormInput',
/// onChange: (value) {
/// print(value);
/// },
/// ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../enum/app_enums.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitTextAreaFormInput extends BaseDigitFormInput {
  const DigitTextAreaFormInput({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    TextAreaScroll textAreaScroll = TextAreaScroll.none,
    bool readOnly = false,
    bool isDisabled = false,
    bool isRequired = false,
    bool charCount = false,
    String? innerLabel,
    String? helpText,
    void Function(String?)? onError,
    final List<Validator>? validations,
    int maxLine = 10,
    double height = 200,
    final void Function(String)? onChange,
    final String? errorMessage,
    final List<TextInputFormatter>? inputFormatters,
  }) : super(
          key: key,
          controller: controller,
          readOnly: readOnly,
          isRequired: isRequired,
          isDisabled: isDisabled,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          onError: onError,
          maxLine: maxLine,
          initialValue: initialValue,
          height: height,
          validations: validations,
          onChange: onChange,
          textAreaScroll: textAreaScroll,
          isTextArea: true,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );

  @override
  _DigitTextAreaFormInputState createState() => _DigitTextAreaFormInputState();
}

class _DigitTextAreaFormInputState extends BaseDigitFormInputState {
  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here

    return super.build(context);
  }
}
