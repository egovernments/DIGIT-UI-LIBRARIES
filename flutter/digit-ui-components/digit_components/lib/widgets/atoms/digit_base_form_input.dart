import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/text_area_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../utils/validators/validator.dart';

/// `BaseDigitFormInput` is a base class for different form input fields. It provides a set of customizable
/// parameters and common functionality for building various types of input fields within a form.
class BaseDigitFormInput extends StatefulWidget {
  /// Text editing controller for the input field.
  final TextEditingController controller;

  /// Determines if the input field is read-only.
  final bool readOnly;

  /// Determines if the input field is required.
  final bool isRequired;

  /// Indicates whether the input field is disabled.
  final bool isDisabled;

  /// Label displayed above the input field.
  final String? label;

  /// Indicates whether additional information (tooltip) is available.
  final bool? info;

  /// Additional information text for tooltip.
  final String? infoText;

  /// Indicates whether to show character count.
  final bool charCount;

  /// Inner label (hint) for the input field.
  final String? innerLabel;

  /// Help text displayed below the input field.
  final String? helpText;

  /// Icon to be displayed as a suffix in the input field.
  final IconData? suffixIcon;

  /// Determines when the tooltip should be triggered.
  final TooltipTriggerMode triggerMode;

  /// Determines whether the tooltip should appear below the input field.
  final bool preferToolTipBelow;

  /// Icon to be displayed as a suffix in the input field.
  final String? suffixText;

  /// Icon to be displayed as a prefix in the input field.
  final String? prefixText;

  final TextAreaScroll textAreaScroll;

  /// Callback function triggered on validation error.
  final void Function(String?)? onError;

  /// Callback function triggered on suffix icon tap.
  final void Function(String)? onSuffixTap;

  /// Callback function triggered onTap tap.
  final void Function()? onTap;

  /// Minimum number of lines for the input field.
  final int minLine;

  /// Maximum number of lines for the input field.
  final int maxLine;

  /// Preferred height of the input field.
  final double height;

  /// Preferred width of the input field.
  final double width;

  /// List of validation rules to be applied.
  final List<Validator>? validations;

  /// Callback function triggered on input value change.
  final void Function(String)? onChange;

  /// Step value (used for specific input types like numbers).
  final int step;

  /// Minimum allowed value (used for specific input types like numbers).
  final int minValue;

  /// Maximum allowed value (used for specific input types like numbers).
  final int maxValue;

  /// Determines whether the cursor should be visible in the input field.
  final bool? showCurser;

  /// Initial value for the input field.
  final String? initialValue;

  /// Keyboard type for the input field.
  final TextInputType keyboardType;

  /// Text alignment within the input field.
  final TextAlign textAlign;
  final bool isTextArea;
  final IconData? toggleSuffixIcon;

  /// input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// some fields can be edited either just filled the values
  final bool isEditable;

  /// specifically for date component
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// validations provide you to send a error message, but you only want to pass a custom error message that can be also done by sending a errorMessage
  final String? errorMessage;
  final bool capitalizeFirstLetter;

  const BaseDigitFormInput({
    Key? key,
    required this.controller,
    this.isDisabled = false,
    this.readOnly = false,
    this.isRequired = false,
    this.initialValue,
    this.label,
    this.info,
    this.infoText,
    this.suffixIcon,
    this.charCount = false,
    this.innerLabel,
    this.helpText,
    this.onError,
    this.triggerMode = TooltipTriggerMode.tap,
    this.preferToolTipBelow = false,
    this.suffixText,
    this.prefixText,
    this.onSuffixTap,
    this.minLine = 1,
    this.maxLine = 1,
    this.height = Default.height,
    this.step = 1,
    this.minValue = 0,
    this.maxValue = 100,
    this.showCurser,
    this.width = Default.mobileInputWidth,
    this.onChange,
    this.keyboardType = TextInputType.text,
    this.validations,
    this.firstDate,
    this.initialDate,
    this.textAreaScroll = TextAreaScroll.none,
    this.lastDate,
    this.onTap,
    this.isEditable = true,
    this.isTextArea = false,
    this.toggleSuffixIcon,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.errorMessage,
    this.capitalizeFirstLetter = true,
  }) : super(key: key);

  @override
  BaseDigitFormInputState createState() => BaseDigitFormInputState();
}

class BaseDigitFormInputState extends State<BaseDigitFormInput> {
  String? _value;
  bool _hasError = false;
  late FocusNode myFocusNode;
  bool isVisible = false;
  double _height = 100;
  bool _isFocusOn = false;

