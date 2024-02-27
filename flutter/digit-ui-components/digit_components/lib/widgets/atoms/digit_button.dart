/*`DigitButton` is a customizable button widget that supports various styles and states.

 This widget provides options for primary, secondary, tertiary, and link button types.
 It handles hover effects, disabled state, and different icon placements.

Example usage:
```dart
 DigitButton(
   label: 'Click me',
   onPressed: () {
    // Handle button press
   },
   type: ButtonType.primary,
   prefixIcon: Icons.star,
   suffixIcon: Icons.arrow_forward,
   isDisabled: false,
   contentPadding: DigitButtonConstants.defaultContentPadding,
   iconSize: DigitButtonConstants.defaultIconSize,
 )
 ```*/

import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';

class DigitButton extends StatefulWidget {
  /// The text displayed on the button, representing the button's label or content.
  final String label;

  /// Callback function invoked when the button is pressed. Defines the action to be performed.
  final VoidCallback onPressed;

  /// Specifies the type or style of the button (primary, secondary, tertiary, or link).
  final ButtonType type;

  /// Icon to be displayed before the label text. Can be null if no prefix icon is needed.
  final IconData? prefixIcon;

  /// Icon to be displayed after the label text. Can be null if no suffix icon is needed.
  final IconData? suffixIcon;

  /// Indicates whether the button is in a disabled state. If true, the button is disabled and cannot be interacted with.
  final bool isDisabled;

  /// Padding around the content of the button (label and icons).
  final EdgeInsetsGeometry contentPadding;

  /// Size of the icons (prefixIcon and suffixIcon) displayed on the button in logical pixels.
  final double iconSize;

  const DigitButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.type,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.contentPadding = DigitButtonConstants.defaultContentPadding,
    this.iconSize = DigitButtonConstants.defaultIconSize,
  }) : super(key: key);

  @override
  _DigitButtonState createState() => _DigitButtonState();
}

class _DigitButtonState extends State<DigitButton> {
  bool isHovered = false;
  bool isMouseDown = false;

