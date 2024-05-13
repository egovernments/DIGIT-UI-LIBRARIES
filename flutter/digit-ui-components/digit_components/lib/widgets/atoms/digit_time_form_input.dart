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
    required TextEditingController controller,
    String? label,
    String? infoText,
    bool? info,
    bool charCount = false,
    String? innerLabel,
    String? helpText,
    bool readOnly = false,
    bool isDisabled = false,
    bool isRequired = false,
    bool editable = false,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.tap,
    bool preferToolTipBelow = false,
    IconData? suffixIcon,
    void Function(String?)? onError,
    final List<Validator>? validations,
    String? initialValue,
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
          isRequired: isRequired,
          isDisabled: isDisabled,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon ?? Icons.access_time,
          onError: onError,
          initialValue: initialValue,
          validations: validations,
          onChange: onChange,
          keyboardType: TextInputType.datetime,
          showCurser: editable,
          isEditable: editable,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
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
      controller: widget.controller,
    );
  }

  @override
  void onTap() async {
    TimeSelectionBloc timeSelectionBloc = TimeSelectionBloc();

    await timeSelectionBloc.selectTime(
      context: context,
      controller: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
