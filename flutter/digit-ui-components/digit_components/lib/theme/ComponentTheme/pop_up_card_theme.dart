import 'dart:ui';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class DigitPopupTheme extends ThemeExtension<DigitPopupTheme> {
  final double? width;
  final double? height;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final String? alertAnimation;
  final TextStyle? titleTextStyle;
  final TextStyle? subHeadingTextStyle;
  final TextStyle? descriptionTextStyle;
  final double? iconSize;

  const DigitPopupTheme({
     this.width,
    this.height,
     this.decoration,
     this.padding,
     this.titleTextStyle,
     this.subHeadingTextStyle,
     this.descriptionTextStyle,
     this.iconSize,
    this.alertAnimation,
  });

  static DigitPopupTheme defaultTheme(BuildContext context) {
    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitPopupTheme(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.spacerTheme.spacer1),
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
      padding: EdgeInsets.all(isMobile ? 16 : isTab ? 20 : 24),
      width: isMobile ? 328.0 : isTab ? 500 : 620.0,
      titleTextStyle: textTheme.headingL.copyWith(
          color: theme.colorTheme.text.primary),
      subHeadingTextStyle: textTheme.captionS.copyWith(
          color: theme.colorTheme.text.primary),
      descriptionTextStyle: textTheme.bodyS.copyWith(
        color: theme.colorTheme.text.primary,
      ),
      iconSize: isMobile ? 24.0 : isTab ? 28.0 : 32.0,
      alertAnimation: 'assets/animated_json/alert.json',
    );
  }

  @override
  DigitPopupTheme copyWith({
    BuildContext? context,
    double? width,
    double? height,
    Decoration? decoration,
    EdgeInsets? padding,
    TextStyle? titleTextStyle,
    TextStyle? subHeadingTextStyle,
    TextStyle? descriptionTextStyle,
    double? iconSize,
    String? alertAnimation,
  }) {
    final defaultTheme = context != null ? DigitPopupTheme.defaultTheme(context) : null;

    return DigitPopupTheme(
      width: width ?? defaultTheme?.width ?? this.width,
      height: height ?? defaultTheme?.height ?? this.height,
      decoration: decoration ?? defaultTheme?.decoration ?? this.decoration,
      padding: padding ?? defaultTheme?.padding ?? this.padding,
      titleTextStyle: titleTextStyle ?? defaultTheme?.titleTextStyle ?? this.titleTextStyle,
      subHeadingTextStyle: subHeadingTextStyle ?? defaultTheme?.subHeadingTextStyle ?? this.subHeadingTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? defaultTheme?.descriptionTextStyle ?? this.descriptionTextStyle,
      iconSize: iconSize ?? defaultTheme?.iconSize ?? this.iconSize,
      alertAnimation: alertAnimation ?? defaultTheme?.alertAnimation ?? this.alertAnimation,
    );
  }

  @override
  DigitPopupTheme lerp(covariant ThemeExtension<DigitPopupTheme>? other, double t) {
    if (other is! DigitPopupTheme) return this;

    return DigitPopupTheme(
      width: lerpDouble(width, other.width, t)!,
      height: lerpDouble(height, other.height, t),
      decoration: Decoration.lerp(decoration, other.decoration, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subHeadingTextStyle: TextStyle.lerp(subHeadingTextStyle, other.subHeadingTextStyle, t)!,
      descriptionTextStyle: TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t)!,
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
      alertAnimation: t<0.5 ? alertAnimation : other.alertAnimation,
    );
  }
}
