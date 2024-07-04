import 'package:flutter/material.dart';

class DigitButtonTextTheme extends ThemeExtension<DigitButtonTextTheme> {
  final TextStyle buttonL;
  final TextStyle buttonM;
  final TextStyle buttonS;

  const DigitButtonTextTheme({
    this.buttonL = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto-bold',
      height: 1.14,
    ),
    this.buttonM = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto-bold',
      height: 1.14,
    ),
    this.buttonS = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto-bold',
      height: 1.14,
    ),
  });

  @override
  DigitButtonTextTheme copyWith({
    TextStyle? buttonL,
    TextStyle? buttonM,
    TextStyle? buttonS,
  }) {
    return DigitButtonTextTheme(
      buttonL: buttonL ?? this.buttonL,
      buttonM: buttonM ?? this.buttonM,
      buttonS: buttonS ?? this.buttonS,
    );
  }

  @override
  DigitButtonTextTheme lerp(ThemeExtension<DigitButtonTextTheme>? other, double t) {
    if (other is! DigitButtonTextTheme) {
      return this;
    }
    return DigitButtonTextTheme(
      buttonL: TextStyle.lerp(buttonL, other.buttonL, t)!,
      buttonM: TextStyle.lerp(buttonM, other.buttonM, t)!,
      buttonS: TextStyle.lerp(buttonS, other.buttonS, t)!,

    );
  }
}
