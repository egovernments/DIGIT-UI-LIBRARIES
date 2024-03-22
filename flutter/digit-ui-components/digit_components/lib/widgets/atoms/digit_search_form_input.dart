/*
 `DigitSearchFormInput` is a customizable form-field widget that extends the baseforminput.

 Example usage:
 ```dart
 DigitSearchFormInput(
 controller: _textController,
 label: 'Search',
 innerLabel: 'Enter your username',
 charCount: true,
 helpText: 'This is a simple example of DigitSearchFormInput',
 onChange: (value) {
 print(value);
 },
 onSuffixTap(value){}
 ),
 ....*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitSearchFormInput extends BaseDigitFormInput {
  const DigitSearchFormInput({
    Key? key,
    required TextEditingController controller,
    String? label,
    String? infoText,
    bool? info,
    bool charCount = false,
    String? initialValue,
    String? innerLabel,
    String? helpText,
    bool readOnly = false,
    bool isDisabled = false,
    bool isRequired = false,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.tap,
    bool preferToolTipBelow = false,
    IconData? suffixIcon,
    void Function(String?)? onError,
    void Function(String)? onSuffixTap,
    final List<Validator>? validations,
    final void Function(String)? onChange,
    final String? errorMessage,
    final List<TextInputFormatter>? inputFormatters,
  }) : super(
          key: key,
          controller: controller,
          label: label,
          info: info,
          infoText: infoText,
          readOnly: readOnly,
          initialValue: initialValue,
          isRequired: isRequired,
          isDisabled: isDisabled,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon ?? Icons.search,
          onError: onError,
          onSuffixTap: onSuffixTap,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );

  @override
  _DigitSearchFormInputState createState() => _DigitSearchFormInputState();
}

class _DigitSearchFormInputState extends BaseDigitFormInputState {
  @override
  void onSuffixIconClick({void Function()? customFunction}) {
    /// Use the onTap function directly
    widget.onSuffixTap?.call(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
