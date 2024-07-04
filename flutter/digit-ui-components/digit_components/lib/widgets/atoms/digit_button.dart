///`Button` is a customizable button widget that supports various styles and states.
/// This widget provides options for primary, secondary, tertiary, and link button types.
///It handles hover effects, disabled state, and different icon placements.
///button comes with different sizes also-- large, medium and small

///Example usage:
///```dart
/// Button(
///   label: 'Click me',
///   onPressed: () {
///    // Handle button press
///   },
///   size: ButtonSize.large
///   type: ButtonType.primary,
///   prefixIcon: Icons.star,
///   suffixIcon: Icons.arrow_forward,
///   isDisabled: false,
/// )
/// ```

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../theme/ComponentTheme/button_theme.dart';
import '../../utils/utils.dart';

class Button extends StatefulWidget {
  /// The text displayed on the button, representing the button's label or content.
  final String label;

  /// Callback function invoked when the button is pressed. Defines the action to be performed.
  final VoidCallback onPressed;

  /// Specifies the type or style of the button (primary, secondary, tertiary, or link).
  final ButtonType type;

  /// Specifies the size of the button (large, medium, small).
  final ButtonSize size;

  /// Icon to be displayed before the label text. Can be null if no prefix icon is needed.
  final IconData? prefixIcon;

  /// Icon to be displayed after the label text. Can be null if no suffix icon is needed.
  final IconData? suffixIcon;

  final DigitButtonThemeData? buttonThemeData;

  /// Indicates whether the button is in a disabled state. If true, the button is disabled and cannot be interacted with.
  final bool isDisabled;
  final bool capitalizeLetters;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.type,
    required this.size,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.buttonThemeData,
    this.capitalizeLetters = true,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isHovered = false;
  bool isMouseDown = false;
  bool isFocused = false;
  late TextStyle buttonStyle;
  late TextStyle linkStyle;
  late double buttonIconSize;
  late double linkIconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DigitButtonThemeData buttonThemeData = widget.buttonThemeData ??
        theme.extension<DigitButtonThemeData>() ??
        DigitButtonThemeData.defaultTheme(context);

    switch (widget.size) {
      case ButtonSize.small:
        buttonStyle = buttonThemeData.smallButtonTextStyle;
        linkStyle = buttonThemeData.smallLinkTextStyle;
        buttonIconSize = buttonThemeData.smallIconSize;
        linkIconSize = buttonThemeData.smallLinkIconSize;
        break;
      case ButtonSize.medium:
        buttonStyle = buttonThemeData.mediumButtonTextStyle;
        linkStyle = buttonThemeData.mediumLinkTextStyle;
        buttonIconSize = buttonThemeData.mediumIconSize;
        linkIconSize = buttonThemeData.mediumLinkIconSize;
        break;
      case ButtonSize.large:
        buttonStyle = buttonThemeData.largeButtonTextStyle;
        linkStyle = buttonThemeData.largeLinkTextStyle;
        buttonIconSize = buttonThemeData.largeIconSize;
        linkIconSize = buttonThemeData.largeLinkIconSize;
        break;
    }

