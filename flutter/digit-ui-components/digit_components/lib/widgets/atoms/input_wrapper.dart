
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/validators/validator.dart';
import 'digit_date_form_input.dart';
import 'digit_location_form_input.dart';
import 'digit_numeric_form_input.dart';
import 'digit_password_form_input.dart';
import 'digit_search_form_input.dart';
import 'digit_text_area_form_input.dart';
import 'digit_time_form_input.dart';


enum InputType {
  date,
  location,
  numeric,
  password,
  search,
  time,
  textArea,
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final InputType type;
  final String label;
  final String? infoText;
  final bool? info;
  final String? initialValue;
  final bool readOnly;
  final bool isDisabled;
  final bool isRequired;
  final bool charCount;
  final bool editable;
  final String? innerLabel;
  final String? helpText;
  final TooltipTriggerMode triggerMode;
  final bool preferToolTipBelow;
  final IconData suffixIcon;
  final TextInputType keyboardType;
  final void Function(String?)? onError;
  final List<Validator>? validations;
  final void Function(String)? onChange;
  final String? errorMessage;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    Key? key,
    required this.controller,
    required this.type,
    required this.label,
    this.infoText,
    this.info,
    this.initialValue,
    this.readOnly = false,
    this.isDisabled = false,
    this.isRequired = false,
    this.charCount = false,
    this.editable = false,
    this.innerLabel,
    this.helpText,
    this.triggerMode = TooltipTriggerMode.tap,
    this.preferToolTipBelow = false,
    this.suffixIcon = Icons.date_range,
    this.keyboardType = TextInputType.text,
    this.onError,
    this.validations,
    this.onChange,
    this.errorMessage,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case InputType.date:
        return DigitDateFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          editable: editable,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      case InputType.location:
        return DigitLocationFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          editable: editable,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon,
          keyboardType: keyboardType,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      case InputType.numeric:
        return DigitNumericFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          editable: editable,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          keyboardType: keyboardType,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      case InputType.password:
        return DigitPasswordFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      case InputType.search:
        return DigitSearchFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      case InputType.time:
        return DigitTimeFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      case InputType.textArea:
        return DigitTextAreaFormInput(
          controller: controller,
          label: label,
          infoText: infoText,
          info: info,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          triggerMode: triggerMode,
          preferToolTipBelow: preferToolTipBelow,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
        );
      default:
        throw Exception('Invalid InputType');
    }
  }
}
