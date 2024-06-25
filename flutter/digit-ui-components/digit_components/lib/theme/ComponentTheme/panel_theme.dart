import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class PanelThemeData extends ThemeExtension<PanelThemeData> {
  final TextStyle titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final Color successBackgroundColor;
  final Color errorBackgroundColor;
  final double successAnimationSize;
  final double errorAnimationSize;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  const PanelThemeData({
    required this.titleTextStyle,
    this.descriptionTextStyle,
    required this.successBackgroundColor,
    required this.errorBackgroundColor,
    required this.successAnimationSize,
    required this.errorAnimationSize,
    required this.borderRadius,
    required this.padding,
  });

  static PanelThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return PanelThemeData(
      titleTextStyle: textTheme.headingS.copyWith(color: Colors.white),
      descriptionTextStyle: theme.textTheme.bodyText2!.copyWith(color: Colors.white70),
      successBackgroundColor: Colors.green,
      errorBackgroundColor: Colors.red,
      successAnimationSize: 100.0,
      errorAnimationSize: 100.0,
      borderRadius: BorderRadius.circular(8.0),
      padding: EdgeInsets.all(16.0),
    );
  }

  @override
  PanelThemeData copyWith({
    TextStyle? titleTextStyle,
    TextStyle? descriptionTextStyle,
    Color? successBackgroundColor,
    Color? errorBackgroundColor,
    double? successAnimationSize,
    double? errorAnimationSize,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return PanelThemeData(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      successBackgroundColor: successBackgroundColor ?? this.successBackgroundColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      successAnimationSize: successAnimationSize ?? this.successAnimationSize,
      errorAnimationSize: errorAnimationSize ?? this.errorAnimationSize,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  @override
  PanelThemeData lerp(ThemeExtension<PanelThemeData>? other, double t) {
    if (other is! PanelThemeData) return this;

    return PanelThemeData(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      descriptionTextStyle: TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t),
      successBackgroundColor: Color.lerp(successBackgroundColor, other.successBackgroundColor, t)!,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t)!,
      successAnimationSize: lerpDouble(successAnimationSize, other.successAnimationSize, t)!,
      errorAnimationSize: lerpDouble(errorAnimationSize, other.errorAnimationSize, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
    );
  }
}
