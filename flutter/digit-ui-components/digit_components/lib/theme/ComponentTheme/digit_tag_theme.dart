import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class TagThemeData extends ThemeExtension<TagThemeData> {
  final Color? successBackgroundColor;
  final Color? successColor;
  final Icon? successIcon;

  final Color? warningBackgroundColor;
  final Color? warningColor;
  final Icon? warningIcon;

  final Color? errorBackgroundColor;
  final Color? errorColor;
  final Icon? errorIcon;
  final Color? monochromeColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final double? tagWidth;
  final int? maxLine;

  const TagThemeData({
    this.successBackgroundColor,
    this.successColor,
    this.successIcon,
    this.warningBackgroundColor,
    this.warningColor,
    this.warningIcon,
    this.errorBackgroundColor,
    this.errorColor,
    this.errorIcon,
    this.monochromeColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.tagWidth,
    this.maxLine,
  });

  static TagThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return TagThemeData(
      successColor: theme.colorTheme.alert.success,
      warningColor: theme.colorTheme.alert.warning,
      errorColor: theme.colorTheme.alert.error,
      monochromeColor: theme.colorTheme.primary.primary2,
      textStyle: textTheme.bodyS,
      successBackgroundColor: theme.colorTheme.alert.successBg,
      warningBackgroundColor: theme.colorTheme.alert.warningBg,
      errorBackgroundColor: theme.colorTheme.alert.errorBg,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      borderRadius: BorderRadius.circular(4),
      borderWidth: .5,
      successIcon: Icon(
        Icons.check_circle,
        color: theme.colorTheme.alert.success,
        size: 16,
      ),
      warningIcon: Icon(
        Icons.warning,
        color: theme.colorTheme.alert.warning,
        size: 16,
      ),
      errorIcon: Icon(
        Icons.error,
        color: theme.colorTheme.alert.error,
        size: 16,
      ),
      maxLine: 1,
    );
  }

  @override
  TagThemeData copyWith({
    Color? successBackgroundColor,
    Color? successColor,
    Icon? successIcon,
    Color? warningBackgroundColor,
    Color? warningColor,
    Icon? warningIcon,
    Color? errorBackgroundColor,
    Color? errorColor,
    Icon? errorIcon,
    Color? monochromeColor,
    TextStyle? textStyle,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double? borderWidth,
    double? tagWidth,
    int? maxLine,
  }) {
    return TagThemeData(
      successBackgroundColor:
          successBackgroundColor ?? this.successBackgroundColor,
      successColor: successColor ?? this.successColor,
      successIcon: successIcon ?? this.successIcon,
      warningBackgroundColor:
          warningBackgroundColor ?? this.warningBackgroundColor,
      warningColor: warningColor ?? this.warningColor,
      warningIcon: warningIcon ?? this.warningIcon,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      errorColor: errorColor ?? this.errorColor,
      errorIcon: errorIcon ?? this.errorIcon,
      monochromeColor: monochromeColor ?? this.monochromeColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      tagWidth: tagWidth ?? this.tagWidth,
      maxLine: maxLine ?? this.maxLine,
    );
  }

  @override
  TagThemeData lerp(ThemeExtension<TagThemeData>? other, double t) {
    if (other is! TagThemeData) return this;

    return TagThemeData(
      successBackgroundColor:
          Color.lerp(successBackgroundColor, other.successBackgroundColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      successIcon: t < 0.5 ? successIcon : other.successIcon,
      warningBackgroundColor:
          Color.lerp(warningBackgroundColor, other.warningBackgroundColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      warningIcon: t < 0.5 ? warningIcon : other.warningIcon,
      errorBackgroundColor:
          Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      errorIcon: t < 0.5 ? errorIcon : other.errorIcon,
      monochromeColor: Color.lerp(monochromeColor, other.monochromeColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      tagWidth: lerpDouble(tagWidth, other.tagWidth, t),
      maxLine: t < 0.5 ? maxLine : other.maxLine,
    );
  }
}
