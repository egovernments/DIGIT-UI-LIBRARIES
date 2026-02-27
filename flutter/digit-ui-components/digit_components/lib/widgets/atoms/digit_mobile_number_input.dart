///`DigitMobileNumberInput` is a customizable mobile number input widget that extends the baseforminput.
///
/// It supports an optional country code dropdown that replaces the prefix text area.
///
/// Example usage:
/// ```dart
/// DigitMobileNumberInput(
///   controller: _mobileController,
///   innerLabel: 'Enter mobile number',
///   showCountryCodeDropdown: true,
///   countryCodes: ['+91', '+1', '+44', '+61'],
///   defaultCountryCode: '+91',
///   onCountryCodeChanged: (code) {
///     print('Selected country code: $code');
///   },
///   validations: [
///     Validator(ValidatorType.mobileNumber),
///   ],
///   onChange: (value) {
///     print('Mobile number: $value');
///   },
/// ),
/// ```

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/utils.dart';
import '../../utils/validators/validator.dart';

class DigitMobileNumberInput extends BaseDigitFormInput {
  /// Whether to show a country code dropdown in the prefix area.
  final bool showCountryCodeDropdown;

  /// List of country code strings to display in the dropdown (e.g. ['+91', '+1', '+44']).
  final List<String>? countryCodes;

  /// The default selected country code from the [countryCodes] list.
  /// If not provided, the first item in [countryCodes] is used.
  final String? defaultCountryCode;

  /// Callback triggered when the user selects a different country code.
  final void Function(String)? onCountryCodeChanged;

  DigitMobileNumberInput({
    Key? key,
    this.showCountryCodeDropdown = false,
    this.countryCodes,
    this.defaultCountryCode,
    this.onCountryCodeChanged,
    final TextEditingController? controller,
    final String? initialValue,
    final bool readOnly = false,
    final bool isDisabled = false,
    final bool isRequired = false,
    final bool charCount = false,
    final String? innerLabel,
    final String? helpText,
    final String? suffixText,
    final String? prefixText,
    final IconData? suffixIcon,
    final void Function(String?)? onError,
    final List<Validator>? validations,
    final void Function(String)? onChange,
    final TextInputType? keyboardType,
    final String? errorMessage,
    final FocusNode? focusNode,
    final List<TextInputFormatter>? inputFormatters,
    final void Function(String)? onSuffixTap,
    final void Function()? onFocusLost,
    final EdgeInsetsGeometry? contentPadding,
    final int? maxLength,
    final TextStyle? suffixTextStyle,
    final TextStyle? prefixTextStyle,
  }) : super(
          key: key,
          controller: controller,
          readOnly: readOnly,
          isRequired: isRequired,
          isDisabled: isDisabled,
          charCount: charCount,
          innerLabel: innerLabel,
          helpText: helpText,
          suffixText: suffixText,
          prefixText: (showCountryCodeDropdown &&
                  countryCodes != null &&
                  countryCodes.isNotEmpty)
              ? null
              : prefixText,
          onError: onError,
          initialValue: initialValue,
          validations: validations,
          onChange: onChange,
          keyboardType: keyboardType ?? TextInputType.phone,
          errorMessage: errorMessage,
          inputFormatters:
              inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: suffixIcon,
          onSuffixTap: onSuffixTap,
          onFocusLost: onFocusLost,
          focusNode: focusNode,
          maxLength: maxLength,
          contentPadding: contentPadding,
          suffixTextStyle: suffixTextStyle,
          prefixTextStyle: prefixTextStyle,
        );

  @override
  _DigitMobileNumberInputState createState() =>
      _DigitMobileNumberInputState();
}

class _DigitMobileNumberInputState extends BaseDigitFormInputState {
  String? _selectedCountryCode;

  /// Local state tracking for the custom build (used when dropdown mode is active).
  /// These parallel the base class's private fields which are not accessible from subclasses.
  bool _localHasError = false;
  bool _localIsFocusOn = false;
  String? _localErrorMessage;

  DigitMobileNumberInput get mobileWidget =>
      widget as DigitMobileNumberInput;

