import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitDividerThemeData extends ThemeExtension<DigitDividerThemeData> {
  final double smallDividerThickness;
  final double mediumDividerThickness;
  final double largeDividerThickness;
  final Color? color;
  final double indent;
  final double endIndent;
  final double? width;
  final double? height;

  const DigitDividerThemeData({
    this.smallDividerThickness = 1,
    this.mediumDividerThickness = 2,
    this.largeDividerThickness = 4,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.width,
    this.height,
  });


  @override
  DigitDividerThemeData copyWith({
    double? smallDividerThickness,
    double? mediumDividerThickness,
    double? largeDividerThickness,
    Color? color,
    double? indent,
    double? endIndent,
    double? width,
    double? height,
  }) {
    return DigitDividerThemeData(
      smallDividerThickness: smallDividerThickness ?? this.smallDividerThickness,
      mediumDividerThickness: mediumDividerThickness ?? this.mediumDividerThickness,
      largeDividerThickness: largeDividerThickness ?? this.largeDividerThickness,
      color: color ?? this.color,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  DigitDividerThemeData lerp(covariant ThemeExtension<DigitDividerThemeData>? other, double t) {
    if (other is! DigitDividerThemeData) return this;

    return DigitDividerThemeData(
      smallDividerThickness: lerpDouble(smallDividerThickness, other.smallDividerThickness, t)!,
      mediumDividerThickness: lerpDouble(mediumDividerThickness, other.mediumDividerThickness, t)!,
      largeDividerThickness: lerpDouble(largeDividerThickness, other.largeDividerThickness, t)!,
      color: Color.lerp(color, other.color, t),
      indent: lerpDouble(indent, other.indent, t) ?? 0.0,
      endIndent: lerpDouble(endIndent, other.endIndent, t) ?? 0.0,
      width: lerpDouble(width, other.width, t),
      height: lerpDouble(height, other.height, t),
    );
  }
}

