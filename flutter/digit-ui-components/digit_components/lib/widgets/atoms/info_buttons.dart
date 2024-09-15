import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class InfoButton extends StatefulWidget {
  /// The text displayed on the DigitButton, representing the DigitButton's label or content.
  final String label;

  /// Callback function invoked when the DigitButton is pressed. Defines the action to be performed.
  final VoidCallback onPressed;

  /// Size of the DigitButton--- medium, large or small
  final DigitButtonSize size;

  /// type of info DigitButton--- info, success, error or warning
  final InfoDigitButtonType type;

  /// Icon to be displayed before the label text. Can be null if no prefix icon is needed.
  final IconData? prefixIcon;

  /// Icon to be displayed after the label text. Can be null if no suffix icon is needed.
  final IconData? suffixIcon;

  /// Indicates whether the DigitButton is in a disabled state. If true, the DigitButton is disabled and cannot be interacted with.
  final bool isDisabled;

  final bool capitalizeLetters;
  final DigitButtonThemeData? digitButtonThemeData;

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
    this.digitButtonThemeData,
  }) : super(key: key);

  @override
  _InfoDigitButtonState createState() => _InfoDigitButtonState();
}

class _InfoDigitButtonState extends State<InfoButton> {
  bool isHovered = false;
  bool isMouseDown = false;
  late TextStyle DigitButtonStyle;
  late double DigitButtonIconSize;
  late Color DigitButtonColor;

  /// Build the content of the DigitButton, including label and icons.
  Widget _buildDigitButton(bool isHovered, bool isMouseDown, BuildContext context, DigitButtonThemeData digitButtonThemeData) {
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
      padding: digitButtonThemeData.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null) ...[
            Icon(
              widget.prefixIcon,
              size: DigitButtonIconSize,
              color: (widget.isDisabled
                  ? digitButtonThemeData.disabledColor
                  : digitButtonThemeData.primaryDigitButtonColor),
            ),
            SizedBox(
                width: widget.size == DigitButtonSize.small ? theme.spacerTheme.spacer1 : theme.spacerTheme.spacer2),
          ],
          Flexible(
            child: Text(
              truncatedLabel,
              textAlign: TextAlign.center,
              style: DigitButtonStyle.copyWith(
                fontWeight: isMouseDown ? FontWeight.w700 : FontWeight.w500,
                color: (widget.isDisabled
                    ? digitButtonThemeData.disabledColor
                    : digitButtonThemeData.primaryDigitButtonColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(
                width: widget.size == DigitButtonSize.small ? theme.spacerTheme.spacer1 : theme.spacerTheme.spacer2),
            Icon(
              widget.suffixIcon,
              size: DigitButtonIconSize,
              color: (widget.isDisabled
                  ? digitButtonThemeData.disabledColor
                  : digitButtonThemeData.primaryDigitButtonColor),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final DigitButtonThemeData digitButtonThemeData = widget.digitButtonThemeData ??
        theme.extension<DigitButtonThemeData>() ??
        DigitButtonThemeData.defaultTheme(context);

    switch (widget.size) {
      case DigitButtonSize.small:
        DigitButtonStyle = digitButtonThemeData.smallDigitButtonTextStyle;
        DigitButtonIconSize = digitButtonThemeData.smallIconSize;
        break;
      case DigitButtonSize.medium:
        DigitButtonStyle = digitButtonThemeData.mediumDigitButtonTextStyle;
        DigitButtonIconSize = digitButtonThemeData.mediumIconSize;
        break;
      case DigitButtonSize.large:
        DigitButtonStyle = digitButtonThemeData.largeDigitButtonTextStyle;
        DigitButtonIconSize = digitButtonThemeData.largeIconSize;
        break;
    }

    switch (widget.type) {
      case InfoDigitButtonType.info:
        DigitButtonColor = theme.colorTheme.alert.info;
        break;
      case InfoDigitButtonType.warning:
        DigitButtonColor = theme.colorTheme.alert.warning;
        break;
      case InfoDigitButtonType.error:
        DigitButtonColor = theme.colorTheme.alert.error;
        break;
      case InfoDigitButtonType.success:
        DigitButtonColor = theme.colorTheme.alert.success;
        break;
    }

    return _buildDigitButtonWidget(context, digitButtonThemeData);
  }

  /// Build the DigitButton widget based on its type and state.
  Widget _buildDigitButtonWidget(BuildContext context, DigitButtonThemeData digitButtonThemeData) {
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
      splashColor: digitButtonThemeData.splashColor,
      hoverColor: digitButtonThemeData.hoverColor,
      highlightColor: digitButtonThemeData.hightlightColor,
      child: Container(
        height: widget.size == DigitButtonSize.large
            ? digitButtonThemeData.largeDigitButtonHeight
            : widget.size == DigitButtonSize.medium
            ? digitButtonThemeData.mediumDigitButtonHeight
            : digitButtonThemeData.smallDigitButtonHeight,
        decoration: BoxDecoration(
          boxShadow: (isMouseDown)
              ? digitButtonThemeData.primaryDigitButtonMouseDownBoxShadow
              : isHovered
              ? digitButtonThemeData.primaryDigitButtonHoverBoxShadow
              : [],
          borderRadius: digitButtonThemeData.radius,
          border: Border.all(
            color: widget.isDisabled
                ? theme.colorTheme.text.disabled
                : DigitButtonColor,
            width: digitButtonThemeData.borderWidth,
          ),
          color: widget.isDisabled
              ? theme.colorTheme.text.disabled
              : DigitButtonColor,
        ),
        child: _buildDigitButton(isHovered, isMouseDown, context, digitButtonThemeData),
      ),
    );
  }
}