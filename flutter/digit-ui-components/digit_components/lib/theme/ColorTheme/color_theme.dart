import 'package:flutter/material.dart';


class DigitColorTheme extends ThemeExtension<DigitColorTheme> {
  const DigitColorTheme({
    required this.alert,
    required this.text,
    required this.paper,
    required this.generic,
    required this.primary,
  });

  final Alert alert;
  final Dtext text;
  final Paper paper;
  final Generic generic;
  final Primary primary;

  @override
  DigitColorTheme copyWith({
    Alert? alert,
    Dtext? text,
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
      text: Dtext.lerp(text, other.text, t),
      paper: Paper.lerp(paper, other.paper, t),
      generic: Generic.lerp(generic, other.generic, t),
      primary: Primary.lerp(primary, other.primary, t),
    );
  }
}

class Alert {
  const Alert({
    required this.error,
    required this.success,
    required this.info,
    required this.warning,
    required this.errorBg,
    required this.successBg,
    required this.infoBg,
    required this.warningBg,
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
    required this.primary1,
    required this.primary2,
    required this.primaryBg,
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

class Dtext {
  const Dtext({
    required this.primary,
    required this.secondary,
    required this.disabled,
  });

  final Color primary;
  final Color secondary;
  final Color disabled;

  Dtext copyWith({
    Color? primary,
    Color? secondary,
    Color? disabled,
  }) {
    return Dtext(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      disabled: disabled ?? this.disabled,
    );
  }

  static Dtext lerp(Dtext a, Dtext b, double t) {
    return Dtext(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
    );
  }
}

class Paper {
  const Paper({
    required this.primary,
    required this.secondary,
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
    required this.background,
    required this.divider,
    required this.inputBorder,
    required this.transparent,
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
