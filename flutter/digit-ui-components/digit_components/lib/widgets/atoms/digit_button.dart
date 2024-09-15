///`DigitButton` is a customizable DigitButton widget that supports various styles and states.
/// This widget provides options for primary, secondary, tertiary, and link DigitButton types.
///It handles hover effects, disabled state, and different icon placements.
///DigitButton comes with different sizes also-- large, medium and small

///Example usage:
///```dart
/// DigitButton(
///   label: 'Click me',
///   onPressed: () {
///    // Handle DigitButton press
///   },
///   size: DigitButtonSize.large
///   type: DigitButtonType.primary,
///   prefixIcon: Icons.star,
///   suffixIcon: Icons.arrow_forward,
///   isDisabled: false,
/// )
/// ```

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../../theme/ComponentTheme/button_theme.dart';
import '../../utils/utils.dart';

class DigitButton extends StatefulWidget {
  /// The text displayed on the DigitButton, representing the DigitButton's label or content.
  final String label;

  /// Callback function invoked when the DigitButton is pressed. Defines the action to be performed.
  final VoidCallback onPressed;

  /// Specifies the type or style of the DigitButton (primary, secondary, tertiary, or link).
  final DigitButtonType type;

  /// Specifies the size of the DigitButton (large, medium, small).
  final DigitButtonSize size;

  /// Icon to be displayed before the label text. Can be null if no prefix icon is needed.
  final IconData? prefixIcon;

  /// Icon to be displayed after the label text. Can be null if no suffix icon is needed.
  final IconData? suffixIcon;

  final Color? iconColor;
  final Color? textColor;

  final DigitButtonThemeData? digitButtonThemeData;

  /// Indicates whether the DigitButton is in a disabled state. If true, the DigitButton is disabled and cannot be interacted with.
  final bool isDisabled;
  final bool capitalizeLetters;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const DigitButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.type,
    required this.size,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.textColor,
    this.isDisabled = false,
    this.digitButtonThemeData,
    this.capitalizeLetters = true,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  }) : super(key: key);

  @override
  _DigitButtonState createState() => _DigitButtonState();
}

class _DigitButtonState extends State<DigitButton> {
  bool isHovered = false;
  bool isMouseDown = false;
  bool isFocused = false;
  late TextStyle DigitButtonStyle;
  late TextStyle linkStyle;
  late double DigitButtonIconSize;
  late double linkIconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DigitButtonThemeData digitButtonThemeData = widget.digitButtonThemeData ??
        theme.extension<DigitButtonThemeData>() ??
        DigitButtonThemeData.defaultTheme(context);

    switch (widget.size) {
      case DigitButtonSize.small:
        DigitButtonStyle = digitButtonThemeData.smallDigitButtonTextStyle;
        linkStyle = digitButtonThemeData.smallLinkTextStyle;
        DigitButtonIconSize = digitButtonThemeData.smallIconSize;
        linkIconSize = digitButtonThemeData.smallLinkIconSize;
        break;
      case DigitButtonSize.medium:
        DigitButtonStyle = digitButtonThemeData.mediumDigitButtonTextStyle;
        linkStyle = digitButtonThemeData.mediumLinkTextStyle;
        DigitButtonIconSize = digitButtonThemeData.mediumIconSize;
        linkIconSize = digitButtonThemeData.mediumLinkIconSize;
        break;
      case DigitButtonSize.large:
        DigitButtonStyle = digitButtonThemeData.largeDigitButtonTextStyle;
        linkStyle = digitButtonThemeData.largeLinkTextStyle;
        DigitButtonIconSize = digitButtonThemeData.largeIconSize;
        linkIconSize = digitButtonThemeData.largeLinkIconSize;
        break;
    }

