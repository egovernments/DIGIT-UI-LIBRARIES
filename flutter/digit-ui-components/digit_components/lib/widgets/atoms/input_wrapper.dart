import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/tooltip_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators/validator.dart';

enum InputType {
  text,
  date,
  location,
  numeric,
  password,
  search,
  time,
  textArea,
}

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final InputType type;
  final String? label;
  final String? infoText;
  final String? initialValue;
  final bool readOnly;
  final bool isDisabled;
  final bool isRequired;
  final bool charCount;
  final bool editable;
  final String? innerLabel;
  final String? helpText;
  final String? suffixText;
  final String? prefixText;
  final TooltipTrigger tooltipTrigger;
  final bool preferToolTipBelow;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String?)? onError;
  final List<Validator>? validations;
  final void Function(String)? onChange;
  final String? errorMessage;
  final List<TextInputFormatter>? inputFormatters;
  final TextAreaScroll textAreaScroll;
  final void Function(String)? onSuffixTap;
  final String? cancelText;
  final String? confirmText;

  /// specifically for date component
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// Step value (used for specific input types like numeric).
  final int step;

  /// Minimum allowed value (used for specific input types like numeric).
  final int minValue;

  /// Maximum allowed value (used for specific input types like numeric).
  final int maxValue;

  final bool wrapLabel;

  const InputField({
    Key? key,
    this.controller,
    required this.type,
    this.label,
    this.infoText,
    this.initialValue,
    this.readOnly = false,
    this.isDisabled = false,
    this.isRequired = false,
    this.charCount = false,
    this.editable = false,
    this.innerLabel,
    this.helpText,
    this.tooltipTrigger = TooltipTrigger.onTap,
    this.preferToolTipBelow = false,
    this.suffixIcon,
    this.keyboardType,
    this.onError,
    this.validations,
    this.onChange,
    this.errorMessage,
    this.inputFormatters,
    this.textAreaScroll = TextAreaScroll.smart,
    this.suffixText,
    this.prefixText,
    this.initialDate,
    this.lastDate,
    this.firstDate,
    this.onSuffixTap,
    this.step = 1,
    this.minValue = 0,
    this.maxValue = 100,
    this.wrapLabel = false,
    this.confirmText,
    this.cancelText,
  }) : super(key: key);

  Widget _buildChildWidget(BuildContext context) {
    switch (type) {
      case InputType.text:
        return DigitTextFormInput(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          keyboardType: keyboardType,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixText: suffixText,
          prefixText: prefixText,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          onSuffixTap: onSuffixTap,
        );
      case InputType.date:
        return DigitDateFormInput(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          keyboardType: keyboardType,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          editable: editable,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          firstDate: firstDate,
          lastDate: lastDate,
          initialDate: initialDate,
          confirmText: confirmText,
          cancelText: cancelText,
        );
      case InputType.location:
        return DigitLocationFormInput(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          editable: editable,
          innerLabel: innerLabel,
          helpText: helpText,
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
          step: step,
          maxValue: maxValue,
          minValue: minValue,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          editable: editable,
          innerLabel: innerLabel,
          helpText: helpText,
          keyboardType: keyboardType,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
        );
      case InputType.password:
        return DigitPasswordFormInput(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          keyboardType: keyboardType,
          helpText: helpText,
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
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          keyboardType: keyboardType,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          onSuffixTap: onSuffixTap,
        );
      case InputType.time:
        return DigitTimeFormInput(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          keyboardType: keyboardType,
          helpText: helpText,
          suffixIcon: suffixIcon,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          editable: editable,
          cancelText: cancelText,
          confirmText: confirmText,
        );
      case InputType.textArea:
        return DigitTextAreaFormInput(
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          keyboardType: keyboardType,
          innerLabel: innerLabel,
          helpText: helpText,
          onError: onError,
          validations: validations,
          onChange: onChange,
          errorMessage: errorMessage,
          textAreaScroll: textAreaScroll,
          inputFormatters: inputFormatters,
        );
      default:
        throw Exception('Invalid InputType');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: label,
      infoText: infoText,
      isRequired: isRequired,
      wrapLabelText: wrapLabel,
      tooltipTrigger: tooltipTrigger,
      child: _buildChildWidget(context),
    );
  }
}