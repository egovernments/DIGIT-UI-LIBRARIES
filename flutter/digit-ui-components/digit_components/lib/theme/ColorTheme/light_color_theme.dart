import 'package:flutter/material.dart';

class DigitColorTheme extends ThemeExtension<DigitColorTheme> {
  const DigitColorTheme({
    this.alert = const Alert(),
    this.text = const Text(),
    this.paper = const Paper(),
    this.generic = const Generic(),
    this.primary = const Primary(),
  });

  final Alert alert;
  final Text text;
  final Paper paper;
  final Generic generic;
  final Primary primary;

  @override
  DigitColorTheme copyWith({
    Alert? alert,
    Text? text,
    Paper? paper,
    Generic? generic,
    Primary? primary,
  }) {
    return DigitColorTheme(
      alert: alert ?? this.alert,
      text: text ?? this.text,
      paper: paper ?? this.paper,
      generic: generic ?? this.generic,
      primary: primary ?? this.primary,
    );
  }

  @override
  DigitColorTheme lerp(
      covariant ThemeExtension<DigitColorTheme>? other, double t) {
    if (other is! DigitColorTheme) {
      return this;
    }

    return DigitColorTheme(
      alert: Alert.lerp(alert, other.alert, t),
      text: Text.lerp(text, other.text, t),
      paper: Paper.lerp(paper, other.paper, t),
      generic: Generic.lerp(generic, other.generic, t),
      primary: Primary.lerp(primary, other.primary, t),
    );
  }
}

class Alert {
  const Alert({
    this.error = const Color(0xFFB91900),
    this.success = const Color(0xFF00703C),
    this.info = const Color(0xFF0097C3),
    this.warning = const Color(0xFFFFA500),
    this.errorBg = const Color(0xFFFEECEB),
    this.successBg = const Color(0xFFE3F7ED),
    this.infoBg = const Color(0xFFE1F4FB),
    this.warningBg = const Color(0xFFFFF4E5),
  });

  final Color error;
  final Color success;
  final Color info;
  final Color warning;
  final Color errorBg;
  final Color successBg;
  final Color infoBg;
  final Color warningBg;

  Alert copyWith({
    Color? error,
    Color? success,
    Color? info,
    Color? warning,
    Color? errorBg,
    Color? successBg,
    Color? infoBg,
    Color? warningBg,
  }) {
    return Alert(
      error: error ?? this.error,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      errorBg: errorBg ?? this.errorBg,
      successBg: successBg ?? this.successBg,
      infoBg: infoBg ?? this.infoBg,
      warningBg: warningBg ?? this.warningBg,
    );
  }

  static Alert lerp(Alert a, Alert b, double t) {
    return Alert(
      error: Color.lerp(a.error, b.error, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      info: Color.lerp(a.info, b.info, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      errorBg: Color.lerp(a.errorBg, b.errorBg, t)!,
      successBg: Color.lerp(a.successBg, b.successBg, t)!,
      infoBg: Color.lerp(a.infoBg, b.infoBg, t)!,
      warningBg: Color.lerp(a.warningBg, b.warningBg, t)!,
    );
  }
}

class Primary {
  const Primary({
    this.primary1 = const Color(0xFFC84C0E),
    this.primary2 = const Color(0xFF757575),
    this.primaryBg = const Color(0xFFBDBDBD),
  });

  final Color primary1;
  final Color primary2;
  final Color primaryBg;

  Primary copyWith({
    Color? primary1,
    Color? primary2,
    Color? primaryBg,
  }) {
    return Primary(
      primary1: primary1 ?? this.primary1,
      primary2: primary2 ?? this.primary2,
      primaryBg: primaryBg ?? this.primaryBg,
    );
  }

  static Primary lerp(Primary a, Primary b, double t) {
    return Primary(
      primary1: Color.lerp(a.primary1, b.primary1, t)!,
      primary2: Color.lerp(a.primary2, b.primary2, t)!,
      primaryBg: Color.lerp(a.primaryBg, b.primaryBg, t)!,
    );
  }
}

class Text {
  const Text({
    this.primary = const Color(0xFF000000),
    this.secondary = const Color(0xFF757575),
    this.disabled = const Color(0xFFBDBDBD),
  });

  final Color primary;
  final Color secondary;
  final Color disabled;

  Text copyWith({
    Color? primary,
    Color? secondary,
    Color? disabled,
  }) {
    return Text(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      disabled: disabled ?? this.disabled,
    );
  }

  static Text lerp(Text a, Text b, double t) {
    return Text(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
    );
  }
}

class Paper {
  const Paper({
    this.primary = const Color(0xFFFFFFFF),
    this.secondary = const Color(0xFFF5F5F5),
  });

  final Color primary;
  final Color secondary;

  Paper copyWith({
    Color? primary,
    Color? secondary,
  }) {
    return Paper(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  static Paper lerp(Paper a, Paper b, double t) {
    return Paper(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
    );
  }
}

class Generic {
  const Generic({
    this.background = const Color(0xFFFFFFFF),
    this.divider = const Color(0xFFBDBDBD),
    this.inputBorder = const Color(0xFFBDBDBD),
    this.transparent = const Color(0x00000000),
  });

  final Color background;
  final Color divider;
  final Color inputBorder;
  final Color transparent;

  Generic copyWith({
    Color? background,
    Color? divider,
    Color? inputBorder,
    Color? transparent,
  }) {
    return Generic(
      background: background ?? this.background,
      divider: divider ?? this.divider,
      inputBorder: inputBorder ?? this.inputBorder,
      transparent: transparent ?? this.transparent,
    );
  }

  static Generic lerp(Generic a, Generic b, double t) {
    return Generic(
      background: Color.lerp(a.background, b.background, t)!,
      divider: Color.lerp(a.divider, b.divider, t)!,
      inputBorder: Color.lerp(a.inputBorder, b.inputBorder, t)!,
      transparent: Color.lerp(a.transparent, b.transparent, t)!,
    );
  }
}
