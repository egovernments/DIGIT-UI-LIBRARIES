import 'package:flutter/material.dart';

import 'color_theme.dart';

class DigitDarkColorTheme extends DigitColorTheme {
  const DigitDarkColorTheme({
    Alert alert = const Alert(
      error: Color(0xFFCF6C6C), // Darker red for errors
      success: Color(0xFF008A57), // Darker green for success
      info: Color(0xFF0062A0), // Darker blue for info
      warning: Color(0xFFEAA80D), // Darker orange for warnings
      errorBg: Color(0xFF2D2D2D), // Darker background for errors
      successBg: Color(0xFF003C30), // Darker background for success
      infoBg: Color(0xFF002D5F), // Darker background for info
      warningBg: Color(0xFF4D3A00), // Darker background for warnings
    ),
    Dtext text = const Dtext(
      primary: Color(0xFFE0E0E0), // Light gray for primary text
      secondary: Color(0xFFB0B0B0), // Medium gray for secondary text
      disabled: Color(0xFF6F6F6F), // Darker gray for disabled text
    ),
    Paper paper = const Paper(
      primary: Color(0xFF121212), // Dark background for primary paper
      secondary: Color(0xFF1E1E1E), // Slightly lighter dark background for secondary paper
    ),
    Generic generic = const Generic(
      background: Color(0xFF121212), // Dark background
      divider: Color(0xFF444444), // Dark gray for dividers
      inputBorder: Color(0xFFB0B0B0), // Medium gray for input borders
      transparent: Color(0x00000000), // Transparent color remains the same
    ),
    Primary primary = const Primary(
      primary1: Color(0xFF9A3D00), // Darker orange for primary1
      primary2: Color(0xFF00526A), // Darker blue for primary2
      primaryBg: Color(0xFF1A1A1A), // Darker background for primary
    ),
  }) : super(
    alert: alert,
    text: text,
    paper: paper,
    generic: generic,
    primary: primary,
  );

  @override
  DigitDarkColorTheme copyWith({
    Alert? alert,
    Dtext? text,
    Paper? paper,
    Generic? generic,
    Primary? primary,
  }) {
    return DigitDarkColorTheme(
      alert: alert ?? this.alert,
      text: text ?? this.text,
      paper: paper ?? this.paper,
      generic: generic ?? this.generic,
      primary: primary ?? this.primary,
    );
  }

  @override
  DigitDarkColorTheme lerp(
      covariant ThemeExtension<DigitColorTheme>? other, double t) {
    if (other is! DigitDarkColorTheme) {
      return this;
    }

    return DigitDarkColorTheme(
      alert: Alert.lerp(alert, other.alert, t),
      text: Dtext.lerp(text, other.text, t),
      paper: Paper.lerp(paper, other.paper, t),
      generic: Generic.lerp(generic, other.generic, t),
      primary: Primary.lerp(primary, other.primary, t),
    );
  }
}
