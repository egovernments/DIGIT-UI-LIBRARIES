import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitBreadCrumbThemeData extends ThemeExtension<DigitBreadCrumbThemeData> {
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;
  final TextStyle? separatorTextStyle;
  final EdgeInsets? itemPadding;

  const DigitBreadCrumbThemeData({
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.separatorTextStyle,
    this.itemPadding,
  });

  static DigitBreadCrumbThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitBreadCrumbThemeData(
      activeTextStyle: textTheme.bodyS.copyWith(
        color: theme.colorTheme.primary.primary1,
        decoration: TextDecoration.none,
      ),
      inactiveTextStyle: textTheme.bodyS.copyWith(
        color: theme.colorTheme.text.secondary,
        decoration: TextDecoration.none,
      ),
      separatorTextStyle: textTheme.bodyS.copyWith(
        color: theme.colorTheme.text.secondary,
        decoration: TextDecoration.none,
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: theme.spacerTheme.spacer2),
    );
  }

  @override
  DigitBreadCrumbThemeData copyWith({
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    TextStyle? separatorTextStyle,
    EdgeInsets? itemPadding,
  }) {
    return DigitBreadCrumbThemeData(
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
      separatorTextStyle: separatorTextStyle ?? this.separatorTextStyle,
      itemPadding: itemPadding ?? this.itemPadding,
    );
  }

  @override
  DigitBreadCrumbThemeData lerp(covariant ThemeExtension<DigitBreadCrumbThemeData>? other, double t) {
    if (other is! DigitBreadCrumbThemeData) return this;

    return DigitBreadCrumbThemeData(
      activeTextStyle: TextStyle.lerp(activeTextStyle, other.activeTextStyle, t),
      inactiveTextStyle: TextStyle.lerp(inactiveTextStyle, other.inactiveTextStyle, t),
      separatorTextStyle: TextStyle.lerp(separatorTextStyle, other.separatorTextStyle, t),
      itemPadding: EdgeInsets.lerp(itemPadding, other.itemPadding, t),
    );

  }
  String _lerpString(String a, String b, double t) {
    /// Interpolate between two strings `a` and `b` based on `t`
    /// For simplicity, you can directly return one of the strings if `t` is 0 or 1
    return t < 0.5 ? a : b;
  }
}
