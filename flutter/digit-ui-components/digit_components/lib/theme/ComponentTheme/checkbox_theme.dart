import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitCheckboxThemeData extends ThemeExtension<DigitCheckboxThemeData> {
  final TextStyle? labelTextStyle;
  final TextDirection? labelTextDirection;
  final TextStyle? disabledLabelTextStyle;
  final Color? iconColor;
  final Color? disabledIconColor;
  final double? iconSize;
  final double? borderWidth;
  final double? focusBorderWidth;
  final double? borderRadius;
  final Color? selectedIconColor;
  final EdgeInsetsGeometry? padding;

  const DigitCheckboxThemeData({
    this.labelTextStyle,
    this.disabledLabelTextStyle,
    this.labelTextDirection,
    this.iconColor,
    this.disabledIconColor,
    this.padding,
    this.iconSize,
    this.borderRadius,
    this.borderWidth,
    this.focusBorderWidth,
    this.selectedIconColor,
  });

  static DigitCheckboxThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitCheckboxThemeData(
      labelTextStyle: textTheme.bodyL.copyWith(
        color: theme.colorTheme.text.primary,
        decoration: TextDecoration.none,
      ),
      disabledLabelTextStyle: textTheme.bodyL.copyWith(
        color: theme.colorTheme.text.disabled,
        decoration: TextDecoration.none,
      ),
      selectedIconColor: theme.colorTheme.primary.primary1,
      iconColor: theme.colorTheme.text.primary,
      disabledIconColor: theme.colorTheme.text.disabled,
      padding: EdgeInsets.zero,
      labelTextDirection: TextDirection.ltr,
      iconSize: theme.spacerTheme.spacer6,
      borderRadius: 0,
      borderWidth: 1.0,
      focusBorderWidth: 2.0,
    );
  }

  @override
  DigitCheckboxThemeData copyWith({
    BuildContext? context,
    TextStyle? labelTextStyle,
    TextStyle? disabledLabelTextStyle,
    TextDirection? labelTextDirection,
    Color? iconColor,
    Color? disabledIconColor,
    EdgeInsetsGeometry? padding,
    double? iconSize,
    double? borderRadius,
    double? borderWidth,
    Color? selectedIconColor,
    double? focusBorderWidth,
  }) {

    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme = context != null ? DigitCheckboxThemeData.defaultTheme(context) : null;


    return DigitCheckboxThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle ?? defaultTheme?.labelTextStyle,
      disabledLabelTextStyle: disabledLabelTextStyle ?? this.disabledLabelTextStyle ?? defaultTheme?.disabledLabelTextStyle,
      labelTextDirection: labelTextDirection ?? this.labelTextDirection ?? defaultTheme?.labelTextDirection,
      iconColor: iconColor ?? this.iconColor ?? defaultTheme?.iconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor  ?? defaultTheme?.disabledIconColor,
      padding: padding ?? this.padding ?? defaultTheme?.padding,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor ?? defaultTheme?.selectedIconColor,
      iconSize: iconSize ?? this.iconSize ?? defaultTheme?.iconSize,
      borderRadius: borderRadius ?? this.borderRadius ?? defaultTheme?.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth ?? defaultTheme?.borderWidth,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth ?? defaultTheme?.focusBorderWidth,
    );
  }

  @override
  DigitCheckboxThemeData lerp(covariant ThemeExtension<DigitCheckboxThemeData>? other, double t) {
    if (other is! DigitCheckboxThemeData) return this;

    return DigitCheckboxThemeData(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      disabledLabelTextStyle: TextStyle.lerp(disabledLabelTextStyle, other.disabledLabelTextStyle, t),
      labelTextDirection: t < 0.5 ? labelTextDirection : other.labelTextDirection,
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      disabledIconColor: Color.lerp(disabledIconColor, other.disabledIconColor, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      selectedIconColor: Color.lerp(selectedIconColor, other.selectedIconColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      focusBorderWidth: lerpDouble(focusBorderWidth, other.focusBorderWidth, t),
    );
  }
}
