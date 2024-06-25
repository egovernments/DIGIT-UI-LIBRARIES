import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitRadioListThemeData extends ThemeExtension<DigitRadioListThemeData> {
  final TextStyle textStyle;
  final Color selectedColor;
  final Color unselectedColor;
  final Color hoverColor;
  final Color disabledColor;
  final EdgeInsets containerPadding;
  final double radioWidth;
  final double radioHeight;

  const DigitRadioListThemeData({
    required this.textStyle,
    required this.selectedColor,
    required this.unselectedColor,
    required this.hoverColor,
    required this.disabledColor,
    required this.containerPadding,
    required this.radioWidth,
    required this.radioHeight,
  });

  static DigitRadioListThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitRadioListThemeData(
      textStyle: textTheme.bodyL,
      selectedColor: theme.colorTheme.primary.primary1,
      unselectedColor: theme.colorTheme.text.disabled,
      hoverColor: Colors.lightBlue,
      disabledColor: Colors.grey.shade400,
      containerPadding: EdgeInsets.all(theme.spacerTheme.spacer2),
      radioWidth: theme.spacerTheme.spacer6,
      radioHeight: theme.spacerTheme.spacer6,
    );
  }

  @override
  DigitRadioListThemeData copyWith({
    TextStyle? textStyle,
    Color? selectedColor,
    Color? unselectedColor,
    Color? hoverColor,
    Color? disabledColor,
    EdgeInsets? containerPadding,
    double? radioWidth,
    double? radioHeight,
  }) {
    return DigitRadioListThemeData(
      textStyle: textStyle ?? this.textStyle,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      hoverColor: hoverColor ?? this.hoverColor,
      disabledColor: disabledColor ?? this.disabledColor,
      containerPadding: containerPadding ?? this.containerPadding,
      radioWidth: radioWidth ?? this.radioWidth,
      radioHeight: radioHeight ?? this.radioHeight,
    );
  }

  @override
  DigitRadioListThemeData lerp(ThemeExtension<DigitRadioListThemeData>? other, double t) {
    if (other is! DigitRadioListThemeData) return this;

    return DigitRadioListThemeData(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      containerPadding: EdgeInsets.lerp(containerPadding, other.containerPadding, t)!,
      radioWidth: lerpDouble(radioWidth, other.radioWidth, t)!,
      radioHeight: lerpDouble(radioHeight, other.radioHeight, t)!,
    );
  }
}
