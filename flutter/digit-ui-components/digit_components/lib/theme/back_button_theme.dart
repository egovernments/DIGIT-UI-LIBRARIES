import 'package:digit_ui_components/theme/color_theme_extension.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/text_theme_extension.dart';
import 'package:flutter/material.dart';

class BackNavigationButtonThemeData extends ThemeExtension<BackNavigationButtonThemeData>{
  final Color? iconColor;
  final Color? textColor;
  final Color? disabledIconColor;
  final Color? disabledTextColor;
  final EdgeInsets? contentPadding;
  final IconData? backButtonIcon;
  final TextStyle? textStyle;

  const BackNavigationButtonThemeData({
    this.iconColor,
    this.textColor,
    this.disabledIconColor,
    this.disabledTextColor,
    this.contentPadding,
    this.backButtonIcon,
    this.textStyle,
  });

  static BackNavigationButtonThemeData defaultTheme(BuildContext context) {
    /// Get the theme from the context
    /// Use null-aware operators to safely access properties or provide defaults
    final colorTheme = Theme.of(context).extension<DigitColorsExtension>() ??
        DigitExtendedTheme.instance
            .getTheme(context)
            .extension<DigitColorsExtension>()!;
    final textTheme = Theme.of(context).extension<DigitTextThemeExtension>() ??
        DigitExtendedTheme.instance
            .getTheme(context)
            .extension<DigitTextThemeExtension>()!;

    final Color iconColor = colorTheme.primary.primary1;
    final Color textColor = colorTheme.primary.primary1;
    final Color disabledIconColor = colorTheme.text.disabled;
    final Color disabledTextColor = colorTheme.text.disabled;

    return BackNavigationButtonThemeData(
      iconColor: iconColor,
      textColor: textColor,
      disabledIconColor: disabledIconColor,
      disabledTextColor: disabledTextColor,
      contentPadding: EdgeInsets.zero,
      backButtonIcon: Icons.double_arrow,
      textStyle: textTheme.bodyL,
    );
  }

  @override
  BackNavigationButtonThemeData copyWith({
    Color? iconColor,
    Color? textColor,
    Color? disabledIconColor,
    Color? disabledTextColor,
    EdgeInsets? contentPadding,
    IconData? backButtonIcon,
  }) {
    return BackNavigationButtonThemeData(
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      contentPadding: contentPadding ?? this.contentPadding,
      backButtonIcon: backButtonIcon ?? this.backButtonIcon,
    );
  }

  @override
  BackNavigationButtonThemeData lerp(covariant ThemeExtension<BackNavigationButtonThemeData>? other, double t) {
    if (other is! BackNavigationButtonThemeData) {
      return this;
    }

    return BackNavigationButtonThemeData(
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      disabledIconColor:
          Color.lerp(disabledIconColor, other.disabledIconColor, t)!,
      disabledTextColor:
          Color.lerp(disabledTextColor, other.disabledTextColor, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t),
      backButtonIcon: t < 0.5 ? backButtonIcon : other.backButtonIcon,
    );
  }
}
