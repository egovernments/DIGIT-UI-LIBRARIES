///`DigitTextFormInput` is a customizable textformfield widget that extends the baseforminput
///
/// Example usage:
/// ```dart
/// DigitTimeFormInput(
/// controller: _textController,
/// label: 'Time Picker',
/// innerLabel: 'click on the icon to select a time',
/// charCount: true,
/// helpText: 'This is a simple example of DigitTimeFormInput',
/// onChange: (value) {
/// print(value);
/// },
/// ),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../blocs/TimeSelectionBloc.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitTimeFormInput extends BaseDigitFormInput {
  const DigitTimeFormInput({
    Key? key,
    final TextEditingController? controller,
    final bool charCount = false,
    final String? innerLabel,
    final String? helpText,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final bool editable = false,
    final IconData? suffixIcon,
    final void Function(String?)? onError,
    final TextInputType? keyboardType,
    final List<Validator>? validations,
    final String? initialValue,
    final void Function(String)? onChange,
    final String? errorMessage,
    final String? cancelText,
    final String? confirmText,
    final List<TextInputFormatter>? inputFormatters,
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
          suffixIcon: suffixIcon ?? Icons.access_time,
          onError: onError,
          initialValue: initialValue,
          validations: validations,
          onChange: onChange,
          cancelText: cancelText,
          confirmText: confirmText,
          keyboardType: keyboardType ?? TextInputType.datetime,
          showCurser: editable,
          isEditable: editable,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          onFocusLost: onFocusLost,
        );

  @override
  _DigitTimeFormInputState createState() => _DigitTimeFormInputState();
}

class _DigitTimeFormInputState extends BaseDigitFormInputState {
  @override
  void onSuffixIconClick({void Function()? customFunction}) async {
    TimeSelectionBloc timeSelectionBloc = TimeSelectionBloc();

    await timeSelectionBloc.selectTime(
      context: context,
      controller: controller,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
    );
  }

  @override
  void onTap() async {
    TimeSelectionBloc timeSelectionBloc = TimeSelectionBloc();

    await timeSelectionBloc.selectTime(
      context: context,
      controller: controller,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
