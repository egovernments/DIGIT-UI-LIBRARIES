import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitButtonThemeData extends ThemeExtension<DigitButtonThemeData> {
  final TextStyle smallButtonTextStyle;
  final TextStyle mediumButtonTextStyle;
  final TextStyle largeButtonTextStyle;
  final TextStyle smallLinkTextStyle;
  final TextStyle mediumLinkTextStyle;
  final TextStyle largeLinkTextStyle;
  final double smallIconSize;
  final double mediumIconSize;
  final double largeIconSize;
  final double smallLinkIconSize;
  final double mediumLinkIconSize;
  final double largeLinkIconSize;
  final double smallButtonHeight;
  final double mediumButtonHeight;
  final double largeButtonHeight;
  final double borderWidth;
  final BorderRadius radius;
  final EdgeInsets padding;
  final EdgeInsets linkPadding;
  final Color hightlightColor;
  final Color splashColor;
  final Color focusColor;
  final Color hoverColor;
  final Color disabledColor;
  final Color primaryButtonColor;
  final Color buttonColor;
  final List<BoxShadow> buttonMouseDownBoxShadow;
  final List<BoxShadow> buttonHoverBoxShadow;
  final List<BoxShadow> primaryButtonMouseDownBoxShadow;
  final List<BoxShadow> primaryButtonHoverBoxShadow;

  const DigitButtonThemeData({
    required this.smallButtonTextStyle,
    required this.mediumButtonTextStyle,
    required this.largeButtonTextStyle,
    required this.smallLinkTextStyle,
    required this.mediumLinkTextStyle,
    required this.largeLinkTextStyle,
    required this.smallIconSize,
    required this.mediumIconSize,
    required this.largeIconSize,
    required this.smallLinkIconSize,
    required this.mediumLinkIconSize,
    required this.largeLinkIconSize,
    required this.smallButtonHeight,
    required this.mediumButtonHeight,
    required this.largeButtonHeight,
    required this.borderWidth,
    required this.radius,
    required this.padding,
    required this.linkPadding,
    required this.hoverColor,
    required this.focusColor,
    required this.hightlightColor,
    required this.splashColor,
    required this.buttonColor,
    required this.disabledColor,
    required this.primaryButtonColor,
    required this.buttonHoverBoxShadow,
    required this.buttonMouseDownBoxShadow,
    required this.primaryButtonHoverBoxShadow,
    required this.primaryButtonMouseDownBoxShadow,
  });

  static defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final buttonTheme = theme.digitButtonTextTheme;

    return DigitButtonThemeData(
      smallButtonTextStyle: buttonTheme.buttonS,
      mediumButtonTextStyle: buttonTheme.buttonM,
      largeButtonTextStyle: buttonTheme.buttonL,
      smallLinkTextStyle: textTheme.linkS,
      mediumLinkTextStyle: textTheme.linkM,
      largeLinkTextStyle: textTheme.linkL,
      smallLinkIconSize: 14.0,
      mediumLinkIconSize: 20.0,
      largeLinkIconSize: 30.0,
      smallIconSize: 14.0,
      mediumIconSize: 20.0,
      largeIconSize: 24.0,
      smallButtonHeight: 24.0,
      mediumButtonHeight: 32.0,
      largeButtonHeight: 40.0,
      borderWidth: 1.0,
      radius: BorderRadius.zero,
      padding: EdgeInsets.symmetric(
          horizontal: theme.spacerTheme.spacer6, vertical: 0),
      linkPadding: EdgeInsets.all(theme.spacerTheme.spacer2),
      hoverColor: theme.colorTheme.generic.transparent,
      focusColor: theme.colorTheme.generic.transparent,
      hightlightColor: theme.colorTheme.generic.transparent,
      splashColor: theme.colorTheme.generic.transparent,
      buttonColor: theme.colorTheme.primary.primary1,
      disabledColor: theme.colorTheme.text.disabled,
      primaryButtonColor: theme.colorTheme.paper.primary,
      buttonHoverBoxShadow: [
        BoxShadow(
          color: theme.colorTheme.primary.primary1,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 0,
        ),
      ],
      buttonMouseDownBoxShadow: [
        BoxShadow(
          color: theme.colorTheme.primary.primary1,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 0,
        ),
        BoxShadow(
          color: theme.colorTheme.primary.primary1.withOpacity(.20),
          offset: const Offset(0, 4),
          spreadRadius: 0,
          blurRadius: 4,
        ),
      ],
      primaryButtonHoverBoxShadow: [
        BoxShadow(
          color:  theme.colorTheme.text.primary,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 0,
        ),
      ],
      primaryButtonMouseDownBoxShadow: [
        BoxShadow(
          color: theme.colorTheme.text.primary,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 0,
        ),
        BoxShadow(
          color: theme.colorTheme.text.primary.withOpacity(.25),
          offset: const Offset(0, 4),
          spreadRadius: 0,
          blurRadius:2.8,
        ),
      ],
    );
  }

  @override
  DigitButtonThemeData copyWith({
    BuildContext? context,
    TextStyle? smallButtonTextStyle,
    TextStyle? mediumButtonTextStyle,
    TextStyle? largeButtonTextStyle,
    TextStyle? smallLinkTextStyle,
    TextStyle? mediumLinkTextStyle,
    TextStyle? largeLinkTextStyle,
    double? smallLinkIconSize,
    double? mediumLinkIconSize,
    double? largeLinkIconSize,
    double? smallIconSize,
    double? mediumIconSize,
    double? largeIconSize,
    double? smallButtonHeight,
    double? mediumButtonHeight,
    double? largeButtonHeight,
    double? borderWidth,
    BorderRadius? radius,
    EdgeInsets? padding,
    EdgeInsets? linkPadding,
    Color? hoverColor,
    Color? focusColor,
    Color? hightlightColor,
    Color? splashColor,
    Color? buttonColor,
    Color? disabledColor,
    Color? primaryButtonColor,
    List<BoxShadow>? buttonHoverBoxShadow,
    List<BoxShadow>? buttonMouseDownBoxShadow,
    List<BoxShadow>? primaryButtonHoverBoxShadow,
    List<BoxShadow>? primaryButtonMouseDownBoxShadow,
  }) {
    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme =
        context != null ? DigitButtonThemeData.defaultTheme(context) : null;

    return DigitButtonThemeData(
      smallButtonTextStyle: smallButtonTextStyle ??
          defaultTheme?.smallButtonTextStyle ??
          this.smallButtonTextStyle,
      mediumButtonTextStyle: mediumButtonTextStyle ??
          defaultTheme?.mediumButtonTextStyle ??
          this.mediumButtonTextStyle,
      largeButtonTextStyle: largeButtonTextStyle ??
          defaultTheme?.largeButtonTextStyle ??
          this.largeButtonTextStyle,
      smallLinkTextStyle: smallLinkTextStyle ??
          defaultTheme?.smallLinkTextStyle ??
          this.smallLinkTextStyle,
      mediumLinkTextStyle: mediumLinkTextStyle ??
          defaultTheme?.mediumLinkTextStyle ??
          this.mediumLinkTextStyle,
      largeLinkTextStyle: largeLinkTextStyle ??
          defaultTheme?.largeLinkTextStyle ??
          this.largeLinkTextStyle,
      smallIconSize:
          smallIconSize ?? defaultTheme?.smallIconSize ?? this.smallIconSize,
      mediumIconSize:
          mediumIconSize ?? defaultTheme?.mediumIconSize ?? this.mediumIconSize,
      largeIconSize:
          largeIconSize ?? defaultTheme?.largeIconSize ?? this.largeIconSize,
      smallLinkIconSize: smallLinkIconSize ??
          defaultTheme?.smallLinkIconSize ??
          this.smallLinkIconSize,
      mediumLinkIconSize: mediumLinkIconSize ??
          defaultTheme?.mediumLinkIconSize ??
          this.mediumLinkIconSize,
      largeLinkIconSize: largeLinkIconSize ??
          defaultTheme?.largeLinkIconSize ??
          this.largeLinkIconSize,
      smallButtonHeight: smallButtonHeight ??
          defaultTheme?.smallButtonHeight ??
          this.smallButtonHeight,
      mediumButtonHeight: mediumButtonHeight ??
          defaultTheme?.mediumButtonHeight ??
          this.mediumButtonHeight,
      largeButtonHeight: largeButtonHeight ??
          defaultTheme?.largeButtonHeight ??
          this.largeButtonHeight,
      borderWidth: borderWidth ?? defaultTheme?.borderWidth ?? this.borderWidth,
      radius: radius ?? defaultTheme?.radius ?? this.radius,
      padding: padding ?? defaultTheme?.padding ?? this.padding,
      linkPadding: linkPadding ?? defaultTheme?.linkPadding ?? this.linkPadding,
      hoverColor: hoverColor ?? defaultTheme?.hoverColor ?? this.hoverColor,
      focusColor: focusColor ?? defaultTheme?.focusColor ?? this.focusColor,
      hightlightColor: hightlightColor ??
          defaultTheme?.hightlightColor ??
          this.hightlightColor,
      splashColor: splashColor ?? defaultTheme?.splashColor ?? this.splashColor,
      buttonColor: buttonColor ?? defaultTheme?.buttonColor ?? this.buttonColor,
      disabledColor:
          disabledColor ?? defaultTheme?.disabledColor ?? this.disabledColor,
      primaryButtonColor: primaryButtonColor ??
          defaultTheme?.primaryButtonColor ??
          this.primaryButtonColor,
      buttonHoverBoxShadow: buttonHoverBoxShadow ??
          defaultTheme?.buttonHoverBoxShadow ??
          this.buttonHoverBoxShadow,
      buttonMouseDownBoxShadow: buttonMouseDownBoxShadow ??
          defaultTheme?.buttonMouseDownBoxShadow ??
          this.buttonMouseDownBoxShadow,
      primaryButtonHoverBoxShadow: primaryButtonHoverBoxShadow ??
          defaultTheme?.primaryButtonHoverBoxShadow ??
          this.primaryButtonHoverBoxShadow,
      primaryButtonMouseDownBoxShadow: primaryButtonMouseDownBoxShadow ??
          defaultTheme?.primaryButtonMouseDownBoxShadow ??
          this.primaryButtonMouseDownBoxShadow,
    );
  }

  @override
  DigitButtonThemeData lerp(
      ThemeExtension<DigitButtonThemeData>? other, double t) {
    if (other is! DigitButtonThemeData) return this;

    return DigitButtonThemeData(
      smallButtonTextStyle:
          TextStyle.lerp(smallButtonTextStyle, other.smallButtonTextStyle, t)!,
      mediumButtonTextStyle: TextStyle.lerp(
          mediumButtonTextStyle, other.mediumButtonTextStyle, t)!,
      largeButtonTextStyle:
          TextStyle.lerp(largeButtonTextStyle, other.largeButtonTextStyle, t)!,
      smallLinkTextStyle:
          TextStyle.lerp(smallLinkTextStyle, other.smallLinkTextStyle, t)!,
      mediumLinkTextStyle:
          TextStyle.lerp(mediumLinkTextStyle, other.mediumLinkTextStyle, t)!,
      largeLinkTextStyle:
          TextStyle.lerp(largeLinkTextStyle, other.largeLinkTextStyle, t)!,
      smallIconSize: lerpDouble(smallIconSize, other.smallIconSize, t)!,
      mediumIconSize: lerpDouble(mediumIconSize, other.mediumIconSize, t)!,
      largeIconSize: lerpDouble(largeIconSize, other.largeIconSize, t)!,
      smallLinkIconSize:
          lerpDouble(smallLinkIconSize, other.smallLinkIconSize, t)!,
      mediumLinkIconSize:
          lerpDouble(mediumLinkIconSize, other.mediumLinkIconSize, t)!,
      largeLinkIconSize:
          lerpDouble(largeLinkIconSize, other.largeLinkIconSize, t)!,
      smallButtonHeight:
          lerpDouble(smallButtonHeight, other.smallButtonHeight, t)!,
      mediumButtonHeight:
          lerpDouble(mediumButtonHeight, other.mediumButtonHeight, t)!,
      largeButtonHeight:
          lerpDouble(largeButtonHeight, other.largeButtonHeight, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      radius: BorderRadius.lerp(radius, other.radius, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      linkPadding: EdgeInsets.lerp(linkPadding, other.linkPadding, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      focusColor: Color.lerp(focusColor, other.focusColor, t)!,
      hightlightColor: Color.lerp(hightlightColor, other.hightlightColor, t)!,
      splashColor: Color.lerp(splashColor, other.splashColor, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      primaryButtonColor:
          Color.lerp(primaryButtonColor, other.primaryButtonColor, t)!,
      buttonHoverBoxShadow:
          t < 0.5 ? buttonHoverBoxShadow : other.buttonHoverBoxShadow,
      buttonMouseDownBoxShadow:
          t < 0.5 ? buttonMouseDownBoxShadow : other.buttonMouseDownBoxShadow,
      primaryButtonHoverBoxShadow: t < 0.5
          ? primaryButtonHoverBoxShadow
          : other.primaryButtonHoverBoxShadow,
      primaryButtonMouseDownBoxShadow: t < 0.5
          ? primaryButtonMouseDownBoxShadow
          : other.primaryButtonMouseDownBoxShadow,
    );
  }
}
