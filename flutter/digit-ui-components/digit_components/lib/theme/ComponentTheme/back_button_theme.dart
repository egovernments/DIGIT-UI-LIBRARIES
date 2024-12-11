import 'dart:math';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class DigitBackButtonThemeData extends ThemeExtension<DigitBackButtonThemeData>{
  final Color? textColor;
  final Color? disabledTextColor;
  final EdgeInsets? contentPadding;
  final Widget? backDigitButtonIcon;
  final Widget? disabledBackDigitButtonIcon;
  final TextStyle? textStyle;

  const DigitBackButtonThemeData({
    this.textColor,
    this.disabledTextColor,
    this.contentPadding,
    this.backDigitButtonIcon,
    this.disabledBackDigitButtonIcon,
    this.textStyle,
  });

  static DigitBackButtonThemeData defaultTheme(BuildContext context) {

    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitBackButtonThemeData(
      textColor: theme.colorTheme.primary.primary2,
      disabledTextColor: theme.colorTheme.text.disabled,
      contentPadding: EdgeInsets.zero,
      textStyle: textTheme.bodyL,
      backDigitButtonIcon: Transform.rotate(
        angle: pi,
        alignment: Alignment.center,
        child: Icon(
          Icons.double_arrow,
          size: isMobile ? theme.spacerTheme.spacer5 : theme.spacerTheme.spacer6,
          color: theme.colorTheme.primary.primary2,
        ),
      ),
      disabledBackDigitButtonIcon: Transform.rotate(
        angle: pi,
        alignment: Alignment.center,
        child: Icon(
          Icons.double_arrow,
          size: isMobile ? theme.spacerTheme.spacer5 : theme.spacerTheme.spacer6,
          color: theme.colorTheme.text.disabled,
        ),
      ),
    );
  }

  @override
  DigitBackButtonThemeData copyWith({
    BuildContext? context,
    Color? textColor,
    Color? disabledTextColor,
    EdgeInsets? contentPadding,
    Widget? backDigitButtonIcon,
    Widget? disabledBackDigitButtonIcon,
    TextStyle? textStyle,

  }) {
    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme = context != null ? DigitBackButtonThemeData.defaultTheme(context) : null;

    return DigitBackButtonThemeData(
      textColor: textColor ?? defaultTheme?.textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? defaultTheme?.disabledTextColor ?? this.disabledTextColor,
      contentPadding: contentPadding ?? defaultTheme?.contentPadding ?? this.contentPadding,
      backDigitButtonIcon: backDigitButtonIcon ?? defaultTheme?.backDigitButtonIcon ?? this.backDigitButtonIcon,
      disabledBackDigitButtonIcon: disabledBackDigitButtonIcon ?? defaultTheme?.disabledBackDigitButtonIcon ?? this.disabledBackDigitButtonIcon,
      textStyle: textStyle ?? defaultTheme?.textStyle ?? this.textStyle,
    );
  }

  @override
  DigitBackButtonThemeData lerp(covariant ThemeExtension<DigitBackButtonThemeData>? other, double t) {
    if (other is! DigitBackButtonThemeData) {
      return this;
    }

    return DigitBackButtonThemeData(
      textColor: Color.lerp(textColor, other.textColor, t),
      disabledTextColor:
      Color.lerp(disabledTextColor, other.disabledTextColor, t),
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t),
      backDigitButtonIcon: t < 0.5 ? backDigitButtonIcon : other.backDigitButtonIcon,
      disabledBackDigitButtonIcon: t < 0.5 ? disabledBackDigitButtonIcon : other.disabledBackDigitButtonIcon,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }
}