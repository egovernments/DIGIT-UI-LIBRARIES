///DigitLocationFormInput` is a customizable formfield widget that  extends the baseforminput.
///
/// Example usage:
/// ```dart
/// DigitLocationFormInput(
/// controller: _textController,
/// label: 'Username',
/// innerLabel: 'Click on the icon to add your current location',
/// charCount: true,
/// helpText: 'This is a simple example of DigitLocationFormInput',
/// onChange: (value) {
/// print(value);
/// },
/// ),```

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../blocs/LocationBloc.dart';
import '../../utils/validators/validator.dart';
import 'digit_base_form_input.dart';

class DigitLocationFormInput extends BaseDigitFormInput {
  const DigitLocationFormInput({
    Key? key,
    final TextEditingController? controller,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final String? initialValue,
    final bool charCount = false,
    final bool editable = false,
    final String? innerLabel,
    final String? helpText,
    final IconData? suffixIcon,
    final TextInputType? keyboardType,
    void Function(String?)? onError,
    final List<Validator>? validations,
    final void Function(String)? onChange,
    final String? errorMessage,
    final List<TextInputFormatter>? inputFormatters,
    final void Function()? onFocusLost,
    final Color? iconColor,
  }) : super(
          key: key,
          controller: controller,
          readOnly: readOnly,
          isDisabled: isDisabled,
          isRequired: isRequired,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixIcon: suffixIcon ?? Icons.my_location,
          onError: onError,
          initialValue: initialValue,
          validations: validations,
          keyboardType: keyboardType ?? TextInputType.number,
          onChange: onChange,
          showCurser: editable,
          isEditable: editable,
          errorMessage: errorMessage,
          inputFormatters: inputFormatters,
          onFocusLost: onFocusLost,
          iconColor: iconColor,
        );

  @override
  _DigitLocationFormInputState createState() => _DigitLocationFormInputState();
}

class _DigitLocationFormInputState extends BaseDigitFormInputState {
  LocationBloc locationBloc = LocationBloc();

  @override
  void onSuffixIconClick({void Function()? customFunction}) async {
    await locationBloc.getCurrentLocation(controller, widget.onChange);
  }

  @override
  void onTap() async {
    await locationBloc.getCurrentLocation(controller, widget.onChange);
  }

  @override
  Widget build(BuildContext context) {
    /// You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
