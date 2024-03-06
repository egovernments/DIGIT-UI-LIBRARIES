/*?
 `DigitCheckbox` is a checkbox component with a label and optional icon customization.

 This widget allows the user to toggle between checked and unchecked states. It supports
 customization of the checkbox icon color, label, and disabled state.

 Example usage:
 ```dart
 DigitCheckbox(
   label: 'CheckBox label',
   onChanged: (value) {
     // Handle checkbox state change
     print('Feature X is now ${value ? 'enabled' : 'disabled'}');
   },
   disabled: false, // Set to true to disable the checkbox
   value: true, // Set the initial state of the checkbox
   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0), // Customize padding
   iconColor: Colors.blue, // Customize checkbox icon color
 )
 ...*/

import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';

class DigitCheckbox extends StatefulWidget {
  /// The current value of the checkbox.
  final bool value;

  /// The label associated with the checkbox.
  final String label;

  /// Callback function triggered when the checkbox value changes.
  final ValueChanged<bool> onChanged;

  /// Padding around the checkbox widget.
  final EdgeInsetsGeometry padding;

  /// Indicates whether the checkbox is disabled or not.
  final bool disabled;

  /// Custom color for the checkbox icon.
  final Color? iconColor;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// Creates a `DigitCheckbox` widget with the given parameters.
  const DigitCheckbox({
    Key? key,
    required this.label,
    required this.onChanged,
    this.disabled = false,
    this.value = false,
    this.padding = CheckboxConstants.defaultPadding,
    this.iconColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
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

    return IntrinsicWidth(
      child: Padding(
        padding: widget.padding,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  hoverColor: const DigitColors().transparent,
                  splashColor: const DigitColors().transparent,
                  highlightColor: const DigitColors().transparent,
                  onHover: (hover) {
                    setState(() {
                      isHovered = hover;
                    });
                  },
                  onTap: widget.disabled
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
                    height: CheckboxConstants.containerSize,
                    width: CheckboxConstants.containerSize,
                    child: DigitCheckboxIcon(
                      state: _currentState
                          ? CheckboxState.checked
                          : CheckboxState.unchecked,
                      isDisabled: widget.disabled,
                      color: isHovered ? const DigitColors().light.primaryOrange :widget.iconColor,
                    ),
                  ),
                ),
                const SizedBox(width: kPadding*2),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.label,
                      style: currentTypography.bodyL
                          .copyWith(
                        height: 1.5,
                        color: widget.disabled
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