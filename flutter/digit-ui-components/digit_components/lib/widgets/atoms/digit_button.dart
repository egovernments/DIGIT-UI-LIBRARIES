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
///   type: ButtonType.primary,
///   prefixIcon: Icons.star,
///   suffixIcon: Icons.arrow_forward,
///   isDisabled: false,
/// )
/// ```

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../utils/utils.dart';

class Button extends StatefulWidget {
  /// The text displayed on the button, representing the button's label or content.
  final String label;

  /// Callback function invoked when the button is pressed. Defines the action to be performed.
  final VoidCallback onPressed;

  /// Specifies the type or style of the button (primary, secondary, tertiary, or link).
  final ButtonType type;

  final ButtonSize size;

  /// Icon to be displayed before the label text. Can be null if no prefix icon is needed.
  final IconData? prefixIcon;

  /// Icon to be displayed after the label text. Can be null if no suffix icon is needed.
  final IconData? suffixIcon;

  /// Indicates whether the button is in a disabled state. If true, the button is disabled and cannot be interacted with.
  final bool isDisabled;

  /// Padding around the content of the button (label and icons).
  final EdgeInsetsGeometry contentPadding;

  /// Size of the icons (prefixIcon and suffixIcon) displayed on the button in logical pixels.
  final double? iconSize;
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
    this.contentPadding = ButtonConstants.defaultContentPadding,
    this.iconSize,
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
  late DigitTypography _currentTypography;
  late DigitTypography _currentTypography2;
  late TextStyle buttonStyle;
  late TextStyle linkStyle;
  late double buttonIconSize;
  late double linkIconSize;

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    _currentTypography = getTypography(context, true);
    _currentTypography2 = getTypography(context, false);


    switch (widget.size) {
      case ButtonSize.small:
        buttonStyle = _currentTypography.headingS;
        linkStyle = _currentTypography2.linkS;
        buttonIconSize = ButtonConstants.smallIconSize;
        linkIconSize = ButtonConstants.smallLinkIconSize;
        break;
      case ButtonSize.medium:
        buttonStyle = _currentTypography.headingM;
        linkStyle = _currentTypography2.linkS;
        buttonIconSize = ButtonConstants.mediumIconSize;
        linkIconSize = ButtonConstants.mediumLinkIconSize;
        break;
      case ButtonSize.large:
        buttonStyle = _currentTypography.headingL;
        linkStyle = _currentTypography2.linkS;
        buttonIconSize = ButtonConstants.largeIconSize;
        linkIconSize = ButtonConstants.largeLinkIconSize;
        break;
    }

