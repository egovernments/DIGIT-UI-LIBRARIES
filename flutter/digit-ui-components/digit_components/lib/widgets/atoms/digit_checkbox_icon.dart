import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';

/// `DigitCheckboxIcon` is a widget that represents the visual appearance of a DigitCheckbox.
/// It supports three states: unchecked, intermediate, and checked. The appearance can be customized
/// based on the state, disabled status, and color.
class DigitCheckboxIcon extends StatelessWidget {
  /// Represents the current state of the DigitCheckbox.
  final DigitCheckboxState state;

  /// Indicates whether the DigitCheckbox is disabled or not.
  final bool isDisabled;

  /// Custom color for the DigitCheckbox. If not provided, default colors will be used based on the state and disabled status.
  final Color? color;
  final double size;

  /// Creates a `DigitCheckboxIcon` widget with the given parameters.
  const DigitCheckboxIcon({
    super.key,
    required this.state,
    this.isDisabled = false,
    this.color,
    this.size = DigitCheckboxConstants.containerSize,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDigitCheckbox();
  }

  /// Builds the DigitCheckbox widget based on its state.
  Widget _buildDigitCheckbox() {
    switch (state) {
      case DigitCheckboxState.unchecked:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: DigitCheckboxConstants.uncheckedBorderColor(
                  isDisabled: isDisabled, customColor: color),
              width: 1,
            ),
            borderRadius: Common.radius,
          ),
        );
      case DigitCheckboxState.intermediate:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: DigitCheckboxConstants.intermediateBorderColor(
                  isDisabled: isDisabled, customColor: color),
              width: DigitCheckboxConstants.borderWidth,
            ),
            borderRadius: Common.radius,
          ),
          child: Center(
            child: Icon(
              Icons.square,
              size: DigitCheckboxConstants.iconSize,
              color: DigitCheckboxConstants.iconColor(
                  isDisabled: isDisabled, customColor: color),
            ),
          ),
        );
      case DigitCheckboxState.checked:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: DigitCheckboxConstants.checkedBorderColor(
                  isDisabled: isDisabled, customColor: color),
              width: DigitCheckboxConstants.borderWidth,
            ),
            borderRadius: Common.radius,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: DigitCheckboxConstants.iconSize,
              color: DigitCheckboxConstants.iconColor(
                  isDisabled: isDisabled, customColor: color),
            ),
          ),
        );
    }
  }
}