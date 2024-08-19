///`DigitTextFormInput` is a customizable textformfield widget that extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitTextFormInput(
/// controller: _textController,
/// label: 'Username',
/// innerLabel: 'Enter your username',
/// charCount: true,
/// helpText: 'This is a simple example of DigitTextFormInput',
/// validations: [
/// // Example validation: Required field
/// Validator(ValidatorType.required),
/// ],
/// onChange: (value) {
/// print('Username changed to: $value');
/// },
/// ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitTextFormInput extends BaseDigitFormInput {
  const DigitTextFormInput({
    Key? key,
    final TextEditingController? controller,
    final String? initialValue,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final bool charCount = false,
    final String? innerLabel,
    final String? helpText,
    final String? suffixText,
    final String? prefixText,
    final IconData? suffixIcon,
    final void Function(String?)? onError,
    final List<Validator>? validations,
    final void Function(String)? onChange,
    final TextInputType? keyboardType,
    final String? errorMessage,
    final FocusNode? focusNode,
    final List<TextInputFormatter>? inputFormatters,
    final void Function(String)? onSuffixTap,
    final void Function()? onFocusLost,
  }) : super(
          key: key,
          controller: controller,
          readOnly: readOnly,
          isRequired: isRequired,
          isDisabled: isDisabled,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixText: suffixText,
          prefixText: prefixText,
          onError: onError,
          initialValue: initialValue,
          validations: validations,
          onChange: onChange,
          keyboardType: keyboardType,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          suffixIcon: suffixIcon,
          onSuffixTap: onSuffixTap,
          onFocusLost: onFocusLost,
          focusNode: focusNode,
        );

  @override
  _DigitTextFormInputState createState() => _DigitTextFormInputState();
}

class _DigitTextFormInputState extends BaseDigitFormInputState {
  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
