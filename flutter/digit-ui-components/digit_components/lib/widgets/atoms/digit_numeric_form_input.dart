///`DigitNumericFormInput` is a customizable formfield widget that extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitNumericFormInput(
/// controller: _textController,
/// label: 'Username',
/// innerLabel: 'Enter a numeric value',
/// charCount: true,
/// helpText: 'This is a simple example of DigitNumericFormInput',
/// validations: [
/// // Example validation: Required field
/// Validator(ValidatorType.required),
/// ],
/// onChange: (value) {
/// print(value);
/// },
/// ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitNumericFormInput extends BaseDigitFormInput {
  const DigitNumericFormInput({
    Key? key,
    final TextEditingController? controller,
    final String? initialValue,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final bool charCount = false,
    final bool editable = false,
    final String? innerLabel,
    final String? helpText,
    final String suffixText = '+',
    final String prefixText = '-',
    final IconData prefixIcon = Icons.remove,
    final void Function(String?)? onError,
    final TextInputType? keyboardType,
    final TextAlign textAlign = TextAlign.center,
    final List<Validator>? validations,
    final void Function(String)? onChange,
    final int step = 5,
    final FocusNode? focusNode,
    final int minValue = 0,
    final int maxValue = 100,
    final double suffixPrefixWidth = 100,
    final List<TextInputFormatter>? inputFormatters,
    final String? errorMessage,
    final void Function()? onFocusLost,
  }) : super(
          key: key,
          controller: controller,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixText: suffixText,
          prefixText: prefixText,
          onError: onError,
          focusNode: focusNode,
          keyboardType: keyboardType ?? TextInputType.number,
          textAlign: textAlign,
          initialValue: initialValue,
          validations: validations,
          onChange: onChange,
          step: step,
          maxValue: maxValue,
          minValue: minValue,
          showCurser: editable,
          isEditable: editable,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          onFocusLost: onFocusLost,
          suffixPrefixWidth: suffixPrefixWidth,
        );

  @override
  _DigitNumericFormInputState createState() => _DigitNumericFormInputState();
}

class _DigitNumericFormInputState extends BaseDigitFormInputState {
  @override
  void onPrefixIconClick({void Function()? customFunction}) {
    setState(() {
      /// Subtract step from the input value when the prefix icon is clicked
      int currentValue = int.tryParse(controller.text) ?? 0;
      if ((currentValue - widget.step) >= widget.minValue) {
        setState(() {
          controller.text = (currentValue - widget.step).toString();
        });

        /// Remove the text selection
        controller.selection = const TextSelection.collapsed(offset: 0);
      }
      if (widget.onChange != null) {
        widget.onChange!(controller.text);
      }
    });
  }

  @override
  void onSuffixIconClick({void Function()? customFunction}) {
    setState(() {
      /// Add step to the input value when the suffix icon is clicked
      int currentValue = int.tryParse(controller.text) ?? 0;
      if ((currentValue + widget.step) <= widget.maxValue) {
        setState(() {
          controller.text = (currentValue + widget.step).toString();
        });

        /// Remove the text selection
        controller.selection = const TextSelection.collapsed(offset: 0);
      }
      if (widget.onChange != null) {
        widget.onChange!(controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
