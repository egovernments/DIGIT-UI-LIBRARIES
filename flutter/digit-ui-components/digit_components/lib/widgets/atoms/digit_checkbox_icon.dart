import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../theme/ComponentTheme/checkbox_theme.dart';

/// `DigitCheckboxIcon` is a widget that represents the visual appearance of a DigitCheckbox.
/// It supports three states: unchecked, intermediate, and checked. The appearance can be customized
/// based on the state, disabled status, and color.
class DigitCheckboxIcon extends StatelessWidget {
  /// Represents the current state of the DigitCheckbox.
  final DigitCheckboxState state;

  /// Indicates whether the DigitCheckbox is disabled or not.
  final bool isDisabled;

  final DigitCheckboxThemeData? checkboxThemeData;


  /// Creates a `DigitCheckboxIcon` widget with the given parameters.
  const DigitCheckboxIcon({
    super.key,
    required this.state,
    this.isDisabled = false,
    this.checkboxThemeData,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final checkboxIconThemeData = checkboxThemeData ??
        theme.extension<DigitCheckboxThemeData>();
    final iconThemeData =    DigitCheckboxThemeData.defaultTheme(context);

    switch (state) {
      case DigitCheckboxState.unchecked:
        return Container(
          width: checkboxIconThemeData?.iconSize ?? iconThemeData.iconSize,
          height: checkboxIconThemeData?.iconSize ?? iconThemeData.iconSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDisabled ? (checkboxIconThemeData?.disabledIconColor ?? iconThemeData.disabledIconColor!) : (checkboxIconThemeData?.iconColor ?? iconThemeData.iconColor!),
              width: Base.defaultBorderWidth,
            ),
            borderRadius: Base.radius,
          ),
        );
      case DigitCheckboxState.intermediate:
        return Container(
          width: checkboxIconThemeData?.iconSize ?? iconThemeData.iconSize,
          height: checkboxIconThemeData?.iconSize ?? iconThemeData.iconSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDisabled ? (checkboxIconThemeData?.disabledIconColor ?? iconThemeData.disabledIconColor!) : (checkboxIconThemeData?.selectedIconColor ?? iconThemeData.selectedIconColor!),
              width: DigitCheckboxConstants.borderWidth,
            ),
            borderRadius: Base.radius,
          ),
          child: Center(
            child: Icon(
              Icons.square,
              size: theme.spacerTheme.spacer3,
              color: isDisabled ? (checkboxIconThemeData?.disabledIconColor ?? iconThemeData.disabledIconColor!) : (checkboxIconThemeData?.selectedIconColor ?? iconThemeData.selectedIconColor!),
            ),
          ),
        );
      case DigitCheckboxState.checked:
        return Container(
          width: checkboxIconThemeData?.iconSize ?? iconThemeData.iconSize,
          height: checkboxIconThemeData?.iconSize ?? iconThemeData.iconSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDisabled ? (checkboxIconThemeData?.disabledIconColor ?? iconThemeData.disabledIconColor!) : (checkboxIconThemeData?.selectedIconColor ?? iconThemeData.selectedIconColor!),
              width: DigitCheckboxConstants.borderWidth,
            ),
            borderRadius: Base.radius,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: DigitCheckboxConstants.iconSize,
              color: isDisabled ? (checkboxIconThemeData?.disabledIconColor ?? iconThemeData.disabledIconColor!) : (checkboxIconThemeData?.selectedIconColor ?? iconThemeData.selectedIconColor!),
            ),
          ),
        );
    }
  }
}