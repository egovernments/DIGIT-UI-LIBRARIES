import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitInfoCardThemeData extends ThemeExtension<DigitInfoCardThemeData> {
  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;
  final IconData successIcon;
  final IconData errorIcon;
  final IconData warningIcon;
  final IconData infoIcon;
  final double iconSize;
  final Color successColor;
  final Color errorColor;
  final Color warningColor;
  final Color infoColor;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Color successBackgroundColor;
  final Color errorBackgroundColor;
  final Color warningBackgroundColor;
  final Color infoBackgroundColor;
  final EdgeInsets contentPadding;

  const DigitInfoCardThemeData({
    required this.titleTextStyle,
    required this.descriptionTextStyle,
    required this.successColor,
    required this.errorColor,
    required this.warningColor,
    required this.infoColor,
    required this.iconSize,
    required this.successIcon,
    required this.errorIcon,
    required this.warningIcon,
    required this.infoIcon,
    required this.borderWidth,
    required this.borderRadius,
    required this.successBackgroundColor,
    required this.errorBackgroundColor,
    required this.warningBackgroundColor,
    required this.infoBackgroundColor,
    required this.contentPadding,
  });

  static DigitInfoCardThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitInfoCardThemeData(
      titleTextStyle: textTheme.headingS,
      descriptionTextStyle: textTheme.bodyS,
      successColor: theme.colorTheme.alert.success,
      errorColor: theme.colorTheme.alert.error,
      warningColor: theme.colorTheme.alert.warning,
      infoColor: theme.colorTheme.alert.info,
      iconSize: theme.spacerTheme.spacer6,
      successIcon: Icons.check_circle,
      errorIcon: Icons.error,
      infoIcon: Icons.info,
      warningIcon: Icons.warning,
      borderWidth: 1.0,
      borderRadius: BorderRadius.zero,
      successBackgroundColor: theme.colorTheme.alert.successBg,
      errorBackgroundColor: theme.colorTheme.alert.errorBg,
      warningBackgroundColor: theme.colorTheme.alert.warningBg,
      infoBackgroundColor: theme.colorTheme.alert.infoBg,
      contentPadding: EdgeInsets.all(theme.spacerTheme.spacer4),
    );
  }

  @override
  DigitInfoCardThemeData copyWith({
    BuildContext? context,
    TextStyle? titleTextStyle,
    TextStyle? descriptionTextStyle,
    Color? successColor,
    Color? errorColor,
    Color? warningColor,
    Color? infoColor,
    IconData? successIcon,
    IconData? errorIcon,
    IconData? warningIcon,
    IconData? infoIcon,
    double? iconSize,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? successBackgroundColor,
    Color? errorBackgroundColor,
    Color? warningBackgroundColor,
    Color? infoBackgroundColor,
    EdgeInsets? contentPadding,
  }) {

    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme = context != null ? DigitInfoCardThemeData.defaultTheme(context) : null;

    return DigitInfoCardThemeData(
      titleTextStyle: titleTextStyle ?? defaultTheme?.titleTextStyle ?? this.titleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? defaultTheme?.descriptionTextStyle ?? this.descriptionTextStyle,
      successColor: successColor ?? defaultTheme?.successColor ?? this.successColor,
      errorColor: errorColor ?? defaultTheme?.errorColor ?? this.errorColor,
      warningColor: warningColor ?? defaultTheme?.warningColor ?? this.warningColor,
      infoColor: infoColor ?? defaultTheme?.infoColor ?? this.infoColor,
      iconSize: iconSize ?? defaultTheme?.iconSize ?? this.iconSize,
      successIcon: successIcon ?? defaultTheme?.successIcon ?? this.successIcon,
      errorIcon: errorIcon ?? defaultTheme?.errorIcon ??  this.errorIcon,
      warningIcon: warningIcon ?? defaultTheme?.warningIcon ?? this.warningIcon,
      infoIcon: infoIcon ?? defaultTheme?.infoIcon ?? this.infoIcon,
      borderWidth: borderWidth ?? defaultTheme?.borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? defaultTheme?.borderRadius ?? this.borderRadius,
      successBackgroundColor: successBackgroundColor ?? defaultTheme?.successBackgroundColor ?? this.successBackgroundColor,
      errorBackgroundColor: errorBackgroundColor ?? defaultTheme?.errorBackgroundColor ?? this.errorBackgroundColor,
      warningBackgroundColor: warningBackgroundColor ?? defaultTheme?.warningBackgroundColor ?? this.warningBackgroundColor,
      infoBackgroundColor: infoBackgroundColor ?? defaultTheme?.infoBackgroundColor ?? this.infoBackgroundColor,
      contentPadding: contentPadding ?? defaultTheme?.contentPadding ?? this.contentPadding,
    );
  }

  @override
  DigitInfoCardThemeData lerp(covariant ThemeExtension<DigitInfoCardThemeData>? other, double t) {
    if (other is! DigitInfoCardThemeData) return this;

    return DigitInfoCardThemeData(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      descriptionTextStyle: TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
      successIcon: t < 0.5 ? successIcon : other.successIcon,
      errorIcon: t < 0.5 ? errorIcon : other.errorIcon,
      warningIcon: t < 0.5 ? warningIcon : other.warningIcon,
      infoIcon: t < 0.5 ? infoIcon : other.infoIcon,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      successBackgroundColor: Color.lerp(successBackgroundColor, other.successBackgroundColor, t)!,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t)!,
      warningBackgroundColor: Color.lerp(warningBackgroundColor, other.warningBackgroundColor, t)!,
      infoBackgroundColor: Color.lerp(infoBackgroundColor, other.infoBackgroundColor, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
    );
  }
}