  bool get _isDropdownMode =>
      mobileWidget.showCountryCodeDropdown &&
      mobileWidget.countryCodes != null &&
      mobileWidget.countryCodes!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = mobileWidget.defaultCountryCode ??
        (mobileWidget.countryCodes?.isNotEmpty == true
            ? mobileWidget.countryCodes!.first
            : null);
  }

  @override
  void didUpdateWidget(covariant BaseDigitFormInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldMobileWidget = oldWidget as DigitMobileNumberInput;
    if (mobileWidget.defaultCountryCode !=
        oldMobileWidget.defaultCountryCode) {
      setState(() {
        _selectedCountryCode = mobileWidget.defaultCountryCode;
      });
    }
  }

  @override
  void onFocusChange() {
    if (!_isDropdownMode) {
      super.onFocusChange();
      return;
    }

    if (!myFocusNode.hasFocus) {
      if (widget.onFocusLost != null) {
        widget.onFocusLost!();
      }

      final error = InputValidators.validate(
        controller.text,
        widget.validations ?? [],
      );

      setState(() {
        _localIsFocusOn = false;
        _localErrorMessage = error;
        _localHasError = error != null;
      });

      if (_localHasError) {
        widget.onError?.call(_localErrorMessage);
      }
    } else {
      setState(() {
        _localIsFocusOn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDropdownMode) {
      return super.build(context);
    }

    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    String? capitalizedInnerLabel =
        convertInToSentenceCase(widget.innerLabel);
    String? capitalizedHelpText =
        convertInToSentenceCase(widget.helpText);
    String? capitalizedErrorMessage =
        convertInToSentenceCase(widget.errorMessage);

    int? getValidatorValue(
        List<Validator>? validators, ValidatorType type) {
      for (var validator in validators!) {
        if (validator.type == type) {
          return validator.value as int?;
        }
      }
      return null;
    }

    int? maxLengthValue = widget.charCount
        ? (widget.validations != null
            ? getValidatorValue(
                    widget.validations, ValidatorType.maxLength) ??
                widget.maxLength ??
                64
            : widget.maxLength ?? 64)
        : widget.maxLength;

    width = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width
        : AppView.isTabletView(MediaQuery.of(context).size)
            ? BaseConstants.tabInputMaxWidth
            : BaseConstants.desktopInputMaxWidth;
    minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? BaseConstants.mobileInputMinWidth
        : BaseConstants.desktopInputMinWidth;

    return Container(
      width: width,
      constraints: BoxConstraints(
        minWidth: minWidth,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            onTapOutside: (PointerDownEvent event) {
              myFocusNode.unfocus();
            },
            inputFormatters: widget.inputFormatters,
            onTap: widget.readOnly ? null : onTap,
            focusNode: myFocusNode,
            controller: controller,
            readOnly:
                (widget.readOnly || !widget.isEditable) ? true : false,
            enabled: !widget.isDisabled,
            autovalidateMode: AutovalidateMode.disabled,
            minLines: widget.minLine,
            maxLines: widget.maxLine,
            keyboardType: widget.readOnly
                ? TextInputType.none
                : widget.keyboardType,
            textAlign: widget.textAlign,
            maxLength: maxLengthValue,
            showCursor: widget.readOnly
                ? false
                : widget.showCurser ?? widget.isEditable,
            style: widget.textStyle ??
                textTheme.bodyS.copyWith(
                  color: widget.readOnly
                      ? theme.colorTheme.text.secondary
                      : theme.colorTheme.text.primary,
                  decoration: TextDecoration.none,
                ),
            decoration: InputDecoration(
              counterText: '',
              hoverColor: const DigitColors().transparent,
              constraints: BoxConstraints(
                maxHeight: widget.height,
                minHeight: widget.height,
                minWidth: minWidth,
              ),
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.only(
                    top: spacer2,
                    left: spacer3,
                    bottom: spacer2,
                    right: spacer3,
                  ),
              hintText: capitalizedInnerLabel,
              hintStyle: textTheme.bodyS.copyWith(
                color: theme.colorTheme.text.disabled,
              ),
              filled: true,
              fillColor: widget.readOnly
                  ? theme.colorTheme.generic.background
                  : theme.colorTheme.generic.transparent,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      _localHasError || widget.errorMessage != null
                          ? theme.colorTheme.alert.error
                          : theme.colorTheme.generic.inputBorder,
                  width:
                      _localHasError || widget.errorMessage != null
                          ? Base.errorBorderWidth
                          : Base.defaultBorderWidth,
                ),
                borderRadius: Base.radius,
              ),
              focusedBorder: widget.readOnly
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorTheme.generic.inputBorder,
                        width: Base.defaultBorderWidth,
                      ),
                      borderRadius: Base.radius,
                    )
                  : BaseConstants.focusedBorder,
              disabledBorder: BaseConstants.disabledBorder,
              prefixIconConstraints: const BoxConstraints(
                minWidth: spacer10,
                maxHeight: spacer10,
              ),
              prefixIcon: _buildCountryCodeDropdown(theme, textTheme),
              suffixIconConstraints: widget.suffixText != null
                  ? const BoxConstraints(
                      minWidth: spacer10,
                      maxHeight: spacer10,
                    )
                  : const BoxConstraints(
                      maxHeight: spacer6,
                    ),
              suffixIcon: widget.suffixIcon != null
                  ? InkWell(
                      hoverColor:
                          theme.colorTheme.generic.transparent,
                      splashColor:
                          theme.colorTheme.generic.transparent,
                      highlightColor:
                          theme.colorTheme.generic.transparent,
                      onTap: widget.readOnly
                          ? null
                          : onSuffixIconClick,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: spacer2),
                        child: Icon(
                          widget.suffixIcon,
                          size: BaseConstants.suffixIconSize,
                        ),
                      ),
                    )
                  : null,
              suffixIconColor: widget.isDisabled
                  ? theme.colorTheme.text.disabled
                  : theme.colorTheme.text.secondary,
            ),
            onChanged: (value) {
              setState(() {});
              widget.onChange?.call(value);
            },
          ),
          if (widget.helpText != null ||
              widget.charCount ||
              _localHasError ||
              widget.errorMessage != null)
            const SizedBox(
              height: spacer1,
            ),
          if (widget.helpText != null ||
              widget.charCount ||
              _localHasError ||
              widget.errorMessage != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.helpText != null ||
                    _localHasError ||
                    widget.errorMessage != null)
                  _localHasError
                      ? Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: spacer1 / 2,
                                  ),
                                  SizedBox(
                                    height: spacer4,
                                    width: spacer4,
                                    child: Icon(
                                      Icons.info,
                                      color: theme
                                          .colorTheme.alert.error,
                                      size: BaseConstants
                                          .errorIconSize,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: spacer1),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(
                                  _localErrorMessage!.length > 256
                                      ? '${_localErrorMessage!.substring(0, 256)}...'
                                      : _localErrorMessage!,
                                  style: textTheme.bodyS.copyWith(
                                    color: theme
                                        .colorTheme.alert.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : widget.errorMessage != null
                          ? Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: spacer1 / 2,
                                      ),
                                      SizedBox(
                                        height: spacer4,
                                        width: spacer4,
                                        child: Icon(
                                          Icons.info,
                                          color: theme.colorTheme
                                              .alert.error,
                                          size: BaseConstants
                                              .errorIconSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: spacer1),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Text(
                                      capitalizedErrorMessage!
                                                  .length >
                                              256
                                          ? '${widget.errorMessage!.substring(0, 256)}...'
                                          : widget.errorMessage!,
                                      style:
                                          textTheme.bodyS.copyWith(
                                        color: theme.colorTheme
                                            .alert.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Text(
                                capitalizedHelpText!.length > 256
                                    ? '${capitalizedHelpText.substring(0, 256)}...'
                                    : capitalizedHelpText,
                                style: textTheme.bodyS.copyWith(
                                  color: theme
                                      .colorTheme.text.secondary,
                                ),
                              ),
                            ),
                if ((widget.helpText != null ||
                        _localHasError ||
                        widget.errorMessage != null) &&
                    (widget.charCount == true))
                  const SizedBox(
                    width: spacer2,
                  ),
                if (widget.helpText == null &&
                    _localHasError == false &&
                    widget.errorMessage == null)
                  const Spacer(),
                if (widget.charCount == true)
                  Text(
                    '${controller.text.length}/$maxLengthValue',
                    style: textTheme.bodyS.copyWith(
                      color: theme.colorTheme.text.secondary,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCountryCodeDropdown(
      ThemeData theme, dynamic textTheme) {
    return Container(
      constraints: const BoxConstraints(minWidth: 38),
      padding: const EdgeInsets.symmetric(
        horizontal: spacer1,
      ),
      height: (_localIsFocusOn || _localHasError) && !widget.readOnly
          ? 37
          : 38,
      margin: EdgeInsets.only(
        right: spacer2,
        left: (_localIsFocusOn || _localHasError) && !widget.readOnly
            ? 1.5
            : 1,
      ),
      decoration: BoxDecoration(
        color: theme.colorTheme.generic.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius2),
          bottomLeft: Radius.circular(radius2),
        ),
        border: Border(
          right: BorderSide(
            color: widget.isDisabled
                ? theme.colorTheme.generic.divider
                : theme.colorTheme.generic.inputBorder,
            width: Base.defaultBorderWidth,
          ),
          top: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCountryCode,
          isDense: true,
          icon: Icon(
            Icons.arrow_drop_down,
            size: spacer4,
            color: widget.isDisabled
                ? theme.colorTheme.text.disabled
                : theme.colorTheme.text.secondary,
          ),
          items: mobileWidget.countryCodes!.map((code) {
            return DropdownMenuItem<String>(
              value: code,
              child: Text(
                code,
                style: textTheme.bodyS.copyWith(
                  color: widget.isDisabled
                      ? theme.colorTheme.text.disabled
                      : theme.colorTheme.text.secondary,
                ),
              ),
            );
          }).toList(),
          onChanged: widget.isDisabled || widget.readOnly
              ? null
              : (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCountryCode = value;
                    });
                    mobileWidget.onCountryCodeChanged?.call(value);
                  }
                },
        ),
      ),
    );
  }
}
