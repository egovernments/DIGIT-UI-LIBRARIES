import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitTabBarThemeData extends ThemeExtension<DigitTabBarThemeData> {
  final Color? selectedTabColor;
  final Color? unselectedTabColor;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final double? tabHeight;
  final double? selectedTabHeight;
  final double? tabWidth;
  final int? maxLine;
  final EdgeInsets? padding;

  const DigitTabBarThemeData({
    this.selectedTabColor,
    this.unselectedTabColor,
    this.borderColor,
    this.selectedBorderColor,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.tabHeight,
    this.selectedTabHeight,
    this.tabWidth,
    this.maxLine,
    this.padding,
  });

  static DigitTabBarThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitTabBarThemeData(
      selectedTabColor: theme.colorTheme.paper.primary,
      unselectedTabColor: theme.colorTheme.text.secondary,
      borderColor: theme.colorTheme.generic.inputBorder,
      selectedBorderColor: theme.colorTheme.primary.primary1,
      selectedTextStyle: textTheme.headingS.copyWith(
        color: theme.colorTheme.primary.primary1,
      ),
      unselectedTextStyle: textTheme.bodyS.copyWith(
        color: theme.colorTheme.text.secondary,
      ),
      selectedTabHeight: 56.0,
      tabHeight: 52.0,
      maxLine: 1,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    );
  }

  @override
  DigitTabBarThemeData copyWith({
    Color? selectedTabColor,
    Color? unselectedTabColor,
    Color? borderColor,
    Color? selectedBorderColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    double? tabHeight,
    double? selectedTabHeight,
    double? tabWidth,
    int? maxLine,
    EdgeInsets? padding,
  }) {
    return DigitTabBarThemeData(
      selectedTabColor: selectedTabColor ?? this.selectedTabColor,
      unselectedTabColor: unselectedTabColor ?? this.unselectedTabColor,
      borderColor: borderColor ?? this.borderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
      tabHeight: tabHeight ?? this.tabHeight,
      selectedTabHeight: selectedTabHeight ?? this.selectedTabHeight,
      tabWidth: tabWidth ?? this.tabWidth,
      maxLine: maxLine ?? this.maxLine,
      padding: padding ?? this.padding,
    );
  }

  @override
  DigitTabBarThemeData lerp(covariant ThemeExtension<DigitTabBarThemeData>? other, double t) {
    if (other is! DigitTabBarThemeData) return this;

    return DigitTabBarThemeData(
      selectedTabColor: Color.lerp(selectedTabColor, other.selectedTabColor, t),
      unselectedTabColor: Color.lerp(unselectedTabColor, other.unselectedTabColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      selectedBorderColor: Color.lerp(selectedBorderColor, other.selectedBorderColor, t),
      selectedTextStyle: TextStyle.lerp(selectedTextStyle, other.selectedTextStyle, t),
      unselectedTextStyle: TextStyle.lerp(unselectedTextStyle, other.unselectedTextStyle, t),
      tabHeight: lerpDouble(tabHeight, other.tabHeight, t),
      selectedTabHeight: lerpDouble(selectedTabHeight, other.selectedTabHeight, t),
      tabWidth: lerpDouble(tabWidth, other.tabWidth, t),
      maxLine: t<0.5 ? maxLine : other.maxLine,
      padding: EdgeInsets.lerp(padding, other.padding, t),
    );
  }
}
