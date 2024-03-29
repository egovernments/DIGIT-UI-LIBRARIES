/*?
 `DigitCheckbox` is a DigitCheckbox component with a label and optional icon customization.

 This widget allows the user to toggle between checked and unchecked states. It supports
 customization of the DigitCheckbox icon color, label, and disabled state.

 Example usage:
 ```dart
 DigitCheckbox(
   label: 'DigitCheckbox label',
   onChanged: (value) {
     // Handle DigitCheckbox state change
     print('Feature X is now ${value ? 'enabled' : 'disabled'}');
   },
   disabled: false, // Set to true to disable the DigitCheckbox
   value: true, // Set the initial state of the DigitCheckbox
   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0), // Customize padding
   iconColor: Colors.blue, // Customize DigitCheckbox icon color
 )
 ...*/

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import 'digit_checkbox_icon.dart';

class DigitCheckbox extends StatefulWidget {
  /// The current value of the DigitCheckbox.
  final bool value;

  /// The label associated with the DigitCheckbox.
  final String label;

  /// Callback function triggered when the DigitCheckbox value changes.
  final ValueChanged<bool> onChanged;

  /// Padding around the DigitCheckbox widget.
  final EdgeInsetsGeometry padding;

  /// Indicates whether the DigitCheckbox is disabled or not.
  final bool isDisabled;

  /// Custom color for the DigitCheckbox icon.
  final Color? iconColor;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool capitalizeFirstLetter;

  /// Creates a `DigitCheckbox` widget with the given parameters.
  const DigitCheckbox({
    Key? key,
    required this.label,
    required this.onChanged,
    this.isDisabled = false,
    this.value = false,
    this.padding = DigitCheckboxConstants.defaultPadding,
    this.iconColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.capitalizeFirstLetter = true,
  }) : super(key: key);

  @override
  _DigitCheckboxState createState() => _DigitCheckboxState();
}

class _DigitCheckboxState extends State<DigitCheckbox> {
  late bool _currentState;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _currentState = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context);

    /// Capitalize the first letter of the label if required
    final processedLabel = widget.capitalizeFirstLetter
        ? widget.label.replaceRange(0, 1, widget.label[0].toUpperCase())
        : widget.label;

    return IntrinsicWidth(
      child: Padding(
        padding: widget.padding,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 2,),
                    InkWell(
                      hoverColor: const DigitColors().transparent,
                      splashColor: const DigitColors().transparent,
                      highlightColor: const DigitColors().transparent,
                      onHover: (hover) {
                        setState(() {
                          isHovered = hover;
                        });
                      },
                      onTap: widget.isDisabled
                          ? null
                          : () {
                        if(mounted){
                          setState(() {
                            _currentState = !_currentState;
                          });
                          widget.onChanged(_currentState);
                        }
                      },
                      child: SizedBox(
                        height: DigitCheckboxConstants.containerSize,
                        width: DigitCheckboxConstants.containerSize,
                        child: DigitCheckboxIcon(
                          state: _currentState
                              ? DigitCheckboxState.checked
                              : DigitCheckboxState.unchecked,
                          isDisabled: widget.isDisabled,
                          color: isHovered ? const DigitColors().light.primaryOrange :widget.iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: kPadding*2),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      processedLabel,
                      style: currentTypography.bodyL
                          .copyWith(
                        height: 1.5,
                        color: widget.isDisabled
                            ? const DigitColors().light.textDisabled
                            : const DigitColors().light.textPrimary,
                      ),
                    ),
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