import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitAccordionThemeData extends ThemeExtension<DigitAccordionThemeData> {
  final Color? headerBackgroundColor;
  final Color? headerTextColor;
  final TextStyle? headerTextStyle;
  final Color? contentBackgroundColor;
  final TextStyle? contentTextStyle;
  final double? headerElevation;
  final EdgeInsets? headerPadding;
  final EdgeInsets? contentPadding;
  final Duration? animationDuration;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;

  const DigitAccordionThemeData({
    this.headerBackgroundColor,
    this.headerTextColor,
    this.headerTextStyle,
    this.contentBackgroundColor,
    this.contentTextStyle,
    this.headerElevation,
    this.headerPadding,
    this.contentPadding,
    this.animationDuration,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
  });

  static DigitAccordionThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitAccordionThemeData(
      headerBackgroundColor: theme.colorTheme.paper.primary,
      headerTextColor: theme.colorTheme.text.primary,
      headerTextStyle: textTheme.headingM,
      contentBackgroundColor: theme.colorTheme.paper.secondary,
      contentTextStyle: textTheme.bodyL,
      headerElevation: 2.0,
      headerPadding: const EdgeInsets.all(16.0),
      contentPadding: const EdgeInsets.all(8.0),
      animationDuration: const Duration(milliseconds: 300),
      borderColor: theme.colorTheme.generic.divider,
      borderWidth: 1.0,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    );
  }

  @override
  DigitAccordionThemeData copyWith({
    Color? headerBackgroundColor,
    Color? headerTextColor,
    TextStyle? headerTextStyle,
    Color? contentBackgroundColor,
    TextStyle? contentTextStyle,
    double? headerElevation,
    EdgeInsets? headerPadding,
    EdgeInsets? contentPadding,
    Duration? animationDuration,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
  }) {
    return DigitAccordionThemeData(
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      contentBackgroundColor: contentBackgroundColor ?? this.contentBackgroundColor,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      headerElevation: headerElevation ?? this.headerElevation,
      headerPadding: headerPadding ?? this.headerPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      animationDuration: animationDuration ?? this.animationDuration,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  DigitAccordionThemeData lerp(ThemeExtension<DigitAccordionThemeData>? other, double t) {
    if (other is! DigitAccordionThemeData) return this;

    return DigitAccordionThemeData(
      headerBackgroundColor: Color.lerp(headerBackgroundColor, other.headerBackgroundColor, t),
      headerTextColor: Color.lerp(headerTextColor, other.headerTextColor, t),
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t),
      contentBackgroundColor: Color.lerp(contentBackgroundColor, other.contentBackgroundColor, t),
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t),
      headerElevation: lerpDouble(headerElevation, other.headerElevation, t),
      headerPadding: EdgeInsets.lerp(headerPadding, other.headerPadding, t),
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t),
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
    );
  }
}
