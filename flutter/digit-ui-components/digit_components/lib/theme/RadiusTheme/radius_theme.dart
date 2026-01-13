import 'dart:ui';
import 'package:flutter/material.dart';

class DigitRadiusTheme extends ThemeExtension<DigitRadiusTheme> {
  final double radius0;
  final double radius1;
  final double radius2;
  final double radius3;
  final double radius4;

  const DigitRadiusTheme({
    this.radius0 = 0.0,
    this.radius1 = 4.0,
    this.radius2 = 6.0,
    this.radius3 = 8.0,
    this.radius4 = 12.0,
  });

  @override
  DigitRadiusTheme copyWith({
    double? radius0,
    double? radius1,
    double? radius2,
    double? radius3,
    double? radius4,
  }) {
    return DigitRadiusTheme(
      radius0: radius0 ?? this.radius0,
      radius1: radius1 ?? this.radius1,
      radius2: radius2 ?? this.radius2,
      radius3: radius3 ?? this.radius3,
      radius4: radius4 ?? this.radius4,
    );
  }

  @override
  DigitRadiusTheme lerp(covariant ThemeExtension<DigitRadiusTheme>? other, double t) {
    if (other is! DigitRadiusTheme) return this;

    return DigitRadiusTheme(
      radius0: lerpDouble(radius0, other.radius0, t)!,
      radius1: lerpDouble(radius1, other.radius1, t)!,
      radius2: lerpDouble(radius2, other.radius2, t)!,
      radius3: lerpDouble(radius3, other.radius3, t)!,
      radius4: lerpDouble(radius4, other.radius4, t)!,
    );
  }
}
