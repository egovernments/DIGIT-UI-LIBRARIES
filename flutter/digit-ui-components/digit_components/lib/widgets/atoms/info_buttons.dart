import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
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

  /// button width
  final double width;

  /// Padding around the content of the button (label and icons).
  final EdgeInsetsGeometry contentPadding;

  /// Size of the icons (prefixIcon and suffixIcon) displayed on the button in logical pixels.
  final double? iconSize;
  final bool capitalizeLetters;

  const InfoButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.type,
    required this.size,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.width = 400,
    this.contentPadding = ButtonConstants.defaultContentPadding,
    this.iconSize,
    this.capitalizeLetters = true,
  }) : super(key: key);

  @override
  _InfoButtonState createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  bool isHovered = false;
  bool isMouseDown = false;
  late DigitTypography _currentTypography;
  late TextStyle buttonStyle;
  late double buttonIconSize;
  late Color buttonColor;

  /// Build the content of the button, including label and icons.
  Widget _buildButton(bool isHovered, bool isMouseDown) {
    String truncatedLabel = widget.label;

    /// Truncate label if it exceeds 64 characters &&  Capitalize the letter of the label

    if (widget.label.length > 64) {
      truncatedLabel = '${widget.label.substring(0, 64)}...';
    }

    truncatedLabel = truncatedLabel.isEmpty || !widget.capitalizeLetters
        ? truncatedLabel
        : capitalizeFirstLetterOfEveryWord(truncatedLabel);

    return Padding(
      padding: widget.contentPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null) ...[
            Icon(
              widget.prefixIcon,
              size: widget.iconSize ?? buttonIconSize,
              color: (widget.isDisabled
                  ? const DigitColors().light.textDisabled
                  : const DigitColors().light.paperPrimary),
            ),
            SizedBox(
                width: widget.size == ButtonSize.small ? spacer1 : spacer2),
          ],
          Flexible(
            child: Text(
              truncatedLabel,
              textAlign: TextAlign.center,
              style: buttonStyle.copyWith(
                fontWeight: isMouseDown ? FontWeight.w700 : FontWeight.w500,
                color: (widget.isDisabled
                    ? const DigitColors().light.textDisabled
                    : const DigitColors().light.paperPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(
                width: widget.size == ButtonSize.small ? spacer1 : spacer2),
            Icon(
              widget.suffixIcon,
              size: widget.iconSize ?? buttonIconSize,
              color: (widget.isDisabled
                  ? const DigitColors().light.textDisabled
                  : const DigitColors().light.paperPrimary),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    _currentTypography = getTypography(context, true);

    switch (widget.size) {
      case ButtonSize.small:
        buttonStyle = _currentTypography.headingS;
        buttonIconSize = ButtonConstants.smallIconSize;
        break;
      case ButtonSize.medium:
        buttonStyle = _currentTypography.headingM;
        buttonIconSize = ButtonConstants.mediumIconSize;
        break;
      case ButtonSize.large:
        buttonStyle = _currentTypography.headingL;
        buttonIconSize = ButtonConstants.largeIconSize;
        break;
    }

    switch (widget.type) {
      case InfoButtonType.info:
        buttonColor = const DigitColors().light.alertInfo;
        break;
      case InfoButtonType.warning:
        buttonColor = const DigitColors().light.alertWarning;
        break;
      case InfoButtonType.error:
        buttonColor = const DigitColors().light.alertError;
        break;
      case InfoButtonType.success:
        buttonColor = const DigitColors().light.alertSuccess;
        break;
    }

    return _buildButtonWidget();
  }

  /// Build the button widget based on its type and state.
  Widget _buildButtonWidget() {
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
      splashColor: const DigitColors().transparent,
      hoverColor: const DigitColors().transparent,
      child: Container(
        height: widget.size == ButtonSize.large
            ? ButtonConstants.largeButtonSize
            : widget.size == ButtonSize.medium
            ? ButtonConstants.mediumButtonSize
            : ButtonConstants.smallButtonSize,
        decoration: BoxDecoration(
          boxShadow: (isMouseDown)
              ? [
                  BoxShadow(
                    color: const DigitColors().light.textPrimary,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                    blurRadius: 0,
                  ),
                  BoxShadow(
                    color:
                        const DigitColors().light.textPrimary.withOpacity(.25),
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                    blurRadius: 2.8,
                  ),
                ]
              : isHovered
                  ? [
                      BoxShadow(
                        color: const DigitColors().light.textPrimary,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                        blurRadius: 0,
                      ),
                    ]
                  : [],
          borderRadius: BorderRadius.zero,
          border: Border.all(
            color: widget.isDisabled
                ? const DigitColors().light.textDisabled
                : buttonColor,
            width: Common.defaultBorderWidth,
          ),
          color: widget.isDisabled
              ? const DigitColors().light.textDisabled
              : buttonColor,
        ),
        child: _buildButton(isHovered, isMouseDown),
      ),
    );
  }
}
