/// `DigitDateFormInput` is a customizable formfield widget that  extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitDateFormInput(
/// controller: _textController,
/// label: 'Username',
/// innerLabel: 'click on the icon to choose a date',
/// charCount: true,
/// helpText: 'This is a simple example of DigitDateFormInput',
/// onChange: (value) {
/// print(value);
/// },
/// ),```

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../blocs/DateSelection.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitDateFormInput extends BaseDigitFormInput {
  const DigitDateFormInput({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? infoText,
    bool? info,
    String? initialValue,
    bool readOnly = false,
    bool isDisabled = false,
    bool editable = false,
    bool charCount = false,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? innerLabel,
    String? helpText,
    bool isRequired = false,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.tap,
    bool preferToolTipBelow = false,
    IconData? suffixIcon,
    void Function(String?)? onError,
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
          isRequired: isRequired,
          isDisabled: isDisabled,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          onError: onError,
          suffixIcon: suffixIcon ?? Icons.date_range,
          initialValue: initialValue,
          validations: validations,
          onChange: onChange,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          keyboardType: TextInputType.datetime,
          showCurser: editable,
          isEditable: editable,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );

  @override
  _DigitDateFormInputState createState() => _DigitDateFormInputState();
}

class _DigitDateFormInputState extends BaseDigitFormInputState {
  DateSelectionBloc dateSelectionBloc = DateSelectionBloc();

  @override
  void onSuffixIconClick({void Function()? customFunction}) async {
    /// Show a date picker and update the controller's value

    await dateSelectionBloc.selectDate(
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: widget.initialDate,
      context: context,
      controller: controller,
    );
  }

  @override
  void onTap() async {
    /// Show a date picker and update the controller's value
    await dateSelectionBloc.selectDate(
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: widget.initialDate,
      context: context,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
