/*`Button` is a customizable button widget that supports various styles and states.

 This widget provides options for primary, secondary, tertiary, and link button types.
 It handles hover effects, disabled state, and different icon placements.

Example usage:
```dart
 Button(
   label: 'Click me',
   onPressed: () {
    // Handle button press
   },
   type: ButtonType.primary,
   prefixIcon: Icons.star,
   suffixIcon: Icons.arrow_forward,
   isDisabled: false,
   contentPadding: ButtonConstants.defaultContentPadding,
   iconSize: ButtonConstants.defaultIconSize,
 )
 ```*/

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';

class Button extends StatefulWidget {
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

  /// button width
  final double width;

  /// Padding around the content of the button (label and icons).
  final EdgeInsetsGeometry contentPadding;

  /// Size of the icons (prefixIcon and suffixIcon) displayed on the button in logical pixels.
  final double iconSize;

  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.type,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.width = 400,
    this.contentPadding = ButtonConstants.defaultContentPadding,
    this.iconSize = ButtonConstants.defaultIconSize,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isHovered = false;
  bool isMouseDown = false;
  late DigitTypography _currentTypography;

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    _currentTypography = getTypography(context);

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
      if (widget.isDisabled) {
        return Container(
          width: widget.width,
          constraints: const BoxConstraints(
            minWidth: 32.0,
            minHeight: 32.0,
          ),
          decoration: BoxDecoration(
            boxShadow: (isMouseDown)
                ? [
                    BoxShadow(
                      color: const DigitColors().light.primaryOrange,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 4.50,
                    ),
                  ]
                : widget.type == ButtonType.primary && isHovered == false
                    ? [
                        BoxShadow(
                          color:  const DigitColors().light.textPrimary.withOpacity(.5),
                          offset: const Offset(0, 2),
                          spreadRadius: 0,
                          blurRadius: 0,
                        ),
                      ]
                    : [],
            borderRadius: BorderRadius.zero,
            border: Border.all(
              color: widget.isDisabled
                  ? ButtonConstants.defaultDisabledColor
                  : isMouseDown
                      ? ButtonConstants.defaultPrimaryColor
                      : isHovered
                          ? const DigitColors().light.primaryOrange
                          : ButtonConstants.defaultPrimaryColor,
              width: isHovered
                  ? widget.type == ButtonType.secondary
                      ? ButtonConstants.defaultHoverWidth
                      : ButtonConstants.defaultWidth
                  : ButtonConstants.defaultWidth,
            ),
            color: widget.type == ButtonType.primary
                ? (widget.isDisabled
                    ? ButtonConstants.defaultDisabledColor
                    : isHovered
                        ? isMouseDown
                            ? const DigitColors().light.primaryOrange
                            : const DigitColors().darkPrimaryOrange
                        : const DigitColors().light.primaryOrange)
                : const DigitColors().light.paperPrimary,
          ),
          child: _buildButton(),
        );
      } else {
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
          onTap: widget.isDisabled
              ? null
              : () {
                  if (mounted) {
                    widget.onPressed();
                  }
                },
          splashColor: const DigitColors().transparent,
          hoverColor: const DigitColors().transparent,
          child: Container(
            width: widget.width,
            constraints: const BoxConstraints(
              minWidth: 32.0,
              minHeight: 32.0,
            ),
            decoration: BoxDecoration(
              boxShadow: (isMouseDown)
                  ? [
                      BoxShadow(
                        color: const DigitColors().light.primaryOrange,
                        offset: const Offset(0, 0),
                        spreadRadius: 0,
                        blurRadius: 4.50,
                      ),
                    ]
                  : widget.type == ButtonType.primary && isHovered == false
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
                    ? ButtonConstants.defaultDisabledColor
                    : isMouseDown
                        ? ButtonConstants.defaultPrimaryColor
                        : isHovered
                            ? const DigitColors().light.primaryOrange
                            : ButtonConstants.defaultPrimaryColor,
                width: isHovered
                    ? widget.type == ButtonType.secondary
                        ? ButtonConstants.defaultHoverWidth
                        : ButtonConstants.defaultWidth
                    : ButtonConstants.defaultWidth,
              ),
              color: widget.type == ButtonType.primary
                  ? (widget.isDisabled
                      ? ButtonConstants.defaultDisabledColor
                      : isHovered
                          ? isMouseDown
                              ? const DigitColors().light.primaryOrange
                              : const DigitColors().darkPrimaryOrange
                          : const DigitColors().light.primaryOrange)
                  : const DigitColors().light.paperPrimary,
            ),
            child: _buildButton(),
          ),
        );
      }
    } else {
      if (widget.isDisabled) {
        return _buildButton();
      } else {
        return InkWell(
          onTap: widget.isDisabled
              ? null
              : () {
                  if (mounted) {
                    widget.onPressed();
                  }
                },
          hoverColor: const DigitColors().transparent,
          splashColor: const DigitColors().transparent,
          highlightColor: const DigitColors().transparent,
          child: IntrinsicWidth(
            child: _buildButton(),
          ),
        );
      }
    }
  }

  /// Build the content of the button, including label and icons.
  Widget _buildButton() {
    String truncatedLabel = widget.label;

    /// Truncate label if it exceeds 64 characters &&  Capitalize the first letter of the label
    if (widget.type != ButtonType.link) {
      if (widget.label.length > 64) {
        truncatedLabel = '${widget.label.substring(0, 64)}...';
      }

      truncatedLabel = truncatedLabel.isEmpty
          ? truncatedLabel
          : truncatedLabel[0].toUpperCase() + truncatedLabel.substring(1);
    }
    return Padding(
      padding:
          widget.type == ButtonType.link || widget.type == ButtonType.tertiary
              ? EdgeInsets.zero
              : isHovered && widget.type == ButtonType.secondary
                  ? const EdgeInsets.only(
                      left: 24.0, top: 6.0, right: 24.0, bottom: 8.0)
                  : widget.contentPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null) ...[
            Column(
              children: [
                if (widget.type == ButtonType.secondary ||
                    widget.type == ButtonType.primary)
                  const SizedBox(
                    height: 3,
                  ),
                Icon(
                  widget.prefixIcon,
                  size: widget.type == ButtonType.link ? 20 : widget.iconSize,
                  color: widget.type == ButtonType.primary
                      ? ButtonConstants.defaultTextColor
                      : (widget.isDisabled
                          ? ButtonConstants.defaultDisabledColor
                          : ButtonConstants.defaultPrimaryColor),
                ),
              ],
            ),
            SizedBox(
                width:
                    widget.type == ButtonType.link ? kPadding / 2 : kPadding),
          ],
          Flexible(
            child: Text(
              truncatedLabel,
              textAlign: TextAlign.center,
              style: widget.type == ButtonType.link
                  ? _currentTypography.link.copyWith(
                      height: 1.172,
                      color: widget.isDisabled
                          ? ButtonConstants.defaultDisabledColor
                          : ButtonConstants.defaultPrimaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: widget.isDisabled
                          ? ButtonConstants.defaultDisabledColor
                          : ButtonConstants.defaultPrimaryColor,
                    )
                  : _currentTypography.button.copyWith(
                      height: 1.5,
                      color: widget.type == ButtonType.primary
                          ? ButtonConstants.defaultTextColor
                          : (widget.isDisabled
                              ? ButtonConstants.defaultDisabledColor
                              : ButtonConstants.defaultPrimaryColor),
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(
                width:
                    widget.type == ButtonType.link ? kPadding / 2 : kPadding),
            Column(
              children: [
                if (widget.type == ButtonType.secondary ||
                    widget.type == ButtonType.primary)
                  const SizedBox(
                    height: 3,
                  ),
                Icon(
                  widget.suffixIcon,
                  size: widget.type == ButtonType.link ? 20 : widget.iconSize,
                  color: widget.type == ButtonType.primary
                      ? ButtonConstants.defaultTextColor
                      : (widget.isDisabled
                          ? ButtonConstants.defaultDisabledColor
                          : ButtonConstants.defaultPrimaryColor),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
