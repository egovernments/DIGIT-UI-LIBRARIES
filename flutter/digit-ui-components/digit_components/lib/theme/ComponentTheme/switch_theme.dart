import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class CustomSwitchThemeData extends ThemeExtension<CustomSwitchThemeData> {
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? symbolColor;
  final TextStyle? labelTextStyle;
  final double? thumbSize;
  final double? trackHeight;
  final double? trackWidth;
  final EdgeInsets? padding;
  final int? animationValue;

  const CustomSwitchThemeData({
    this.activeColor,
    this.inactiveColor,
    this.symbolColor,
    this.labelTextStyle,
    this.thumbSize,
    this.trackHeight,
    this.trackWidth,
    this.padding,
    this.animationValue,
  });

  static CustomSwitchThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return CustomSwitchThemeData(
      activeColor: theme.colorTheme.primary.primary1,
      inactiveColor: theme.colorTheme.text.disabled,
      symbolColor: theme.colorTheme.paper.primary,
      labelTextStyle: textTheme.bodyS.copyWith(
        color: theme.colorTheme.text.primary,
      ),
      thumbSize: 18.0,
      trackHeight: 22.0,
      trackWidth: 44,
      padding: const EdgeInsets.all(2),
      animationValue: 21,
    );
  }

  @override
  CustomSwitchThemeData copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? symbolColor,
    TextStyle? labelTextStyle,
    double? thumbSize,
    double? trackHeight,
    double? trackWidth,
    EdgeInsets? padding,
    int? animationValue,
  }) {
    return CustomSwitchThemeData(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      symbolColor: symbolColor ?? this.symbolColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      thumbSize: thumbSize ?? this.thumbSize,
      trackHeight: trackHeight ?? this.trackHeight,
      trackWidth: trackWidth ?? this.trackWidth,
      padding: padding ?? this.padding,
      animationValue: animationValue ?? this.animationValue,
    );
  }

  @override
  CustomSwitchThemeData lerp(covariant ThemeExtension<CustomSwitchThemeData>? other, double t) {
    if (other is! CustomSwitchThemeData) return this;

    return CustomSwitchThemeData(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t),
      symbolColor: Color.lerp(symbolColor, other.symbolColor, t),
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      thumbSize: lerpDouble(thumbSize, other.thumbSize, t),
      trackHeight: lerpDouble(trackHeight, other.trackHeight, t),
      trackWidth: lerpDouble(trackWidth, other.trackWidth, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      animationValue:t < 0.5 ? animationValue : other.animationValue,
    );
  }
}