  @override
  Widget build(BuildContext context) {
    return widget.isDisabled
        ? _buildButtonWidget()

    /// If disabled, don't use MouseRegion
        : MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: _buildButtonWidget(),
    );
  }

  /// Build the button widget based on its type and state.
  Widget _buildButtonWidget() {
    if (widget.type == ButtonType.primary ||
        widget.type == ButtonType.secondary) {
      if(widget.isDisabled){
        return IntrinsicHeight(
          child: IntrinsicWidth(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 32.0,
                minHeight: 32.0,
              ),
              decoration: BoxDecoration(
                boxShadow: (widget.type == ButtonType.primary &&
                    (isHovered == false || isMouseDown))
                    ? [
                  BoxShadow(
                    color: isMouseDown
                        ? const DigitColors().lightPrimaryOrange
                        : DigitButtonConstants.defaultSecondaryColor,
                    offset: isMouseDown
                        ? const Offset(0, 0)
                        : const Offset(0, 2.0),
                    spreadRadius: 0,
                    blurRadius: isMouseDown ? 4.50 : 0,
                  ),
                ]
                    : isMouseDown
                    ? [
                  BoxShadow(
                    color: const DigitColors().lightPrimaryOrange,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 4.50,
                  ),
                ]
                    : [],
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: widget.isDisabled
                      ? DigitButtonConstants.defaultDisabledColor
                      : DigitButtonConstants.defaultPrimaryColor,
                  width: isHovered
                      ? DigitButtonConstants.defaultHoverWidth
                      : DigitButtonConstants.defaultWidth,
                ),
                color: widget.type == ButtonType.primary
                    ? (widget.isDisabled
                    ? DigitButtonConstants.defaultDisabledColor
                    : isHovered
                    ? isMouseDown
                    ? const DigitColors().lightPrimaryOrange
                    : const DigitColors().primaryOrange
                    : const DigitColors().lightPrimaryOrange)
                    : const DigitColors().lightPaperPrimary,
              ),
              child: _buildButton(),
            ),
          ),
        );
      }else{
        return InkWell(
          onTapDown: (_) {
            /// Handle mouse down state
            setState(() {
              isMouseDown = true;
            });
          },
          onTapUp: (_) {
            /// Handle mouse up state
            setState(() {
              isMouseDown = false;
            });
          },
          onTap: widget.isDisabled ? null : widget.onPressed,
          splashColor: const DigitColors().transparent,
          hoverColor: const DigitColors().transparent,
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 32.0,
                  minHeight: 32.0,
                ),
                decoration: BoxDecoration(
                  boxShadow: (widget.type == ButtonType.primary &&
                      (isHovered == false || isMouseDown))
                      ? [
                    BoxShadow(
                      color: isMouseDown
                          ? const DigitColors().lightPrimaryOrange
                          : DigitButtonConstants.defaultSecondaryColor,
                      offset: isMouseDown
                          ? const Offset(0, 0)
                          : const Offset(0, 2.0),
                      spreadRadius: 0,
                      blurRadius: isMouseDown ? 4.50 : 0,
                    ),
                  ]
                      : isMouseDown
                      ? [
                    BoxShadow(
                      color: const DigitColors().lightPrimaryOrange,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 4.50,
                    ),
                  ]
                      : [],
                  borderRadius: BorderRadius.zero,
                  border: Border.all(
                    color: widget.isDisabled
                        ? DigitButtonConstants.defaultDisabledColor
                        : DigitButtonConstants.defaultPrimaryColor,
                    width: isHovered || isMouseDown
                        ? DigitButtonConstants.defaultHoverWidth
                        : DigitButtonConstants.defaultWidth,
                  ),
                  color: widget.type == ButtonType.primary
                      ? (widget.isDisabled
                      ? DigitButtonConstants.defaultDisabledColor
                      : isHovered
                      ? isMouseDown
                      ? const DigitColors().lightPrimaryOrange
                      : const DigitColors().primaryOrange
                      : const DigitColors().lightPrimaryOrange)
                      : const DigitColors().lightPaperPrimary,
                ),
                child: _buildButton(),
              ),
            ),
          ),
        );
      }

    } else {
      if(widget.isDisabled){
        return _buildButton();
      }else{
        return InkWell(
          onTap: widget.isDisabled ? null : widget.onPressed,
          hoverColor: const DigitColors().transparent.withOpacity(0),
          splashColor: const DigitColors().transparent.withOpacity(0),
          highlightColor: const DigitColors().transparent,
          child: IntrinsicWidth(
            child: _buildButton(),),
        );
      }
    }
  }

  /// Build the content of the button, including label and icons.
  Widget _buildButton() {
    String truncatedLabel = widget.label;

    /// Truncate label if it exceeds 64 characters &&  Capitalize the first letter of the label
    if (widget.type != ButtonType.link) {

      if(widget.label.length > 64){
        truncatedLabel = '${widget.label.substring(0, 64)}...';
      }

      truncatedLabel =
      truncatedLabel.isEmpty ? truncatedLabel : truncatedLabel[0].toUpperCase() + truncatedLabel.substring(1);
    }
    return Center(
      child: Padding(
        padding: widget.contentPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: widget.type == ButtonType.link ? 20 : widget.iconSize,
                color: widget.type == ButtonType.primary
                    ? DigitButtonConstants.defaultTextColor
                    : (widget.isDisabled
                    ? DigitButtonConstants.defaultDisabledColor
                    : DigitButtonConstants.defaultPrimaryColor),
              ),
              SizedBox(width: widget.type == ButtonType.link  ? kPadding/2:kPadding),
            ],
            Flexible(
              child: Text(
                truncatedLabel,
                style: widget.type == ButtonType.link
                    ? DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                    ?.copyWith(
                  height: 1.172,
                  color: widget.isDisabled
                      ? DigitButtonConstants.defaultDisabledColor
                      : DigitButtonConstants.defaultPrimaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: widget.isDisabled
                      ? DigitButtonConstants.defaultDisabledColor
                      : DigitButtonConstants.defaultPrimaryColor,)
                    : DigitTheme.instance.mobileTheme.textTheme.labelLarge
                    ?.copyWith(
                  height: 1.5,
                  color: widget.type == ButtonType.primary
                      ? DigitButtonConstants.defaultTextColor
                      : (widget.isDisabled
                      ? DigitButtonConstants.defaultDisabledColor
                      : DigitButtonConstants.defaultPrimaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              SizedBox(width: widget.type == ButtonType.link  ? kPadding/2:kPadding),
              Icon(
                widget.suffixIcon,
                size: widget.type == ButtonType.link ? 20 : widget.iconSize,
                color: widget.type == ButtonType.primary
                    ? DigitButtonConstants.defaultTextColor
                    : (widget.isDisabled
                    ? DigitButtonConstants.defaultDisabledColor
                    : DigitButtonConstants.defaultPrimaryColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}