    return _buildButtonWidget(context, buttonThemeData);
  }

  /// Build the button widget based on its type and state.
  Widget _buildButtonWidget(
      BuildContext context, DigitButtonThemeData buttonThemeData) {
    if (widget.type == ButtonType.primary ||
        widget.type == ButtonType.secondary) {
      return InkWell(
        highlightColor: buttonThemeData.hightlightColor,
        hoverColor: buttonThemeData.hoverColor,
        splashColor: buttonThemeData.splashColor,
        focusColor: buttonThemeData.focusColor,
        onFocusChange: (value) {
          setState(() {
            isFocused = value;
          });
        },
        onTapDown: widget.isDisabled
            ? null
            : (_) {
                /// Handle mouse down state
                setState(() {
                  isMouseDown = true;
                });
              },
        onTapUp: widget.isDisabled
            ? null
            : (_) {
                /// Handle mouse up state
                setState(() {
                  isMouseDown = false;
                });
              },
        onHover: (hover) {
          setState(() {
            isHovered = hover;
          });
        },
        onTap: widget.isDisabled
            ? null
            : () {
                if (mounted) {
                  widget.onPressed();
                }
              },
        child: Container(
          height: widget.size == ButtonSize.large
              ? buttonThemeData.largeButtonHeight
              : widget.size == ButtonSize.medium
                  ? buttonThemeData.mediumButtonHeight
                  : buttonThemeData.smallButtonHeight,
          decoration: BoxDecoration(
            boxShadow: (isMouseDown)
                ? widget.type == ButtonType.primary
                    ? buttonThemeData.primaryButtonMouseDownBoxShadow
                    : buttonThemeData.buttonMouseDownBoxShadow
                : isHovered || isFocused
                    ? widget.type == ButtonType.primary
                        ? buttonThemeData.primaryButtonHoverBoxShadow
                        : buttonThemeData.buttonHoverBoxShadow
                    : [],
            borderRadius: buttonThemeData.radius,
            border: Border.all(
              color: widget.isDisabled
                  ? buttonThemeData.disabledColor
                  : buttonThemeData.buttonColor,
              width: buttonThemeData.borderWidth,
            ),
            color: widget.type == ButtonType.primary
                ? (widget.isDisabled
                    ? buttonThemeData.disabledColor
                    : buttonThemeData.buttonColor)
                : buttonThemeData.primaryButtonColor,
          ),
          child: _buildButton(
              isHovered, isMouseDown, isFocused, buttonThemeData, context),
        ),
      );
    } else {
      return InkWell(
        highlightColor: buttonThemeData.hightlightColor,
        hoverColor: buttonThemeData.hoverColor,
        splashColor: buttonThemeData.splashColor,
        focusColor: buttonThemeData.focusColor,
        onFocusChange: (value) {
          setState(() {
            isFocused = value;
          });
        },
        onTap: widget.isDisabled
            ? null
            : () {
                if (mounted) {
                  widget.onPressed();
                }
              },
        onHover: widget.isDisabled
            ? null
            : (hover) {
                setState(() {
                  isHovered = hover;
                });
              },
        onTapDown: widget.isDisabled
            ? null
            : (_) {
                setState(() {
                  isMouseDown = true;
                });
              },
        onTapUp: widget.isDisabled
            ? null
            : (_) {
                setState(() {
                  isMouseDown = false;
                });
              },
        child: _buildButton(
            isHovered, isMouseDown, isFocused, buttonThemeData, context),
      );
    }
  }

  /// Build the content of the button, including label and icons.
  Widget _buildButton(bool isHovered, bool isMouseDown, bool isFocused,
      DigitButtonThemeData buttonThemeData, BuildContext context) {
    String truncatedLabel = widget.label;
    final theme = Theme.of(context);

    /// Truncate label if it exceeds 64 characters &&  Capitalize the first letter of the label
    if (widget.type != ButtonType.link) {
      if (widget.label.length > 64) {
        truncatedLabel = truncateWithEllipsis(64, widget.label);
      }

      truncatedLabel = truncatedLabel.isEmpty || !widget.capitalizeLetters
          ? truncatedLabel
          : capitalizeFirstLetterOfEveryWord(truncatedLabel);
    }
    return Container(
      color: isFocused && widget.type == ButtonType.tertiary
          ? theme.colorTheme.primary.primaryBg
          : theme.colorTheme.generic.transparent,
      child: Padding(
        padding:
            widget.type == ButtonType.link || widget.type == ButtonType.tertiary
                ? buttonThemeData.linkPadding
                : buttonThemeData.padding,
        child: Row(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.min,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.type == ButtonType.link
                    ? linkIconSize
                    : buttonIconSize,
                color: widget.type == ButtonType.primary
                    ? buttonThemeData.primaryButtonColor
                    : (widget.isDisabled
                        ? buttonThemeData.disabledColor
                        : buttonThemeData.buttonColor),
              ),
              SizedBox(
                  width: widget.type == ButtonType.link ||
                          widget.size == ButtonSize.small
                      ? theme.spacerTheme.spacer1
                      : theme.spacerTheme.spacer2),
            ],
            Flexible(
              child: Text(
                truncatedLabel,
                textAlign: TextAlign.center,
                style: widget.type == ButtonType.link
                    ? linkStyle.copyWith(
                        color: widget.isDisabled
                            ? buttonThemeData.disabledColor
                            : buttonThemeData.buttonColor,
                        decoration: TextDecoration.underline,
                        decorationColor: widget.isDisabled
                            ? buttonThemeData.disabledColor
                            : buttonThemeData.buttonColor,
                        decorationThickness: isHovered || isFocused ? 2 : 1,
                      )
                    : buttonStyle.copyWith(
                        fontWeight:
                            isMouseDown ? FontWeight.w700 : FontWeight.w500,
                        color: widget.type == ButtonType.primary
                            ? buttonThemeData.primaryButtonColor
                            : (widget.isDisabled
                                ? buttonThemeData.disabledColor
                                : buttonThemeData.buttonColor),
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              SizedBox(
                  width: widget.type == ButtonType.link ||
                          widget.size == ButtonSize.small
                      ? theme.spacerTheme.spacer1
                      : theme.spacerTheme.spacer2),
              Icon(
                widget.suffixIcon,
                size: widget.type == ButtonType.link
                    ? linkIconSize
                    : buttonIconSize,
                color: widget.type == ButtonType.primary
                    ? buttonThemeData.primaryButtonColor
                    : (widget.isDisabled
                        ? buttonThemeData.disabledColor
                        : buttonThemeData.buttonColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
