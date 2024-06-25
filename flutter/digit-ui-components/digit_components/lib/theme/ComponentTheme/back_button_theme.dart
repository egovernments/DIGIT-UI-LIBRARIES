import 'dart:math';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class BackNavigationButtonThemeData extends ThemeExtension<BackNavigationButtonThemeData>{
  final Color? textColor;
  final Color? disabledTextColor;
  final EdgeInsets? contentPadding;
  final Widget? backButtonIcon;
  final Widget? disabledBackButtonIcon;
  final TextStyle? textStyle;

  const BackNavigationButtonThemeData({
    this.textColor,
    this.disabledTextColor,
    this.contentPadding,
    this.backButtonIcon,
    this.disabledBackButtonIcon,
    this.textStyle,
  });

  static BackNavigationButtonThemeData defaultTheme(BuildContext context) {

    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return BackNavigationButtonThemeData(
      textColor: theme.colorTheme.primary.primary1,
      disabledTextColor: theme.colorTheme.text.disabled,
      contentPadding: EdgeInsets.zero,
      textStyle: textTheme.bodyL,
      backButtonIcon: Transform.rotate(
        angle: pi,
        alignment: Alignment.center,
        child: Icon(
          Icons.double_arrow,
          size: isMobile ? theme.spacerTheme.spacer5 : theme.spacerTheme.spacer6,
          color: theme.colorTheme.primary.primary1,
        ),
      ),
      disabledBackButtonIcon: Transform.rotate(
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
  BackNavigationButtonThemeData copyWith({
    Color? textColor,
    Color? disabledTextColor,
    EdgeInsets? contentPadding,
    Widget? backButtonIcon,
    Widget? disabledBackButtonIcon,
    TextStyle? textStyle,

  }) {
    return BackNavigationButtonThemeData(
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      contentPadding: contentPadding ?? this.contentPadding,
      backButtonIcon: backButtonIcon ?? this.backButtonIcon,
      disabledBackButtonIcon: disabledBackButtonIcon ?? this.disabledBackButtonIcon,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  BackNavigationButtonThemeData lerp(covariant ThemeExtension<BackNavigationButtonThemeData>? other, double t) {
    if (other is! BackNavigationButtonThemeData) {
      return this;
    }

    return BackNavigationButtonThemeData(
      textColor: Color.lerp(textColor, other.textColor, t),
      disabledTextColor:
      Color.lerp(disabledTextColor, other.disabledTextColor, t),
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t),
      backButtonIcon: t < 0.5 ? backButtonIcon : other.backButtonIcon,
      disabledBackButtonIcon: t < 0.5 ? disabledBackButtonIcon : other.disabledBackButtonIcon,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }
}
