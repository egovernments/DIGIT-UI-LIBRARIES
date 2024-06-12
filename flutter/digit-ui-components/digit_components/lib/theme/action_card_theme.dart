import 'dart:ui';
import 'package:flutter/material.dart';
import 'colors.dart';

class DigitActionCardTheme extends ThemeExtension<DigitActionCardTheme> {
  final double? width;
  final double? height;
  final double? spacing;
  final Decoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const DigitActionCardTheme({
    this.width,
    this.height,
    this.spacing,
    this.decoration,
    this.margin,
    this.padding,
  });

  static DigitActionCardTheme defaultTheme(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final bool isTab = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;

    return DigitActionCardTheme(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const DigitColors().light.paperPrimary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.16),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile
          ? 16
          : isTab
          ? 20
          : 24),

      width: isMobile ? 328.0 : isTab ? 548.0 : 548.0,
      spacing:isMobile
          ? 16
          : isTab
          ? 20
          : 24,
    );
  }

  @override
  DigitActionCardTheme copyWith({
    BuildContext? context,
    double? width,
    double? height,
    double? spacing,
    Decoration? decoration,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    final defaultTheme = DigitActionCardTheme.defaultTheme(context!);

    return DigitActionCardTheme(
      width: width ?? this.width ?? defaultTheme.width,
      height: height ?? this.height ?? defaultTheme.height,
      spacing: spacing ?? this.spacing ?? defaultTheme.spacing,
      decoration: decoration ?? this.decoration ?? defaultTheme.decoration,
      margin: margin ?? this.margin ?? defaultTheme.margin,
      padding: padding ?? this.padding ?? defaultTheme.padding,
    );
  }

  @override
  DigitActionCardTheme lerp(covariant ThemeExtension<DigitActionCardTheme>? other, double t) {
    if (other is! DigitActionCardTheme) return this;

    return DigitActionCardTheme(
      width: lerpDouble(width, other.width, t),
      height: lerpDouble(height, other.height, t),
      spacing: lerpDouble(spacing, other.spacing, t),
      decoration: Decoration.lerp(decoration, other.decoration, t),
      margin: EdgeInsets.lerp(margin, other.margin, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
    );
  }
}