    return _buildDigitButtonWidget(context, digitButtonThemeData);
  }

  /// Build the DigitButton widget based on its type and state.
  Widget _buildDigitButtonWidget(
      BuildContext context, DigitButtonThemeData digitButtonThemeData) {
    if (widget.type == DigitButtonType.primary ||
        widget.type == DigitButtonType.secondary) {
      return InkWell(
        highlightColor: digitButtonThemeData.hightlightColor,
        hoverColor: digitButtonThemeData.hoverColor,
        splashColor: digitButtonThemeData.splashColor,
        focusColor: digitButtonThemeData.focusColor,
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
          height: widget.size == DigitButtonSize.large
              ? digitButtonThemeData.largeDigitButtonHeight
              : widget.size == DigitButtonSize.medium
              ? digitButtonThemeData.mediumDigitButtonHeight
              : digitButtonThemeData.smallDigitButtonHeight,
          decoration: BoxDecoration(
            boxShadow: (isMouseDown)
                ? widget.type == DigitButtonType.primary
                ? digitButtonThemeData.primaryDigitButtonMouseDownBoxShadow
                : digitButtonThemeData.DigitButtonMouseDownBoxShadow
                : isHovered || isFocused
                ? widget.type == DigitButtonType.primary
                ? digitButtonThemeData.primaryDigitButtonHoverBoxShadow
                : digitButtonThemeData.DigitButtonHoverBoxShadow
                : [],
            borderRadius: digitButtonThemeData.radius,
            border: Border.all(
              color: widget.isDisabled
                  ? digitButtonThemeData.disabledColor
                  : digitButtonThemeData.DigitButtonColor,
              width: digitButtonThemeData.borderWidth,
            ),
            color: widget.type == DigitButtonType.primary
                ? (widget.isDisabled
                ? digitButtonThemeData.disabledColor
                : digitButtonThemeData.DigitButtonColor)
                : digitButtonThemeData.primaryDigitButtonColor,
          ),
          child: _buildDigitButton(
              isHovered, isMouseDown, isFocused, digitButtonThemeData, context),
        ),
      );
    } else {
      return InkWell(
        highlightColor: digitButtonThemeData.hightlightColor,
        hoverColor: digitButtonThemeData.hoverColor,
        splashColor: digitButtonThemeData.splashColor,
        focusColor: digitButtonThemeData.focusColor,
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
        child: _buildDigitButton(
            isHovered, isMouseDown, isFocused, digitButtonThemeData, context),
      );
    }
  }

  /// Build the content of the DigitButton, including label and icons.
  Widget _buildDigitButton(bool isHovered, bool isMouseDown, bool isFocused,
      DigitButtonThemeData digitButtonThemeData, BuildContext context) {
    String truncatedLabel = widget.label;
    final theme = Theme.of(context);

    /// Truncate label if it exceeds 64 characters &&  Capitalize the first letter of the label
    if (widget.type != DigitButtonType.link) {
      if (widget.label.length > 64) {
        truncatedLabel = truncateWithEllipsis(64, widget.label);
      }

      truncatedLabel = truncatedLabel.isEmpty || !widget.capitalizeLetters
          ? truncatedLabel
          : capitalizeFirstLetterOfEveryWord(truncatedLabel);
    }
    return Container(
      color: isFocused && widget.type == DigitButtonType.tertiary
          ? theme.colorTheme.primary.primaryBg
          : theme.colorTheme.generic.transparent,
      child: Padding(
        padding:
        widget.type == DigitButtonType.link || widget.type == DigitButtonType.tertiary
            ? digitButtonThemeData.linkPadding
            : digitButtonThemeData.padding,
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
                size: widget.type == DigitButtonType.link
                    ? linkIconSize
                    : DigitButtonIconSize,
                color: widget.iconColor ?? (widget.type == DigitButtonType.primary
                    ? digitButtonThemeData.primaryDigitButtonColor
                    : (widget.isDisabled
                    ? digitButtonThemeData.disabledColor
                    : digitButtonThemeData.DigitButtonColor)),
              ),
              SizedBox(
                  width: widget.type == DigitButtonType.link ||
                      widget.size == DigitButtonSize.small
                      ? theme.spacerTheme.spacer1
                      : theme.spacerTheme.spacer2),
            ],
            Flexible(
              child: Text(
                truncatedLabel,
                textAlign: TextAlign.center,
                style: widget.type == DigitButtonType.link
                    ? linkStyle.copyWith(
                  color: widget.textColor ??  (widget.isDisabled
                      ? digitButtonThemeData.disabledColor
                      : digitButtonThemeData.DigitButtonColor),
                  decoration: TextDecoration.underline,
                  decorationColor: widget.textColor ??  (widget.isDisabled
                      ? digitButtonThemeData.disabledColor
                      : digitButtonThemeData.DigitButtonColor),
                  decorationThickness: isHovered || isFocused ? 2 : 1,
                )
                    : DigitButtonStyle.copyWith(
                  fontWeight:
                  isMouseDown ? FontWeight.w700 : FontWeight.w500,
                  color: widget.textColor ?? (widget.type == DigitButtonType.primary
                      ? digitButtonThemeData.primaryDigitButtonColor
                      : (widget.isDisabled
                      ? digitButtonThemeData.disabledColor
                      : digitButtonThemeData.DigitButtonColor)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              SizedBox(
                  width: widget.type == DigitButtonType.link ||
                      widget.size == DigitButtonSize.small
                      ? theme.spacerTheme.spacer1
                      : theme.spacerTheme.spacer2),
              Icon(
                widget.suffixIcon,
                size: widget.type == DigitButtonType.link
                    ? linkIconSize
                    : DigitButtonIconSize,
                color: widget.iconColor ?? (widget.type == DigitButtonType.primary
                    ? digitButtonThemeData.primaryDigitButtonColor
                    : (widget.isDisabled
                    ? digitButtonThemeData.disabledColor
                    : digitButtonThemeData.DigitButtonColor)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}