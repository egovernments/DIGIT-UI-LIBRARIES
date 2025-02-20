import 'dart:ui';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class DigitDigitActionCardTheme extends ThemeExtension<DigitDigitActionCardTheme> {
  final double? width;
  final double? height;
  final double? spacing;
  final Decoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const DigitDigitActionCardTheme({
    this.width,
    this.height,
    this.spacing,
    this.decoration,
    this.margin,
    this.padding,
  });

  static DigitDigitActionCardTheme defaultTheme(BuildContext context) {
    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    final theme = Theme.of(context);

    return DigitDigitActionCardTheme(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacer1),
        color: theme.colorTheme.paper.primary,
        boxShadow: [
          BoxShadow(
            color: theme.colorTheme.text.primary.withOpacity(.16),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(theme.spacerTheme.spacer6),
      margin: isMobile ? const EdgeInsets.symmetric(horizontal: spacer4) : isTab ? const EdgeInsets.symmetric(horizontal: 100) : const EdgeInsets.symmetric(horizontal: 400),
      spacing: spacer6,
    );
  }

  @override
  DigitDigitActionCardTheme copyWith({
    BuildContext? context,
    double? width,
    double? height,
    double? spacing,
    Decoration? decoration,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme = context != null ? DigitDigitActionCardTheme.defaultTheme(context) : null;



    return DigitDigitActionCardTheme(
      width: width ?? this.width ?? defaultTheme?.width,
      height: height ?? this.height ?? defaultTheme?.height,
      spacing: spacing ?? this.spacing ?? defaultTheme?.spacing,
      decoration: decoration ?? this.decoration ?? defaultTheme?.decoration,
      margin: margin ?? this.margin ?? defaultTheme?.margin,
      padding: padding ?? this.padding ?? defaultTheme?.padding,
    );
  }

  @override
  DigitDigitActionCardTheme lerp(covariant ThemeExtension<DigitDigitActionCardTheme>? other, double t) {
    if (other is! DigitDigitActionCardTheme) return this;

    return DigitDigitActionCardTheme(
      width: lerpDouble(width, other.width, t),
      height: lerpDouble(height, other.height, t),
      spacing: lerpDouble(spacing, other.spacing, t),
      decoration: Decoration.lerp(decoration, other.decoration, t),
      margin: EdgeInsets.lerp(margin, other.margin, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
    );
  }
}