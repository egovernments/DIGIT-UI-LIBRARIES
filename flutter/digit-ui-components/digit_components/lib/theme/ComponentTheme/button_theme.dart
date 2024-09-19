import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitButtonThemeData extends ThemeExtension<DigitButtonThemeData> {
  final TextStyle smallDigitButtonTextStyle;
  final TextStyle mediumDigitButtonTextStyle;
  final TextStyle largeDigitButtonTextStyle;
  final TextStyle smallLinkTextStyle;
  final TextStyle mediumLinkTextStyle;
  final TextStyle largeLinkTextStyle;
  final double smallIconSize;
  final double mediumIconSize;
  final double largeIconSize;
  final double smallLinkIconSize;
  final double mediumLinkIconSize;
  final double largeLinkIconSize;
  final double smallDigitButtonHeight;
  final double mediumDigitButtonHeight;
  final double largeDigitButtonHeight;
  final double borderWidth;
  final BorderRadius radius;
  final EdgeInsets padding;
  final EdgeInsets linkPadding;
  final Color hightlightColor;
  final Color splashColor;
  final Color focusColor;
  final Color hoverColor;
  final Color disabledColor;
  final Color primaryDigitButtonColor;
  final Color DigitButtonColor;
  final List<BoxShadow> DigitButtonMouseDownBoxShadow;
  final List<BoxShadow> DigitButtonHoverBoxShadow;
  final List<BoxShadow> primaryDigitButtonMouseDownBoxShadow;
  final List<BoxShadow> primaryDigitButtonHoverBoxShadow;

  const DigitButtonThemeData({
    required this.smallDigitButtonTextStyle,
    required this.mediumDigitButtonTextStyle,
    required this.largeDigitButtonTextStyle,
    required this.smallLinkTextStyle,
    required this.mediumLinkTextStyle,
    required this.largeLinkTextStyle,
    required this.smallIconSize,
    required this.mediumIconSize,
    required this.largeIconSize,
    required this.smallLinkIconSize,
    required this.mediumLinkIconSize,
    required this.largeLinkIconSize,
    required this.smallDigitButtonHeight,
    required this.mediumDigitButtonHeight,
    required this.largeDigitButtonHeight,
    required this.borderWidth,
    required this.radius,
    required this.padding,
    required this.linkPadding,
    required this.hoverColor,
    required this.focusColor,
    required this.hightlightColor,
    required this.splashColor,
    required this.DigitButtonColor,
    required this.disabledColor,
    required this.primaryDigitButtonColor,
    required this.DigitButtonHoverBoxShadow,
    required this.DigitButtonMouseDownBoxShadow,
    required this.primaryDigitButtonHoverBoxShadow,
    required this.primaryDigitButtonMouseDownBoxShadow,
  });

  static defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final DigitButtonTheme = theme.digitButtonTextTheme;

    return DigitButtonThemeData(
      smallDigitButtonTextStyle: DigitButtonTheme.buttonS,
      mediumDigitButtonTextStyle: DigitButtonTheme.buttonM,
      largeDigitButtonTextStyle: DigitButtonTheme.buttonL,
      smallLinkTextStyle: textTheme.linkS,
      mediumLinkTextStyle: textTheme.linkM,
      largeLinkTextStyle: textTheme.linkL,
      smallLinkIconSize: 14.0,
      mediumLinkIconSize: 20.0,
      largeLinkIconSize: 20.0,
      smallIconSize: 14.0,
      mediumIconSize: 20.0,
      largeIconSize: 24.0,
      smallDigitButtonHeight: 24.0,
      mediumDigitButtonHeight: 32.0,
      largeDigitButtonHeight: 40.0,
      borderWidth: 1.0,
      radius: BorderRadius.zero,
      padding: EdgeInsets.symmetric(
          horizontal: theme.spacerTheme.spacer6, vertical: 0),
      linkPadding: const EdgeInsets.all(0),
      hoverColor: theme.colorTheme.generic.transparent,
      focusColor: theme.colorTheme.generic.transparent,
      hightlightColor: theme.colorTheme.generic.transparent,
      splashColor: theme.colorTheme.generic.transparent,
      DigitButtonColor: theme.colorTheme.primary.primary1,
      disabledColor: theme.colorTheme.text.disabled,
      primaryDigitButtonColor: theme.colorTheme.paper.primary,
      DigitButtonHoverBoxShadow: [
        BoxShadow(
          color: theme.colorTheme.primary.primary1,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 0,
        ),
      ],
      DigitButtonMouseDownBoxShadow: [
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
      primaryDigitButtonHoverBoxShadow: [
        BoxShadow(
          color:  theme.colorTheme.text.primary,
          offset: const Offset(0, 2),
          spreadRadius: 0,
          blurRadius: 0,
        ),
      ],
      primaryDigitButtonMouseDownBoxShadow: [
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
    TextStyle? smallDigitButtonTextStyle,
    TextStyle? mediumDigitButtonTextStyle,
    TextStyle? largeDigitButtonTextStyle,
    TextStyle? smallLinkTextStyle,
    TextStyle? mediumLinkTextStyle,
    TextStyle? largeLinkTextStyle,
    double? smallLinkIconSize,
    double? mediumLinkIconSize,
    double? largeLinkIconSize,
    double? smallIconSize,
    double? mediumIconSize,
    double? largeIconSize,
    double? smallDigitButtonHeight,
    double? mediumDigitButtonHeight,
    double? largeDigitButtonHeight,
    double? borderWidth,
    BorderRadius? radius,
    EdgeInsets? padding,
    EdgeInsets? linkPadding,
    Color? hoverColor,
    Color? focusColor,
    Color? hightlightColor,
    Color? splashColor,
    Color? DigitButtonColor,
    Color? disabledColor,
    Color? primaryDigitButtonColor,
    List<BoxShadow>? DigitButtonHoverBoxShadow,
    List<BoxShadow>? DigitButtonMouseDownBoxShadow,
    List<BoxShadow>? primaryDigitButtonHoverBoxShadow,
    List<BoxShadow>? primaryDigitButtonMouseDownBoxShadow,
  }) {
    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme =
        context != null ? DigitButtonThemeData.defaultTheme(context) : null;

    return DigitButtonThemeData(
      smallDigitButtonTextStyle: smallDigitButtonTextStyle ??
          defaultTheme?.smallDigitButtonTextStyle ??
          this.smallDigitButtonTextStyle,
      mediumDigitButtonTextStyle: mediumDigitButtonTextStyle ??
          defaultTheme?.mediumDigitButtonTextStyle ??
          this.mediumDigitButtonTextStyle,
      largeDigitButtonTextStyle: largeDigitButtonTextStyle ??
          defaultTheme?.largeDigitButtonTextStyle ??
          this.largeDigitButtonTextStyle,
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
      smallDigitButtonHeight: smallDigitButtonHeight ??
          defaultTheme?.smallDigitButtonHeight ??
          this.smallDigitButtonHeight,
      mediumDigitButtonHeight: mediumDigitButtonHeight ??
          defaultTheme?.mediumDigitButtonHeight ??
          this.mediumDigitButtonHeight,
      largeDigitButtonHeight: largeDigitButtonHeight ??
          defaultTheme?.largeDigitButtonHeight ??
          this.largeDigitButtonHeight,
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
      DigitButtonColor: DigitButtonColor ?? defaultTheme?.DigitButtonColor ?? this.DigitButtonColor,
      disabledColor:
          disabledColor ?? defaultTheme?.disabledColor ?? this.disabledColor,
      primaryDigitButtonColor: primaryDigitButtonColor ??
          defaultTheme?.primaryDigitButtonColor ??
          this.primaryDigitButtonColor,
      DigitButtonHoverBoxShadow: DigitButtonHoverBoxShadow ??
          defaultTheme?.DigitButtonHoverBoxShadow ??
          this.DigitButtonHoverBoxShadow,
      DigitButtonMouseDownBoxShadow: DigitButtonMouseDownBoxShadow ??
          defaultTheme?.DigitButtonMouseDownBoxShadow ??
          this.DigitButtonMouseDownBoxShadow,
      primaryDigitButtonHoverBoxShadow: primaryDigitButtonHoverBoxShadow ??
          defaultTheme?.primaryDigitButtonHoverBoxShadow ??
          this.primaryDigitButtonHoverBoxShadow,
      primaryDigitButtonMouseDownBoxShadow: primaryDigitButtonMouseDownBoxShadow ??
          defaultTheme?.primaryDigitButtonMouseDownBoxShadow ??
          this.primaryDigitButtonMouseDownBoxShadow,
    );
  }

  @override
  DigitButtonThemeData lerp(
      ThemeExtension<DigitButtonThemeData>? other, double t) {
    if (other is! DigitButtonThemeData) return this;

    return DigitButtonThemeData(
      smallDigitButtonTextStyle:
          TextStyle.lerp(smallDigitButtonTextStyle, other.smallDigitButtonTextStyle, t)!,
      mediumDigitButtonTextStyle: TextStyle.lerp(
          mediumDigitButtonTextStyle, other.mediumDigitButtonTextStyle, t)!,
      largeDigitButtonTextStyle:
          TextStyle.lerp(largeDigitButtonTextStyle, other.largeDigitButtonTextStyle, t)!,
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
      smallDigitButtonHeight:
          lerpDouble(smallDigitButtonHeight, other.smallDigitButtonHeight, t)!,
      mediumDigitButtonHeight:
          lerpDouble(mediumDigitButtonHeight, other.mediumDigitButtonHeight, t)!,
      largeDigitButtonHeight:
          lerpDouble(largeDigitButtonHeight, other.largeDigitButtonHeight, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      radius: BorderRadius.lerp(radius, other.radius, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      linkPadding: EdgeInsets.lerp(linkPadding, other.linkPadding, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      focusColor: Color.lerp(focusColor, other.focusColor, t)!,
      hightlightColor: Color.lerp(hightlightColor, other.hightlightColor, t)!,
      splashColor: Color.lerp(splashColor, other.splashColor, t)!,
      DigitButtonColor: Color.lerp(DigitButtonColor, other.DigitButtonColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      primaryDigitButtonColor:
          Color.lerp(primaryDigitButtonColor, other.primaryDigitButtonColor, t)!,
      DigitButtonHoverBoxShadow:
          t < 0.5 ? DigitButtonHoverBoxShadow : other.DigitButtonHoverBoxShadow,
      DigitButtonMouseDownBoxShadow:
          t < 0.5 ? DigitButtonMouseDownBoxShadow : other.DigitButtonMouseDownBoxShadow,
      primaryDigitButtonHoverBoxShadow: t < 0.5
          ? primaryDigitButtonHoverBoxShadow
          : other.primaryDigitButtonHoverBoxShadow,
      primaryDigitButtonMouseDownBoxShadow: t < 0.5
          ? primaryDigitButtonMouseDownBoxShadow
          : other.primaryDigitButtonMouseDownBoxShadow,
    );
  }
}