    return _buildButtonWidget();
  }

  /// Build the button widget based on its type and state.
  Widget _buildButtonWidget() {
    if (widget.type == ButtonType.primary ||
        widget.type == ButtonType.secondary) {
      return InkWell(
        highlightColor: const DigitColors().transparent,
        hoverColor: const DigitColors().transparent,
        splashColor: const DigitColors().transparent,
        focusColor: const DigitColors().transparent,
        onFocusChange: (value){
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
              ? 40
              : widget.size == ButtonSize.medium
              ? 32
              : 24,
          decoration: BoxDecoration(
            boxShadow: (isMouseDown)
                ? [
              BoxShadow(
                color: widget.type == ButtonType.primary
                    ? const DigitColors().light.textPrimary
                    : const DigitColors().light.primary1,
                offset: const Offset(0, 2),
                spreadRadius: 0,
                blurRadius: 0,
              ),
              BoxShadow(
                color: widget.type == ButtonType.primary
                    ? const DigitColors()
                    .light
                    .textPrimary
                    .withOpacity(.25)
                    : const DigitColors().light.primary1.withOpacity(.20),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: widget.type == ButtonType.primary ? 2.8 : 4,
              ),
            ]
                : isHovered || isFocused
                ? [
              BoxShadow(
                color: widget.type == ButtonType.primary
                    ? const DigitColors().light.textPrimary
                    : const DigitColors().light.primary1,
                offset: const Offset(0, 2),
                spreadRadius: 0,
                blurRadius: 0,
              ),
            ]
                : [],
            borderRadius: Common.radius,
            border: Border.all(
              color: widget.isDisabled
                  ? const DigitColors().light.textDisabled
                  : const DigitColors().light.primary1,
              width: ButtonConstants.defaultWidth,
            ),
            color: widget.type == ButtonType.primary
                ? (widget.isDisabled
                ? const DigitColors().light.textDisabled
                : const DigitColors().light.primary1)
                : const DigitColors().light.paperPrimary,
          ),
          child: _buildButton(isHovered, isMouseDown, isFocused),
        ),
      );
    } else {
      return InkWell(
        highlightColor: const DigitColors().transparent,
        hoverColor: const DigitColors().transparent,
        splashColor: const DigitColors().transparent,
        focusColor: const DigitColors().transparent,
        onFocusChange: (value){
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
        // hoverColor: const DigitColors().transparent,
        // splashColor: const DigitColors().transparent,
        // highlightColor: const DigitColors().transparent,
        child: _buildButton(isHovered, isMouseDown, isFocused),
      );
    }
  }

  /// Build the content of the button, including label and icons.
  Widget _buildButton(bool isHovered, bool isMouseDown, bool isFocused) {
    String truncatedLabel = widget.label;

    /// Truncate label if it exceeds 64 characters &&  Capitalize the first letter of the label
    if (widget.type != ButtonType.link) {
      if (widget.label.length > 64) {
        truncatedLabel = '${widget.label.substring(0, 64)}...';
      }

      truncatedLabel = truncatedLabel.isEmpty || !widget.capitalizeLetters
          ? truncatedLabel
          : capitalizeFirstLetterOfEveryWord(truncatedLabel);
    }
    return Container(
      color: isFocused && widget.type==ButtonType.tertiary ? const DigitColors().light.primary1Bg:const DigitColors().transparent,
      child: Padding(
        padding: widget.type == ButtonType.link ||
            widget.type == ButtonType.tertiary
            ? const EdgeInsets.all(kPadding)
            : widget.contentPadding,
        child: Row(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.type == ButtonType.link ? linkIconSize : widget.iconSize ?? buttonIconSize,
                color: widget.type == ButtonType.primary
                    ? const DigitColors().light.paperPrimary
                    : (widget.isDisabled
                    ? const DigitColors().light.textDisabled
                    : const DigitColors().light.primary1),
              ),
              SizedBox(
                  width:
                  widget.type == ButtonType.link || widget.size == ButtonSize.small  || widget.size == ButtonSize.medium? kPadding/2 : kPadding),
            ],
            Flexible(
              child: Text(
                truncatedLabel,
                textAlign: TextAlign.center,
                style: widget.type == ButtonType.link
                    ? linkStyle.copyWith(
                  color: widget.isDisabled
                      ? const DigitColors().light.textDisabled
                      : const DigitColors().light.primary1,
                  decoration: TextDecoration.underline,
                  decorationColor: widget.isDisabled
                      ? const DigitColors().light.textDisabled
                      : const DigitColors().light.primary1,
                  decorationThickness: isHovered || isFocused ? 2 : 1,
                )
                    : buttonStyle.copyWith(
                  fontWeight:
                  isMouseDown ? FontWeight.w700 : FontWeight.w500,
                  color: widget.type == ButtonType.primary
                      ? const DigitColors().light.paperPrimary
                      :  widget.isDisabled
                      ? const DigitColors().light.textDisabled
                      : const DigitColors().light.primary1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              SizedBox(
                  width:
                  widget.type == ButtonType.link || widget.size == ButtonSize.small || widget.size == ButtonSize.medium ? kPadding/2 : kPadding),
              Icon(
                widget.suffixIcon,
                size: widget.type == ButtonType.link ? linkIconSize : widget.iconSize ?? buttonIconSize,
                color: widget.type == ButtonType.primary
                    ? const DigitColors().light.paperPrimary
                    : (widget.isDisabled
                    ? const DigitColors().light.textDisabled
                    : const DigitColors().light.primary1),
              ),
            ],
          ],
        ),
      ),
    );
  }
}