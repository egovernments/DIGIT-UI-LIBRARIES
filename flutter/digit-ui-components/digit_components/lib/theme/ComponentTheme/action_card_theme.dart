import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

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
    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    final theme = Theme.of(context);

    return DigitActionCardTheme(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.colorTheme.paper.primary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.16),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(theme.spacerTheme.spacer6),
      margin: isMobile ? const EdgeInsets.symmetric(horizontal: 16) : isTab ? const EdgeInsets.symmetric(horizontal: 100) : const EdgeInsets.symmetric(horizontal: 400),
      spacing: 24,
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
    /// Ensure context is provided and get default theme if context is not null
    final defaultTheme = context != null ? DigitActionCardTheme.defaultTheme(context) : null;



    return DigitActionCardTheme(
      width: width ?? this.width ?? defaultTheme?.width,
      height: height ?? this.height ?? defaultTheme?.height,
      spacing: spacing ?? this.spacing ?? defaultTheme?.spacing,
      decoration: decoration ?? this.decoration ?? defaultTheme?.decoration,
      margin: margin ?? this.margin ?? defaultTheme?.margin,
      padding: padding ?? this.padding ?? defaultTheme?.padding,
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
