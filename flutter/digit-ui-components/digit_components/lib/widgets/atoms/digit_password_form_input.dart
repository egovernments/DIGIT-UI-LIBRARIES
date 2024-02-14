/*
 `DigitPasswordFormInput` is a customizable formfield widget that extends the baseforminput.

 Example usage:
 ```dart
 DigitPasswordFormInput(
 controller: _textController,
 label: 'Username',
 innerLabel: 'Please enter a valid password',
 charCount: true,
 helpText: 'This is a simple example of DigitPasswordFormInput',
 onChange: (value) {
 print(value);
 },
 ),
 ....*/

import 'package:flutter/material.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitPasswordFormInput extends BaseDigitFormInput {
  const DigitPasswordFormInput({
    Key? key,
    required TextEditingController controller,
    String? label,
    String? infoText,
    bool? info,
    String? initialValue,
    bool readOnly = false,
    bool isDisabled = false,
    bool isRequired = false,
    bool charCount = false,
    String? innerLabel,
    String? helpText,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.tap,
    bool preferToolTipBelow = false,
    IconData suffixIcon = Icons.visibility_off,
    IconData toggleSuffixIcon = Icons.visibility,
    void Function(String?)? onError,
    void Function(String)? onSuffixTap,
    final List<Validator>? validations,
    final void Function(String)? onChange,
  }) : super(
    key: key,
    controller: controller,
    label: label,
    info: info,
    infoText: infoText,
    readOnly: readOnly,
    isRequired: isRequired,
    isDisabled: isDisabled,
    charCount: charCount,
    innerLabel: innerLabel,
    helpText: helpText,
    triggerMode: triggerMode,
    preferToolTipBelow: preferToolTipBelow,
    suffixIcon: suffixIcon,
    onError: onError,
    onSuffixTap: onSuffixTap,
    initialValue: initialValue,
    validations: validations,
    onChange: onChange,
    toggleSuffixIcon: toggleSuffixIcon,
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