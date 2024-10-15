import 'dart:ui';
import 'package:flutter/material.dart';

class DigitSpacerTheme extends ThemeExtension<DigitSpacerTheme> {
  final double spacer1;
  final double spacer2;
  final double spacer3;
  final double spacer4;
  final double spacer5;
  final double spacer6;
  final double spacer7;
  final double spacer8;
  final double spacer9;
  final double spacer10;
  final double spacer11;
  final double spacer12;

  const DigitSpacerTheme({
    this.spacer1 = 4.0,
    this.spacer2 = 8.0,
    this.spacer3 = 12.0,
    this.spacer4 = 16.0,
    this.spacer5 = 20.0,
    this.spacer6 = 24.0,
    this.spacer7 = 28.0,
    this.spacer8 = 32.0,
    this.spacer9 = 36.0,
    this.spacer10 = 40.0,
    this.spacer11 = 44.0,
    this.spacer12 = 48.0,
  });

  @override
  DigitSpacerTheme copyWith({
    double? spacer1,
    double? spacer2,
    double? spacer3,
    double? spacer4,
    double? spacer5,
    double? spacer6,
    double? spacer7,
    double? spacer8,
    double? spacer9,
    double? spacer10,
    double? spacer11,
    double? spacer12,
  }) {
    return DigitSpacerTheme(
      spacer1: spacer1 ?? this.spacer1,
      spacer2: spacer2 ?? this.spacer2,
      spacer3: spacer3 ?? this.spacer3,
      spacer4: spacer4 ?? this.spacer4,
      spacer5: spacer5 ?? this.spacer5,
      spacer6: spacer6 ?? this.spacer6,
      spacer7: spacer7 ?? this.spacer7,
      spacer8: spacer8 ?? this.spacer8,
      spacer9: spacer9 ?? this.spacer9,
      spacer10: spacer10 ?? this.spacer10,
      spacer11: spacer11 ?? this.spacer11,
      spacer12: spacer12 ?? this.spacer12,
    );
  }

  @override
  DigitSpacerTheme lerp(covariant ThemeExtension<DigitSpacerTheme>? other, double t) {
    if (other is! DigitSpacerTheme) return this;

    return DigitSpacerTheme(
      spacer1: lerpDouble(spacer1, other.spacer1, t)!,
      spacer2: lerpDouble(spacer2, other.spacer2, t)!,
      spacer3: lerpDouble(spacer3, other.spacer3, t)!,
      spacer4: lerpDouble(spacer4, other.spacer4, t)!,
      spacer5: lerpDouble(spacer5, other.spacer5, t)!,
      spacer6: lerpDouble(spacer6, other.spacer6, t)!,
      spacer7: lerpDouble(spacer7, other.spacer7, t)!,
      spacer8: lerpDouble(spacer8, other.spacer8, t)!,
      spacer9: lerpDouble(spacer9, other.spacer9, t)!,
      spacer10: lerpDouble(spacer10, other.spacer10, t)!,
      spacer11: lerpDouble(spacer11, other.spacer11, t)!,
      spacer12: lerpDouble(spacer12, other.spacer12, t)!,
    );
  }
}