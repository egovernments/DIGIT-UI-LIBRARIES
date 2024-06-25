import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class InfoButton extends StatefulWidget {
  /// The text displayed on the button, representing the button's label or content.
  final String label;

  /// Callback function invoked when the button is pressed. Defines the action to be performed.
  final VoidCallback onPressed;

  /// Size of the button--- medium, large or small
  final ButtonSize size;

  /// type of info button--- info, success, error or warning
  final InfoButtonType type;

  /// Icon to be displayed before the label text. Can be null if no prefix icon is needed.
  final IconData? prefixIcon;

  /// Icon to be displayed after the label text. Can be null if no suffix icon is needed.
  final IconData? suffixIcon;

  /// Indicates whether the button is in a disabled state. If true, the button is disabled and cannot be interacted with.
  final bool isDisabled;

  final bool capitalizeLetters;
  final DigitButtonThemeData? buttonThemeData;

  const InfoButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.type,
    required this.size,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.capitalizeLetters = true,
    this.buttonThemeData,
  }) : super(key: key);

  @override
  _InfoButtonState createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  bool isHovered = false;
  bool isMouseDown = false;
  late TextStyle buttonStyle;
  late double buttonIconSize;
  late Color buttonColor;

  /// Build the content of the button, including label and icons.
  Widget _buildButton(bool isHovered, bool isMouseDown, BuildContext context, DigitButtonThemeData buttonThemeData) {
    final theme = Theme.of(context);
    String truncatedLabel = widget.label;

    /// Truncate label if it exceeds 64 characters &&  Capitalize the letter of the label

    if (widget.label.length > 64) {
      truncatedLabel = truncateWithEllipsis(64, widget.label);
    }

    truncatedLabel = truncatedLabel.isEmpty || !widget.capitalizeLetters
        ? truncatedLabel
        : capitalizeFirstLetterOfEveryWord(truncatedLabel);

    return Padding(
      padding: buttonThemeData.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null) ...[
            Icon(
              widget.prefixIcon,
              size: buttonIconSize,
              color: (widget.isDisabled
                  ? buttonThemeData.disabledColor
                  : buttonThemeData.primaryButtonColor),
            ),
            SizedBox(
                width: widget.size == ButtonSize.small ? theme.spacerTheme.spacer1 : theme.spacerTheme.spacer2),
          ],
          Flexible(
            child: Text(
              truncatedLabel,
              textAlign: TextAlign.center,
              style: buttonStyle.copyWith(
                fontWeight: isMouseDown ? FontWeight.w700 : FontWeight.w500,
                color: (widget.isDisabled
                    ? buttonThemeData.disabledColor
                    : buttonThemeData.primaryButtonColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(
                width: widget.size == ButtonSize.small ? theme.spacerTheme.spacer1 : theme.spacerTheme.spacer2),
            Icon(
              widget.suffixIcon,
              size: buttonIconSize,
              color: (widget.isDisabled
                  ? buttonThemeData.disabledColor
                  : buttonThemeData.primaryButtonColor),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final DigitButtonThemeData buttonThemeData = widget.buttonThemeData ??
        theme.extension<DigitButtonThemeData>() ??
        DigitButtonThemeData.defaultTheme(context);

    switch (widget.size) {
      case ButtonSize.small:
        buttonStyle = buttonThemeData.smallButtonTextStyle;
        buttonIconSize = buttonThemeData.smallIconSize;
        break;
      case ButtonSize.medium:
        buttonStyle = buttonThemeData.mediumButtonTextStyle;
        buttonIconSize = buttonThemeData.mediumIconSize;
        break;
      case ButtonSize.large:
        buttonStyle = buttonThemeData.largeButtonTextStyle;
        buttonIconSize = buttonThemeData.largeIconSize;
        break;
    }

    switch (widget.type) {
      case InfoButtonType.info:
        buttonColor = theme.colorTheme.alert.info;
        break;
      case InfoButtonType.warning:
        buttonColor = theme.colorTheme.alert.warning;
        break;
      case InfoButtonType.error:
        buttonColor = theme.colorTheme.alert.error;
        break;
      case InfoButtonType.success:
        buttonColor = theme.colorTheme.alert.success;
        break;
    }

    return _buildButtonWidget(context, buttonThemeData);
  }

  /// Build the button widget based on its type and state.
  Widget _buildButtonWidget(BuildContext context, DigitButtonThemeData buttonThemeData) {
    final theme = Theme.of(context);
    return InkWell(
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
      onTap: widget.isDisabled
          ? null
          : () {
              if (mounted) {
                widget.onPressed();
              }
            },
      onHover: (hover) {
        setState(() {
          isHovered = hover;
        });
      },
      splashColor: buttonThemeData.splashColor,
      hoverColor: buttonThemeData.hoverColor,
      highlightColor: buttonThemeData.hightlightColor,
      child: Container(
        height: widget.size == ButtonSize.large
            ? buttonThemeData.largeButtonHeight
            : widget.size == ButtonSize.medium
            ? buttonThemeData.mediumButtonHeight
            : buttonThemeData.smallButtonHeight,
        decoration: BoxDecoration(
          boxShadow: (isMouseDown)
              ? buttonThemeData.primaryButtonMouseDownBoxShadow
              : isHovered
                  ? buttonThemeData.primaryButtonHoverBoxShadow
                  : [],
          borderRadius: buttonThemeData.radius,
          border: Border.all(
            color: widget.isDisabled
                ? theme.colorTheme.text.disabled
                : buttonColor,
            width: buttonThemeData.borderWidth,
          ),
          color: widget.isDisabled
              ? theme.colorTheme.text.disabled
              : buttonColor,
        ),
        child: _buildButton(isHovered, isMouseDown, context, buttonThemeData),
      ),
    );
  }
}