  String? _errorMessage;

  /// Capitalize the first letter if required
  String? capitalizeFirstLetter(String? text) {
    if (text != null && text.isNotEmpty && widget.capitalizeFirstLetter) {
      return text.substring(0, 1).toUpperCase() + text.substring(1);
    }
    return text;
  }

  void onFocusChange() {
    if (!myFocusNode.hasFocus) {
      /// If the focus is lost, perform validation
      setState(() {
        _isFocusOn = false;
        _errorMessage = customValidator.call(widget.controller.text);
        _hasError = _errorMessage != null;
      });

      /// Call the provided onError function if there is an error
      if (_hasError) {
        widget.onError?.call(_errorMessage);
      }
    } else {
      setState(() {
        _isFocusOn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();

    myFocusNode.addListener(onFocusChange);

    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.removeListener(onFocusChange);
    myFocusNode.dispose();
  }

  String? customValidator(String? value) {
    /// Perform other validations
    final List<Validator> allValidations = [
      if (widget.isRequired) Validator(ValidatorType.required, 0),
      ...(widget.validations ?? []),
    ];

    final validationError = InputValidators.validate(
      value,
      allValidations,
    );

    setState(() {
      _errorMessage = validationError;
      _hasError = validationError != null;
    });

    return validationError;
  }

  void toggleObsecureText() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void onSuffixIconClick({void Function()? customFunction}) {
    /// Call the provided function if it's not null
    myFocusNode.requestFocus();
    customFunction?.call();
  }

  void onPrefixIconClick({void Function()? customFunction}) {
    /// Call the provided function if it's not null
    /// myFocusNode.requestFocus();
    customFunction?.call();
  }

  void onTap() {
    /// default function to call on tap
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context);

    /// Capitalize innerLabel, helpText, and errorMessage
    String? capitalizedInnerLabel = capitalizeFirstLetter(widget.innerLabel);
    String? capitalizedHelpText = capitalizeFirstLetter(widget.helpText);
    String? capitalizedErrorMessage =
        capitalizeFirstLetter(widget.errorMessage);

    int? getValidatorValue(List<Validator>? validators, ValidatorType type) {
      for (var validator in validators!) {
        if (validator.type == type) {
          return validator.value as int?;
        }
      }
      return null;
    }

    int? maxLengthValue = widget.charCount
        ? (widget.validations != null
            ? getValidatorValue(widget.validations, ValidatorType.maxLength) ??
                64
            : 64)
        : null;

    double inputWidth = AppView.isMobileView(MediaQuery.of(context).size.width)
        ? Default.mobileInputWidth
        : AppView.isTabletView(MediaQuery.of(context).size.width)
            ? Default.tabInputWidth
            : Default.desktopInputWidth;

    return LabeledField(
      label: widget.label,
      info: widget.info,
      infoText: widget.infoText,
      isRequired: widget.isRequired,
      preferToolTipBelow: widget.preferToolTipBelow,
      triggerMode: widget.triggerMode,
      child: SizedBox(
        width: inputWidth,
        child: Column(
          children: [
            widget.isTextArea
                ? Stack(
                    children: [
                      StatefulBuilder(builder: (context, setState) {
                        return Container(
                          height: widget.textAreaScroll == TextAreaScroll.smart
                              ? null
                              : _height,
                          constraints: BoxConstraints(
                            minWidth: 156,
                            minHeight: 40,
                            maxWidth: inputWidth,
                          ),
                          child: TextFormField(
                            onTapOutside: (PointerDownEvent event) {
                              /// Remove focus when tapped outside the input field
                              myFocusNode.unfocus();
                            },
                            onTap: onTap,
                            focusNode: myFocusNode,
                            obscureText: isVisible,
                            controller: widget.controller,
                            readOnly: widget.readOnly,
                            enabled: !widget.isDisabled,
                            autovalidateMode: AutovalidateMode.disabled,
                            minLines: widget.textAreaScroll ==
                                        TextAreaScroll.smart ||
                                    widget.textAreaScroll == TextAreaScroll.none
                                ? 4
                                : null,
                            maxLines:
                                widget.textAreaScroll == TextAreaScroll.smart
                                    ? null
                                    : 1000,
                            keyboardType: widget.readOnly
                                ? TextInputType.none
                                : widget.keyboardType,
                            textAlign: widget.textAlign,
                            maxLength: maxLengthValue,
                            showCursor:
                                widget.readOnly ? false : widget.showCurser,
                            style: DigitTheme
                                .instance.mobileTheme.textTheme.bodyLarge
                                ?.copyWith(
                              height: 1.5,
                              color: widget.readOnly
                                  ? const DigitColors().light.textSecondary
                                  : const DigitColors().light.textPrimary,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              hoverColor: const DigitColors().transparent,
                              contentPadding: const EdgeInsets.only(
                                left: 12,
                                right: 2,
                                top: 12,
                                bottom: 8,
                              ),
                              hintText: capitalizedInnerLabel,
                              hintStyle: currentTypography.bodyL.copyWith(
                                height: 1.5,
                                color: const DigitColors().light.textDisabled,
                              ),
                              filled: true,
                              fillColor: widget.readOnly
                                  ? const DigitColors().light.genericBackground
                                  : const DigitColors().transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _hasError
                                      ? const DigitColors().light.alertError
                                      : const DigitColors().light.textSecondary,
                                  width: _hasError ? 1.5 : 1.0,
                                ),
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: widget.readOnly
                                  ? OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const DigitColors()
                                            .light
                                            .textSecondary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.zero,
                                    )
                                  : BaseConstants.focusedBorder,
                              disabledBorder: BaseConstants.disabledBorder,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                              widget.onChange?.call(value);
                            },
                          ),
                        );
                      }),
                      if (widget.textAreaScroll != TextAreaScroll.smart &&
                          widget.textAreaScroll != TextAreaScroll.none)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.resizeUpDown,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  _height = _height + details.delta.dy;
                                });
                              },
                              child: Icon(
                                TextArea.textAreaExpand,
                                size: 8,
                                color: const DigitColors().light.textSecondary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : TextFormField(
                    onTapOutside: (PointerDownEvent event) {
                      /// Remove focus when tapped outside the input field
                      myFocusNode.unfocus();
                    },
                    inputFormatters: widget.inputFormatters,
                    onTap: widget.isEditable || widget.readOnly ? null : onTap,
                    focusNode: myFocusNode,
                    obscureText: isVisible,
                    controller: widget.controller,
                    readOnly:
                        widget.readOnly || !widget.isEditable ? true : false,
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
                    style: isVisible
                        ? currentTypography.bodyL.copyWith(
                            fontWeight: FontWeight.w900,
                            fontFamily: "Roboto-bold",
                            height: 1.5,
                            color: widget.readOnly
                                ? const DigitColors().light.textSecondary
                                : const DigitColors().light.textPrimary,
                            decoration: TextDecoration.none)
                        : currentTypography.bodyL.copyWith(
                            height: 1.5,
                            color: widget.readOnly
                                ? const DigitColors().light.textSecondary
                                : const DigitColors().light.textPrimary,
                            decoration: TextDecoration.none),
                    decoration: InputDecoration(
                      counterText: '',
                      hoverColor: const DigitColors().transparent,
                      constraints: inputWidth == Default.mobileInputWidth
                          ? const BoxConstraints(
                              maxHeight: BaseConstants.inputMinHeight,
                              minHeight: BaseConstants.inputMinHeight,
                              minWidth: BaseConstants.mobileInputMinWidth,
                              maxWidth: BaseConstants.mobileInputMaxWidth,
                            )
                          : inputWidth == Default.tabInputWidth
                              ? const BoxConstraints(
                                  maxHeight: BaseConstants.inputMinHeight,
                                  minHeight: BaseConstants.inputMinHeight,
                                  minWidth: BaseConstants.tabInputMinWidth,
                                  maxWidth: BaseConstants.tabInputMaxWidth,
                                )
                              : const BoxConstraints(
                                  maxHeight: BaseConstants.inputMinHeight,
                                  minHeight: BaseConstants.inputMinHeight,
                                  minWidth: BaseConstants.desktopInputMinWidth,
                                  maxWidth: BaseConstants.desktopInputMaxWidth,
                                ),
                      contentPadding: const EdgeInsets.only(
                        top: kPadding,
                        left: 12,
                        right: 12,
                      ),
                      hintText: capitalizedInnerLabel,
                      hintStyle: currentTypography.bodyL.copyWith(
                        height: 1.5,
                        color: const DigitColors().light.textDisabled,
                      ),
                      filled: true,
                      fillColor: widget.readOnly
                          ? const DigitColors().light.genericBackground
                          : const DigitColors().transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _hasError || widget.errorMessage != null
                              ? const DigitColors().light.alertError
                              : const DigitColors().light.textSecondary,
                          width: _hasError || widget.errorMessage != null
                              ? 1.5
                              : 1.0,
                        ),
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: widget.readOnly
                          ? OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const DigitColors().light.textSecondary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.zero,
                            )
                          : BaseConstants.focusedBorder,
                      disabledBorder: BaseConstants.disabledBorder,
                      prefixIconConstraints: widget.prefixText != null
                          ? const BoxConstraints(
                              minWidth: 40,
                              maxHeight: 40,
                            )
                          : null,
                      suffixIconConstraints: widget.suffixText != null
                          ? const BoxConstraints(
                              minWidth: 40,
                              maxHeight: 40,
                            )
                          : const BoxConstraints(
                              maxHeight: 24,
                            ),
                      suffixIcon: widget.suffixText != null
                          ? widget.suffixText == "+"
                              ? InkWell(
                                  hoverColor: const DigitColors().transparent,
                                  splashColor: const DigitColors().transparent,
                                  highlightColor:
                                      const DigitColors().transparent,
                                  onTap: widget.readOnly
                                      ? null
                                      : () {
                                          myFocusNode.requestFocus();
                                          onSuffixIconClick();
                                        },
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 38),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    height: (_isFocusOn || _hasError) &&
                                            !widget.readOnly
                                        ? 37
                                        : 38,
                                    margin: EdgeInsets.only(
                                      left: kPadding,
                                      right: (_isFocusOn || _hasError) &&
                                              !widget.readOnly
                                          ? 1.5
                                          : 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const DigitColors()
                                          .light
                                          .genericBackground,
                                      border: Border(
                                        right: BorderSide.none,
                                        top: BorderSide.none,
                                        bottom: BorderSide.none,
                                        left: BorderSide(
                                          color: widget.isDisabled
                                              ? const DigitColors()
                                                  .light
                                                  .genericDivider
                                              : const DigitColors()
                                                  .light
                                                  .genericInputBorder,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      widget.suffixText!,
                                      textAlign: TextAlign.center,
                                      style:
                                          currentTypography.headingM.copyWith(
                                        height: 1.5,
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .light
                                                .textDisabled
                                            : const DigitColors()
                                                .light
                                                .textSecondary,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 38),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  height: (_isFocusOn || _hasError) &&
                                          !widget.readOnly
                                      ? 37
                                      : 38,
                                  margin: EdgeInsets.only(
                                    left: kPadding,
                                    right: (_isFocusOn || _hasError) &&
                                            !widget.readOnly
                                        ? 1.5
                                        : 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const DigitColors()
                                        .light
                                        .genericBackground,
                                    border: Border(
                                      right: BorderSide.none,
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide(
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .light
                                                .genericDivider
                                            : const DigitColors()
                                                .light
                                                .genericInputBorder,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    widget.suffixText!,
                                    textAlign: TextAlign.center,
                                    style: currentTypography.headingM.copyWith(
                                      height: 1.5,
                                      color: widget.isDisabled
                                          ? const DigitColors()
                                              .light
                                              .textDisabled
                                          : const DigitColors()
                                              .light
                                              .textSecondary,
                                    ),
                                  ),
                                )
                          : widget.suffixIcon != null
                              ? InkWell(
                                  hoverColor: const DigitColors().transparent,
                                  splashColor: const DigitColors().transparent,
                                  highlightColor:
                                      const DigitColors().transparent,
                                  onTap: widget.readOnly
                                      ? null
                                      : onSuffixIconClick,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: kPadding,
                                    ),
                                    child: Icon(
                                      isVisible == true
                                          ? widget.toggleSuffixIcon
                                          : widget.suffixIcon,
                                      size: BaseConstants.suffixIconSize,
                                    ),
                                  ),
                                )
                              : null,
                      suffixIconColor: widget.isDisabled
                          ? const DigitColors().light.textDisabled
                          : const DigitColors().light.textSecondary,
                      prefixIcon: widget.prefixText != null
                          ? widget.prefixText == "-"
                              ? InkWell(
                                  hoverColor: const DigitColors().transparent,
                                  splashColor: const DigitColors().transparent,
                                  highlightColor:
                                      const DigitColors().transparent,
                                  onTap: widget.readOnly
                                      ? null
                                      : () {
                                          myFocusNode.requestFocus();
                                          onPrefixIconClick();
                                        },
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 38),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    height: (_isFocusOn || _hasError) &&
                                            !widget.readOnly
                                        ? 37
                                        : 38,
                                    margin: EdgeInsets.only(
                                      right: kPadding,
                                      left: (_isFocusOn || _hasError) &&
                                              !widget.readOnly
                                          ? 1.5
                                          : 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const DigitColors()
                                          .light
                                          .genericBackground,
                                      border: Border(
                                        right: BorderSide(
                                          color: widget.isDisabled
                                              ? const DigitColors()
                                                  .light
                                                  .genericDivider
                                              : const DigitColors()
                                                  .light
                                                  .genericInputBorder,
                                          width: 1.0,
                                        ),
                                        top: BorderSide.none,
                                        bottom: BorderSide.none,
                                        left: BorderSide.none,
                                      ),
                                    ),
                                    child: Text(
                                      widget.prefixText!,
                                      textAlign: TextAlign.center,
                                      style:
                                          currentTypography.headingM.copyWith(
                                        height: 1.5,
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .light
                                                .textDisabled
                                            : const DigitColors()
                                                .light
                                                .textSecondary,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 38),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  height: (_isFocusOn || _hasError) &&
                                          !widget.readOnly
                                      ? 37
                                      : 38,
                                  margin: EdgeInsets.only(
                                    right: kPadding,
                                    left: (_isFocusOn || _hasError) &&
                                            !widget.readOnly
                                        ? 1.5
                                        : 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const DigitColors()
                                        .light
                                        .genericBackground,
                                    border: Border(
                                      right: BorderSide(
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .light
                                                .genericDivider
                                            : const DigitColors()
                                                .light
                                                .genericInputBorder,
                                        width: 1.0,
                                      ),
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                    ),
                                  ),
                                  child: Text(
                                    widget.prefixText!,
                                    textAlign: TextAlign.center,
                                    style: currentTypography.headingM.copyWith(
                                      height: 1.5,
                                      color: widget.isDisabled
                                          ? const DigitColors()
                                              .light
                                              .textDisabled
                                          : const DigitColors()
                                              .light
                                              .textSecondary,
                                    ),
                                  ),
                                )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                      widget.onChange?.call(value);
                    },
                  ),
            if (widget.helpText != null ||
                widget.charCount ||
                _hasError ||
                widget.errorMessage != null)
              const SizedBox(
                height: kPadding / 2,
              ),
            if (widget.helpText != null ||
                widget.charCount ||
                _hasError ||
                widget.errorMessage != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.helpText != null ||
                      _hasError ||
                      widget.errorMessage != null)
                    _hasError
                        ? Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: Icon(
                                        Icons.info,
                                        color: const DigitColors()
                                            .light
                                            .alertError,
                                        size: BaseConstants.errorIconSize,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: kPadding / 2),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(
                                    _errorMessage!.length > 256
                                        ? '${_errorMessage!.substring(0, 256)}...'
                                        : _errorMessage!,
                                    style: currentTypography.bodyS.copyWith(
                                      height: 1.5,
                                      color:
                                          const DigitColors().light.alertError,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: Icon(
                                            Icons.info,
                                            color: const DigitColors()
                                                .light
                                                .alertError,
                                            size: BaseConstants.errorIconSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: kPadding / 2),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        capitalizedErrorMessage!.length > 256
                                            ? '${widget.errorMessage!.substring(0, 256)}...'
                                            : widget.errorMessage!,
                                        style: currentTypography.bodyS.copyWith(
                                          height: 1.5,
                                          color: const DigitColors()
                                              .light
                                              .alertError,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Text(
                                  capitalizedHelpText!.length > 256
                                      ? '${capitalizedHelpText!.substring(0, 256)}...'
                                      : capitalizedHelpText!,
                                  style: currentTypography.bodyS.copyWith(
                                    height: 1.5,
                                    color:
                                        const DigitColors().light.textSecondary,
                                  ),
                                ),
                              ),
                  if ((widget.helpText != null ||
                          _hasError ||
                          widget.errorMessage != null) &&
                      (widget.charCount == true))
                    const SizedBox(
                      width: 8,
                    ),
                  if (widget.helpText == null &&
                      _hasError == false &&
                      widget.errorMessage == null)
                    const Spacer(),
                  if (widget.charCount == true)
                    Text(
                      '${widget.controller.text.length}/$maxLengthValue',
                      style: currentTypography.bodyS.copyWith(
                        height: 1.5,
                        color: const DigitColors().light.textSecondary,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
