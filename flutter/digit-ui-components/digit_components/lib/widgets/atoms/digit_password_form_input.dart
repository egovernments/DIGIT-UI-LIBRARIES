///`DigitPasswordFormInput` is a customizable formfield widget that extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitPasswordFormInput(
/// controller: _textController,
/// label: 'Username',
/// innerLabel: 'Please enter a valid password',
/// charCount: true,
/// helpText: 'This is a simple example of DigitPasswordFormInput',
/// onChange: (value) {
/// print(value);
/// },
/// ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitPasswordFormInput extends BaseDigitFormInput {
  const DigitPasswordFormInput({
    Key? key,
    final TextEditingController? controller,
    final String? initialValue,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final bool charCount = false,
    final String? innerLabel,
    final String? helpText,
    final IconData? suffixIcon,
    final IconData toggleSuffixIcon = Icons.visibility,
    final void Function(String?)? onError,
    final void Function(String)? onSuffixTap,
    final List<Validator>? validations,
    final TextInputType? keyboardType,
    final void Function(String)? onChange,
    final String? errorMessage,
    final List<TextInputFormatter>? inputFormatters,
    final void Function()? onFocusLost,
    final int? maxLength,
  }) : super(
    key: key,
    controller: controller,
    readOnly: readOnly,
    isRequired: isRequired,
    isDisabled: isDisabled,
    charCount: charCount,
    innerLabel: innerLabel,
    helpText: helpText,
    suffixIcon: suffixIcon ?? Icons.visibility_off,
    onError: onError,
    onSuffixTap: onSuffixTap,
    initialValue: initialValue,
    validations: validations,
    onChange: onChange,
    keyboardType: keyboardType,
    toggleSuffixIcon: toggleSuffixIcon,
    errorMessage: errorMessage,
    inputFormatters: inputFormatters,
    onFocusLost: onFocusLost,
    maxLength: maxLength,
  );

  @override
  _DigitPasswordFormInputState createState() => _DigitPasswordFormInputState();
}

class _DigitPasswordFormInputState extends BaseDigitFormInputState {
  @override
  void initState() {
    /// Call the initState method of the base class
    super.initState();

    /// Set the initial value of isVisible to true
    isVisible = true;
  }

  @override
  void toggleObsecureText() {
    /// Call the base class implementation
    super.toggleObsecureText();
  }

  @override
  void onSuffixIconClick({void Function()? customFunction}) {
    toggleObsecureText();
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}