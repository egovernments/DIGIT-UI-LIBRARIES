import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class DigitChipThemeData extends ThemeExtension<DigitChipThemeData> {
  final TextStyle? labelTextStyle;
  final TextStyle? labelErrorTextStyle;
  final TextStyle? errorTextStyle;
  final Color? backgroundColor;
  final Color? errorBackgroundColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? iconColor;
  final Color? errorIconColor;
  final BoxShadow? errorBoxShadow;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;
  final Icon? cancelIcon;
  final Icon? errorIcon;

  const DigitChipThemeData({
    this.labelTextStyle,
    this.labelErrorTextStyle,
    this.errorTextStyle,
    this.backgroundColor,
    this.errorBackgroundColor,
    this.borderColor,
    this.errorBorderColor,
    this.iconColor,
    this.errorIconColor,
    this.errorBoxShadow,
    this.padding,
    this.borderWidth,
    this.borderRadius,
    this.errorIcon,
    this.cancelIcon,
  });

  static DigitChipThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    return DigitChipThemeData(
      labelTextStyle: textTheme.bodyXS.copyWith(
        color: theme.colorTheme.text.primary,
        overflow: TextOverflow.ellipsis,
      ),
      errorTextStyle: textTheme.headingS.copyWith(
        color: theme.colorTheme.alert.error,
      ),
      labelErrorTextStyle: textTheme.headingXS.copyWith(
        color: theme.colorTheme.alert.error,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: theme.colorTheme.generic.background,
      errorBackgroundColor: theme.colorTheme.paper.primary,
      borderColor: theme.colorTheme.generic.divider,
      errorBorderColor: theme.colorTheme.alert.error,
      iconColor: theme.colorTheme.text.secondary,
      errorIconColor: theme.colorTheme.alert.error,
      padding: EdgeInsets.symmetric(horizontal: theme.spacerTheme.spacer2 ?? 0, vertical: theme.spacerTheme.spacer2 ?? 0),
      errorBoxShadow: BoxShadow(
        color: theme.colorTheme.alert.error
            .withOpacity(.15),
        offset: const Offset(0, 2),
        spreadRadius: 0,
        blurRadius: 4,
      ),
      borderRadius: theme.spacerTheme.spacer1,
      borderWidth: 1.0,
      errorIcon: Icon(
        Icons.info,
        color: theme.colorTheme.alert.error,
        size: theme.spacerTheme.spacer4,
      ),
      cancelIcon: Icon(
        Icons.close,
        size: isDesktop ? theme.spacerTheme.spacer6 : theme.spacerTheme.spacer5,
        color: theme.colorTheme.paper.primary,
      ),
    );
  }

  @override
  DigitChipThemeData copyWith({
    TextStyle? labelTextStyle,
    TextStyle? labelErrorTextStyle,
    TextStyle? errorTextStyle,
    Color? backgroundColor,
    Color? errorBackgroundColor,
    Color? borderColor,
    Color? errorBorderColor,
    Color? iconColor,
    Color? errorIconColor,
    EdgeInsets? padding,
    BoxShadow? errorBoxShadow,
    double? borderRadius,
    double? borderWidth,
  }) {
    return DigitChipThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelErrorTextStyle: labelErrorTextStyle ?? this.labelErrorTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      iconColor: iconColor ?? this.iconColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      padding: padding ?? this.padding,
      errorBoxShadow: errorBoxShadow ?? this.errorBoxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  @override
  DigitChipThemeData lerp(covariant ThemeExtension<DigitChipThemeData>? other, double t) {
    if (other is! DigitChipThemeData) return this;

    return DigitChipThemeData(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      labelErrorTextStyle: TextStyle.lerp(labelErrorTextStyle, other.labelErrorTextStyle, t),
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      errorIconColor: Color.lerp(errorIconColor, other.errorIconColor, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      errorBoxShadow: BoxShadow.lerp(errorBoxShadow, other.errorBoxShadow, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
    );
  }
}
