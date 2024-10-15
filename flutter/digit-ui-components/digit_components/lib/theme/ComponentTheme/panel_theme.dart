import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';

class PanelThemeData extends ThemeExtension<PanelThemeData> {
  final TextStyle titleTextStyle;
  final Color successBackgroundColor;
  final Color errorBackgroundColor;
  final BorderRadiusGeometry radiusGeometry;
  final double successAnimationSize;
  final double errorAnimationSize;
  final EdgeInsets successPadding;
  final EdgeInsets errorPadding;
  final double cardWidth;
  final String successJson;
  final String errorJson;

  const PanelThemeData({
    required this.titleTextStyle,
    required this.successBackgroundColor,
    required this.errorBackgroundColor,
    required this.radiusGeometry,
    required this.successAnimationSize,
    required this.errorAnimationSize,
    required this.successPadding,
    required this.errorPadding,
    required this.cardWidth,
    required this.successJson,
    required this.errorJson,
  });

  static PanelThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return PanelThemeData(
      titleTextStyle: textTheme.headingXl.copyWith(color: theme.colorTheme.paper.primary),
      successBackgroundColor: theme.colorTheme.alert.success,
      errorBackgroundColor: theme.colorTheme.alert.error,
      radiusGeometry: isMobile
          ?  BorderRadius.only(
          topLeft: Radius.circular(theme.spacerTheme.spacer1),
          topRight: Radius.circular(theme.spacerTheme.spacer1))
          : BorderRadius.zero,
      successAnimationSize: isMobile ? 80.0 : isTab ? 100.0 : 120.0,
      errorAnimationSize: isMobile ? 56.0 : isTab ? 64.0 : 74.0,
      successPadding: EdgeInsets.only(
          top: isTab || isMobile ? 22 : 18,
          left: theme.spacerTheme.spacer10,
          right: theme.spacerTheme.spacer10,
          bottom: theme.spacerTheme.spacer10,),
      errorPadding: EdgeInsets.all(isMobile ? theme.spacerTheme.spacer8 : theme.spacerTheme.spacer10),
      cardWidth: MediaQuery.of(context).size.width,
      successJson: 'assets/animated_json/success.json',
      errorJson: 'assets/animated_json/error.json',
    );
  }

  @override
  PanelThemeData copyWith({
    BuildContext? context,
    TextStyle? titleTextStyle,
    Color? successBackgroundColor,
    Color? errorBackgroundColor,
    BorderRadiusGeometry? radiusGeometry,
    double? successAnimationSize,
    double? errorAnimationSize,
    EdgeInsets? successPadding,
    EdgeInsets? errorPadding,
    double? cardWidth,
    String? successJson,
    String? errorJson,
  }) {
    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme = context != null ? PanelThemeData.defaultTheme(context) : null;

    return PanelThemeData(
      titleTextStyle: titleTextStyle ?? defaultTheme?.titleTextStyle ?? this.titleTextStyle,
      successBackgroundColor: successBackgroundColor ?? defaultTheme?.successBackgroundColor ?? this.successBackgroundColor,
      errorBackgroundColor: errorBackgroundColor ?? defaultTheme?.errorBackgroundColor ?? this.errorBackgroundColor,
      radiusGeometry: radiusGeometry ?? defaultTheme?.radiusGeometry ?? this.radiusGeometry,
      successAnimationSize: successAnimationSize ?? defaultTheme?.successAnimationSize ?? this.successAnimationSize,
      errorAnimationSize: errorAnimationSize ?? defaultTheme?.errorAnimationSize ?? this.errorAnimationSize,
      successPadding: successPadding ?? defaultTheme?.successPadding ?? this.successPadding,
      errorPadding: errorPadding ?? defaultTheme?.errorPadding ?? this.errorPadding,
      cardWidth: cardWidth ?? defaultTheme?.cardWidth ?? this.cardWidth,
      successJson: successJson ?? defaultTheme?.successJson ?? this.successJson,
      errorJson: errorJson ?? defaultTheme?.errorJson ?? this.errorJson,
    );
  }

  @override
  PanelThemeData lerp(ThemeExtension<PanelThemeData>? other, double t) {
    if (other is! PanelThemeData) return this;

    return PanelThemeData(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      successBackgroundColor: Color.lerp(successBackgroundColor, other.successBackgroundColor, t)!,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t)!,
      radiusGeometry: BorderRadiusGeometry.lerp(radiusGeometry, other.radiusGeometry, t)!,
      successAnimationSize: lerpDouble(successAnimationSize, other.successAnimationSize, t)!,
      errorAnimationSize: lerpDouble(errorAnimationSize, other.errorAnimationSize, t)!,
      successPadding: EdgeInsets.lerp(successPadding, other.successPadding, t)!,
      errorPadding: EdgeInsets.lerp(errorPadding, other.errorPadding, t)!,
      cardWidth: lerpDouble(cardWidth, other.cardWidth, t)!,
      successJson: t< 0.5 ? successJson : other.successJson,
      errorJson: t < 0.5 ? errorJson : other.errorJson,
    );
  }
}
