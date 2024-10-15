import 'package:flutter/material.dart';

import 'color_theme.dart';

class DigitLightColorTheme extends DigitColorTheme {
  const DigitLightColorTheme({
    Alert alert = const Alert(
      error: Color(0xFFB91900),
      success: Color(0xFF00703C),
      info: Color(0xFF0057BD),
      warning: Color(0xFFEA8D00),
      errorBg: Color(0xFFFFF5F4),
      successBg: Color(0xFFF1FFF8),
      infoBg: Color(0xFFDEEFFF),
      warningBg: Color(0xFFFFF9F0),
    ),
    Dtext text = const Dtext(
      primary: Color(0xFF363636),
      secondary: Color(0xFF787878),
      disabled: Color(0xFFC5C5C5),
    ),
    Paper paper = const Paper(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFFAFAFA),
    ),
    Generic generic = const Generic(
      background: Color(0xFFEEEEEE),
      divider: Color(0xFFD6D5D4),
      inputBorder: Color(0xFF505A5F),
      transparent: Color(0x00000000),
    ),
    Primary primary = const Primary(
      primary1: Color(0xFFC84C0E),
      primary2: Color(0xFF0B4B66),
      primaryBg: Color(0xFFFBEEE8),
    ),
  }) : super(
          alert: alert,
          text: text,
          paper: paper,
          generic: generic,
          primary: primary,
        );

  @override
  DigitLightColorTheme copyWith({
    Alert? alert,
    Dtext? text,
    Paper? paper,
    Generic? generic,
    Primary? primary,
  }) {
    return DigitLightColorTheme(
      alert: alert ?? this.alert,
      text: text ?? this.text,
      paper: paper ?? this.paper,
      generic: generic ?? this.generic,
      primary: primary ?? this.primary,
    );
  }

  @override
  DigitLightColorTheme lerp(
      covariant ThemeExtension<DigitColorTheme>? other, double t) {
    if (other is! DigitLightColorTheme) {
      return this;
    }

    return DigitLightColorTheme(
      alert: Alert.lerp(alert, other.alert, t),
      text: Dtext.lerp(text, other.text, t),
      paper: Paper.lerp(paper, other.paper, t),
      generic: Generic.lerp(generic, other.generic, t),
      primary: Primary.lerp(primary, other.primary, t),
    );
  }
}
