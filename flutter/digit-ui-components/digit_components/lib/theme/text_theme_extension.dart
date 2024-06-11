import 'package:flutter/material.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  const AppTextThemeExtension({
    required this.headingXl,
    required this.headingL,
    required this.headingM,
    required this.headingS,
    required this.headingXS,
    required this.captionL,
    required this.captionM,
    required this.captionS,
    required this.bodyL,
    required this.bodyS,
    required this.bodyXS,
    required this.linkL,
    required this.linkM,
    required this.linkS,
  });

  final TextStyle headingXl;
  final TextStyle headingL;
  final TextStyle headingM;
  final TextStyle headingS;
  final TextStyle headingXS;
  final TextStyle captionL;
  final TextStyle captionM;
  final TextStyle captionS;
  final TextStyle bodyL;
  final TextStyle bodyS;
  final TextStyle bodyXS;
  final TextStyle linkL;
  final TextStyle linkM;
  final TextStyle linkS;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? headingXl,
    TextStyle? headingL,
    TextStyle? headingM,
    TextStyle? headingS,
    TextStyle? headingXS,
    TextStyle? captionL,
    TextStyle? captionM,
    TextStyle? captionS,
    TextStyle? bodyL,
    TextStyle? bodyS,
    TextStyle? bodyXS,
    TextStyle? linkL,
    TextStyle? linkM,
    TextStyle? linkS,
  }) {
    return AppTextThemeExtension(
      headingXl: headingXl ?? this.headingXl,
      headingL: headingL ?? this.headingL,
      headingM: headingM ?? this.headingM,
      headingS: headingS ?? this.headingS,
      headingXS: headingXS ?? this.headingXS,
      captionL: captionL ?? this.captionL,
      captionM: captionM ?? this.captionM,
      captionS: captionS ?? this.captionS,
      bodyL: bodyL ?? this.bodyL,
      bodyS: bodyS ?? this.bodyS,
      bodyXS: bodyXS ?? this.bodyXS,
      linkL: linkL ?? this.linkL,
      linkM: linkM ?? this.linkM,
      linkS: linkS ?? this.linkS,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
      covariant ThemeExtension<AppTextThemeExtension>? other,
      double t,
      ) {
    if (other is! AppTextThemeExtension) {
      return this;
    }

    return AppTextThemeExtension(
      headingXl: TextStyle.lerp(headingXl, other.headingXl, t)!,
      headingL: TextStyle.lerp(headingL, other.headingL, t)!,
      headingM: TextStyle.lerp(headingM, other.headingM, t)!,
      headingS: TextStyle.lerp(headingS, other.headingS, t)!,
      headingXS: TextStyle.lerp(headingXS, other.headingXS, t)!,
      captionL: TextStyle.lerp(captionL, other.captionL, t)!,
      captionM: TextStyle.lerp(captionM, other.captionM, t)!,
      captionS: TextStyle.lerp(captionS, other.captionS, t)!,
      bodyL: TextStyle.lerp(bodyL, other.bodyL, t)!,
      bodyS: TextStyle.lerp(bodyS, other.bodyS, t)!,
      bodyXS: TextStyle.lerp(bodyXS, other.bodyXS, t)!,
      linkL: TextStyle.lerp(linkL, other.linkL, t)!,
      linkM: TextStyle.lerp(linkM, other.linkM, t)!,
      linkS: TextStyle.lerp(linkS, other.linkS, t)!,
    );
  }
}