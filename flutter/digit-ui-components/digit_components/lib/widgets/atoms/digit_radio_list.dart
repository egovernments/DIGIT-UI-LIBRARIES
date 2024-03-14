/*
 `RadioList` is a widget for rendering a list of radio buttons.
 This widget provides options for radio buttons, handling hover effects, and a disabled state.

 Example usage:
 ```dart
 RadioList(
   radioButtons: [
     RadioButtonModel(code: 'option1', name: 'Option 1'),
     RadioButtonModel(code: 'option2', name: 'Option 2'),
   ],
   onChanged: (selectedValue) {
     // Handle radio button selection
   },
   groupValue: 'option1', // can be passed same to select value initially
   isDisabled: false,
 )
 ....*/

import 'package:digit_flutter_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../models/RadioButtonModel.dart';

class RadioList extends StatefulWidget {
  /// List of RadioButtonModel objects representing the radio buttons
  final List<RadioButtonModel> radioButtons;

  /// Callback function to be called when a radio button is selected
  final void Function(RadioButtonModel) onChanged;

  /// Currently selected value in the radio button group
  String groupValue;

  /// Flag to indicate if the radio buttons are disabled
  final bool isDisabled;

  /// container padding
  final EdgeInsetsGeometry containerPadding;

  /// radio button width
  final double radioWidth;

  /// radio button height
  final double radioHeight;

  /// Constructor for the RadioList widget
  RadioList({
    Key? key,
    required this.radioButtons,
    required this.onChanged,
    this.groupValue = '',
    this.isDisabled = false,
    this.containerPadding = RadioConstant.defaultPadding,
    this.radioWidth = RadioConstant.radioWidth,
    this.radioHeight = RadioConstant.radioHeight,
  }) : super(key: key);

  /// Create the state for the widget
  @override
  _RadioListState createState() => _RadioListState();
}

/// State class for the RadioList widget
class _RadioListState extends State<RadioList> {
  /// List to track whether each radio button is being hovered over
  late List<bool> isHoveredList;
  late List<bool> isMouseDown;
  late bool isMobile;

  /// Initialize the state
  @override
  void initState() {
    super.initState();

    /// Initialize the hover list with false values
    isHoveredList = List.generate(widget.radioButtons.length, (index) => false);
    isMouseDown = List.generate(widget.radioButtons.length, (index) => false);
  }

  /// Build the widget layout
  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context);
    isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);
    if (!isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildRadioButtons(currentTypography),
      );
    }

    /// Default layout
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildRadioButtons(currentTypography),
    );
  }

  List<Widget> _buildRadioButtons(DigitTypography currentTypography) {
    return widget.radioButtons.map(
      (button) {
        final index = widget.radioButtons.indexOf(button);
        return Padding(
          padding: widget.containerPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isDisabled
                  ? Container(
                      padding: const EdgeInsets.all(kPadding / 2),
                      width: widget.radioWidth,
                      height: widget.radioHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.isDisabled
                              ? const DigitColors().light.genericDivider
                              : (widget.groupValue == button.code ||
                                      isHoveredList[index] ||
                                      isMouseDown[index])
                                  ? const DigitColors().light.primaryOrange
                                  : const DigitColors().light.textSecondary,
                          width: (widget.isDisabled &&
                                      widget.groupValue == button.code) ||
                                  widget.groupValue == button.code
                              ? 2.0
                              : 1.0,
                        ),
                        color: widget.isDisabled
                            ? const DigitColors().light.paperSecondary
                            : isMouseDown[index]
                                ? const DigitColors().orangeBG
                                : const DigitColors().light.paperPrimary,
                        boxShadow: isMouseDown[index]
                            ? [
                                BoxShadow(
                                  color: const DigitColors().orangeBG,
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(0, 0),
                                ),
                              ]
                            : [],
                      ),
                      child: widget.groupValue == button.code
                          ? Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.isDisabled
                                    ? const DigitColors().light.textDisabled
                                    : const DigitColors().light.primaryOrange,
                              ),
                            )
                          : null,
                    )
                  : InkWell(
                      hoverColor: const DigitColors().transparent,
                      splashColor: const DigitColors().transparent,
                      highlightColor: const DigitColors().transparent,
                      onHover: (hover) {
                        setState(() {
                          isHoveredList[index] = hover;
                        });
                      },
                      onTapDown: (_) {
                        /// Handle mouse down state
                        setState(() {
                          isMouseDown[index] = true;
                        });
                      },
                      onTapUp: (_) {
                        /// Handle mouse up state
                        setState(() {
                          isMouseDown[index] = false;
                        });
                      },
                      onTap: widget.isDisabled
                          ? null
                          : () {
                              if (mounted) {
                                setState(() {
                                  /// Update the selected value and call the onChanged callback
                                  widget.groupValue = button.code;
                                });
                                widget.onChanged!(button);
                              }
                            },
                      child: Container(
                        padding: const EdgeInsets.all(kPadding / 2),
                        width: widget.radioWidth,
                        height: widget.radioHeight,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.isDisabled
                                ? const DigitColors().light.genericDivider
                                : (widget.groupValue == button.code ||
                                        isHoveredList[index] ||
                                        isMouseDown[index])
                                    ? const DigitColors().light.primaryOrange
                                    : const DigitColors().light.textSecondary,
                            width: (widget.isDisabled &&
                                        widget.groupValue == button.code) ||
                                    widget.groupValue == button.code
                                ? 2.0
                                : 1.0,
                          ),
                          color: widget.isDisabled
                              ? const DigitColors().light.paperSecondary
                              : isMouseDown[index]
                                  ? const DigitColors().orangeBG
                                  : const DigitColors().light.paperPrimary,
                          boxShadow: isMouseDown[index]
                              ? [
                                  BoxShadow(
                                    color: const DigitColors().orangeBG,
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(0, 0),
                                  ),
                                ]
                              : [],
                        ),
                        child: widget.groupValue == button.code
                            ? Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.isDisabled
                                      ? const DigitColors().light.textDisabled
                                      : const DigitColors().light.primaryOrange,
                                ),
                              )
                            : null,
                      ),
                    ),
              const SizedBox(
                width: kPadding,
              ),
              isMobile
                  ? Expanded(
                      child: Text(
                        button.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: currentTypography.bodyL.copyWith(
                          height: 1.172,
                          color: widget.isDisabled
                              ? const DigitColors().light.textDisabled
                              : const DigitColors().light.textPrimary,
                        ),
                      ),
                    )
                  : Text(
                      button.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: currentTypography.bodyL.copyWith(
                        height: 1.172,
                        color: widget.isDisabled
                            ? const DigitColors().light.textDisabled
                            : const DigitColors().light.textPrimary,
                      ),
                    ),
            ],
          ),
        );
      },
    ).toList();
  }
}
