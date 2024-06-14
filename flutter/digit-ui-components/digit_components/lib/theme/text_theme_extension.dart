import 'package:flutter/material.dart';

class DigitTextThemeExtension extends ThemeExtension<DigitTextThemeExtension> {
  const DigitTextThemeExtension({
    this.headingXl,
    this.headingL,
    this.headingM,
    this.headingS,
    this.headingXS,
    this.captionL,
    this.captionM,
    this.captionS,
    this.bodyL,
    this.bodyS,
    this.bodyXS,
    this.linkL,
    this.linkM,
    this.linkS,
  });

  final TextStyle? headingXl;
  final TextStyle? headingL;
  final TextStyle? headingM;
  final TextStyle? headingS;
  final TextStyle? headingXS;
  final TextStyle? captionL;
  final TextStyle? captionM;
  final TextStyle? captionS;
  final TextStyle? bodyL;
  final TextStyle? bodyS;
  final TextStyle? bodyXS;
  final TextStyle? linkL;
  final TextStyle? linkM;
  final TextStyle? linkS;

  static DigitTextThemeExtension defaultTheme(BuildContext context) {

    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final bool isTab = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;

    return DigitTextThemeExtension(
      headingXl: TextStyle(
        fontSize: isMobile
            ? 32
            : isTab
                ? 36
                : 40,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      headingL: TextStyle(
        fontSize: isMobile
            ? 24
            : isTab
                ? 28
                : 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      headingM: TextStyle(
        fontSize: isMobile
            ? 20
            : isTab
                ? 22
                : 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      headingS: TextStyle(
        fontSize: isMobile
            ? 16
            : isTab
                ? 16
                : 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      headingXS: TextStyle(
        fontSize: isMobile
            ? 12
            : isTab
                ? 14
                : 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      captionL: TextStyle(
        fontSize: isMobile
            ? 24
            : isTab
                ? 28
                : 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      captionM: TextStyle(
        fontSize: isMobile
            ? 20
            : isTab
                ? 24
                : 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      captionS: TextStyle(
        fontSize: isMobile
            ? 16
            : isTab
                ? 20
                : 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      bodyL: TextStyle(
        fontSize: isMobile
            ? 16
            : isTab
                ? 20
                : 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodyS: TextStyle(
        fontSize: isMobile
            ? 14
            : isTab
                ? 16
                : 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodyXS: TextStyle(
        fontSize: isMobile
            ? 12
            : isTab
                ? 14
                : 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      linkL: TextStyle(
        fontSize: isMobile
            ? 16
            : isTab
                ? 20
                : 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      linkM: TextStyle(
        fontSize: isMobile
            ? 14
            : isTab
                ? 16
                : 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      linkS: TextStyle(
        fontSize: isMobile
            ? 12
            : isTab
                ? 14
                : 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
    );
  }

  @override
  ThemeExtension<DigitTextThemeExtension> copyWith({
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
    return DigitTextThemeExtension(
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
  ThemeExtension<DigitTextThemeExtension> lerp(
    covariant ThemeExtension<DigitTextThemeExtension>? other,
    double t,
  ) {
    if (other is! DigitTextThemeExtension) {
      return this;
    }

    return DigitTextThemeExtension(
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
