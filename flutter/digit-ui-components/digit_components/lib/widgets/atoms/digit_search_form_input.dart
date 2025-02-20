///`DigitSearchFormInput` is a customizable form-field widget that extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitSearchFormInput(
/// controller: _textController,
/// label: 'Search',
/// innerLabel: 'Enter your username',
/// charCount: true,
/// helpText: 'This is a simple example of DigitSearchFormInput',
/// onChange: (value) {
/// print(value);
/// },
/// onSuffixTap(value){}
/// ),```

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_constants.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitSearchFormInput extends BaseDigitFormInput {
  const DigitSearchFormInput({
    Key? key,
    final TextEditingController? controller,
    final bool charCount = false,
    final String? initialValue,
    final String? innerLabel,
    final String? helpText,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final IconData? suffixIcon,
    final void Function(String?)? onError,
    final void Function(String)? onSuffixTap,
    final List<Validator>? validations,
    final void Function(String)? onChange,
    final TextInputType? keyboardType,
    final String? errorMessage,
    final List<TextInputFormatter>? inputFormatters,
    final void Function()? onFocusLost,
    final void Function(String)? onFieldSubmitted,
    final FocusNode? focusNode,
    final OutlineInputBorder? focusBorder,
    final OutlineInputBorder? enableBorder,
    final Color? iconColor,
    final int? maxLength,
    final double? height,
    final TextStyle? textStyle,
    final double? iconSize,
  }) : super(
    key: key,
    controller: controller,
    readOnly: readOnly,
    initialValue: initialValue,
    isRequired: isRequired,
    isDisabled: isDisabled,
    charCount: charCount,
    innerLabel: innerLabel,
    helpText: helpText,
    suffixIcon: suffixIcon ?? Icons.search,
    onError: onError,
    onSuffixTap: onSuffixTap,
    validations: validations,
    onChange: onChange,
    keyboardType: keyboardType,
    errorMessage: errorMessage,
    inputFormatters: inputFormatters,
    onFocusLost: onFocusLost,
    onFieldSubmitted: onFieldSubmitted,
    focusNode: focusNode,
    focusBorder: focusBorder,
    enableBorder: enableBorder,
    iconColor: iconColor,
    maxLength: maxLength,
    height: height ?? Base.height,
    textStyle: textStyle,
    iconSize: iconSize,
  );

  @override
  _DigitSearchFormInputState createState() => _DigitSearchFormInputState();
}

class _DigitSearchFormInputState extends BaseDigitFormInputState {
  @override
  void onSuffixIconClick({void Function()? customFunction}) {
    /// Use the onTap function directly
    widget.onSuffixTap?.call(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}