import 'package:digit_components/digit_components.dart';
import 'package:digit_components/enum/app_enums.dart';
import 'package:digit_components/widgets/atoms/labelled_fields.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
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

  /// some fields can be edited either just filled the values
  final bool isEditable;

  /// specifically for date component
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const BaseDigitFormInput(
      {Key? key,
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
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  BaseDigitFormInputState createState() => BaseDigitFormInputState();
}

class BaseDigitFormInputState extends State<BaseDigitFormInput>
    with WidgetsBindingObserver {
  String? _value;
  bool _hasError = false;
  late FocusNode myFocusNode;
  bool isVisible = false;
  double _height = 100;
  bool _isFocusOn = false;

  String? _errorMessage;

  void onFocusChange() {
    if (!myFocusNode.hasFocus) {
      /// If the focus is lost, perform validation
      setState(() {
        _isFocusOn = false;
        _errorMessage = customValidator?.call(widget.controller.text);
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
    customFunction?.call();
  }

  void onPrefixIconClick({void Function()? customFunction}) {
    /// Call the provided function if it's not null
    customFunction?.call();
  }

  void onTap() {
    /// default function to call on tap
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    int? getValidatorValue(List<Validator>? validators, ValidatorType type) {
      for (var validator in validators!) {
        if (validator?.type == type) {
          return validator?.value as int?;
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
                            height:
                                widget.textAreaScroll == TextAreaScroll.smart
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
                                      widget.textAreaScroll ==
                                          TextAreaScroll.none
                                  ? 4
                                  : null,
                              maxLines:
                                  widget.textAreaScroll == TextAreaScroll.smart
                                      ? null
                                      : 1000,
                              keyboardType: widget.keyboardType,
                              textAlign: widget.textAlign,
                              maxLength: maxLengthValue,
                              showCursor: widget.showCurser,
                              style: DigitTheme
                                  .instance.mobileTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                height: 1.5,
                                color: widget.readOnly
                                    ? const DigitColors().lightTextSecondary
                                    : const DigitColors().lightTextPrimary,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                hoverColor: const DigitColors().transparent,
                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 2,
                                  top: 8,
                                  bottom: 8,
                                ),
                                hintText: widget.innerLabel,
                                hintStyle: DigitTheme
                                    .instance.mobileTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                  height: 1.5,
                                  color: const DigitColors().lightTextDisabled,
                                ),
                                filled: true,
                                fillColor: widget.isDisabled
                                    ? const DigitColors().lightPaperSecondary
                                    : widget.readOnly
                                        ? const DigitColors()
                                            .lightGenericBackground
                                        : const DigitColors().transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: _hasError
                                        ? const DigitColors().lightAlertError
                                        : const DigitColors()
                                            .lightTextSecondary,
                                    width: _hasError ? 1.5 : 1.0,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: BaseConstants.focusedBorder,
                                disabledBorder: BaseConstants.disabledBorder,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                                widget.onChange?.call(value);
                              },
                            ));
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
                              child: Transform.rotate(
                                angle: -0.5, // Adjust the angle as needed
                                child: const Icon(
                                  Icons.drag_handle,
                                  size: 16,
                                ),
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
                    keyboardType: widget.keyboardType,
                    textAlign: widget.textAlign,
                    maxLength: maxLengthValue,
                    showCursor: widget.showCurser ?? widget.isEditable,
                    style: isVisible
                        ? DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontFamily: "Roboto-bold",
                                height: 1.5,
                                color: widget.readOnly
                                    ? const DigitColors().lightTextSecondary
                                    : const DigitColors().lightTextPrimary,
                                decoration: TextDecoration.none)
                        : DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                            ?.copyWith(
                                height: 1.5,
                                color: widget.readOnly
                                    ? const DigitColors().lightTextSecondary
                                    : const DigitColors().lightTextPrimary,
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
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: kPadding / 2,
                        horizontal: 12,
                      ),
                      hintText: widget.innerLabel,
                      hintStyle: DigitTheme
                          .instance.mobileTheme.textTheme.bodyLarge
                          ?.copyWith(
                        height: 1.5,
                        color: const DigitColors().lightTextDisabled,
                      ),
                      filled: true,
                      fillColor: widget.isDisabled
                          ? const DigitColors().lightPaperSecondary
                          : widget.readOnly
                              ? const DigitColors().lightGenericBackground
                              : const DigitColors().transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _hasError
                              ? const DigitColors().lightAlertError
                              : const DigitColors().lightTextSecondary,
                          width: _hasError ? 1.5 : 1.0,
                        ),
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: BaseConstants.focusedBorder,
                      disabledBorder: BaseConstants.disabledBorder,
                      prefixIconConstraints: widget.prefixText != null
                          ? const BoxConstraints(
                              // maxWidth: 48,
                              minWidth: 40,
                              maxHeight: 40,
                            )
                          : null,
                      suffixIconConstraints: widget.suffixText != null
                          ? const BoxConstraints(
                              // maxWidth: 48,
                              minWidth: 40,
                              maxHeight: 40,
                            )
                          : const BoxConstraints(
                              maxHeight: 24,
                            ),
                      suffixIcon: widget.suffixText != null
                          ? InkWell(
                              hoverColor: const DigitColors().transparent,
                              splashColor: const DigitColors().transparent,
                              highlightColor: const DigitColors().transparent,
                              onTap: widget.readOnly ? null : onSuffixIconClick,
                              child: IntrinsicWidth(
                                child: Container(
                                  height: _isFocusOn || _hasError ? 36 : 38,
                                  // width: 40,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  margin: EdgeInsets.only(
                                    left: kPadding,
                                    right: _isFocusOn || _hasError ? 2 : 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const DigitColors()
                                        .lightGenericBackground,
                                    border: Border(
                                      left: BorderSide(
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .lightTextDisabled
                                            : const DigitColors()
                                                .lightTextSecondary,
                                        width: 1.0,
                                      ),
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      right: BorderSide.none,
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, bottom: 4, top: 0),
                                      child: Text(
                                        widget.suffixText!,
                                        style: DigitTheme.instance.mobileTheme
                                            .textTheme.headlineLarge
                                            ?.copyWith(
                                          height: 1.758,
                                          color: widget.isDisabled
                                              ? const DigitColors()
                                                  .lightGenericDivider
                                              : const DigitColors()
                                                  .lightTextSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
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
                          ? const DigitColors().lightTextDisabled
                          : const DigitColors().lightTextSecondary,
                      prefixIcon: widget.prefixText != null
                          ? InkWell(
                              hoverColor: const DigitColors().transparent,
                              splashColor: const DigitColors().transparent,
                              highlightColor: const DigitColors().transparent,
                              onTap: widget.readOnly ? null : onPrefixIconClick,
                              child: IntrinsicWidth(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  height: _isFocusOn || _hasError ? 36 : 38,
                                  // width: 200,
                                  margin: EdgeInsets.only(
                                    right: kPadding,
                                    left: _isFocusOn || _hasError ? 2 : 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const DigitColors()
                                        .lightGenericBackground,
                                    border: Border(
                                      right: BorderSide(
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .lightGenericDivider
                                            : const DigitColors()
                                                .lightGenericInputBorder,
                                        width: 1.0,
                                      ),
                                      top: BorderSide.none,
                                      bottom: BorderSide.none,
                                      left: BorderSide.none,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.prefixText!,
                                      style: DigitTheme.instance.mobileTheme
                                          .textTheme.headlineLarge
                                          ?.copyWith(
                                        height: 1.758,
                                        color: widget.isDisabled
                                            ? const DigitColors()
                                                .lightTextDisabled
                                            : const DigitColors()
                                                .lightTextSecondary,
                                      ),
                                    ),
                                  ),
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
            const SizedBox(
              height: kPadding / 2,
            ),
            if (widget.helpText != null ||
                widget.charCount != null ||
                _hasError)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.helpText != null || _hasError)
                    _hasError
                        ? Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: Icon(
                                    Icons.info,
                                    color: const DigitColors().lightAlertError,
                                    size: BaseConstants.errorIconSize,
                                  ),
                                ),
                                const SizedBox(width: kPadding / 2),
                                Text(
                                  _errorMessage!.length > 256
                                      ? '${_errorMessage!.substring(0, 256)}...'
                                      : _errorMessage!,
                                  style: DigitTheme
                                      .instance.mobileTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    height: 1.5,
                                    color: const DigitColors().lightAlertError,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Text(
                              widget.helpText!.length > 256
                                  ? '${widget.helpText!.substring(0, 256)}...'
                                  : widget.helpText!,
                              style: DigitTheme
                                  .instance.mobileTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                height: 1.5,
                                color: const DigitColors().lightTextSecondary,
                              ),
                            ),
                          ),
                  if ((widget.helpText != null || _hasError) &&
                      (widget.charCount == true))
                    const SizedBox(
                      width: 8,
                    ),
                  if (widget.helpText == null && _hasError == false)
                    const Spacer(),
                  if (widget.charCount == true)
                    Text(
                      '${widget.controller.text.length ?? 0}/$maxLengthValue',
                      style: DigitTheme
                          .instance.mobileTheme.textTheme.bodyMedium
                          ?.copyWith(
                        height: 1.5,
                        color: const DigitColors().lightTextSecondary,
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
