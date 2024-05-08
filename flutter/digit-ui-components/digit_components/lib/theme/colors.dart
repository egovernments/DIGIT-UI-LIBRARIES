import 'dart:ui';

class DigitColors {
  const DigitColors();

  Light get light => Light();

  Color get transparent => const Color.fromRGBO(0, 0, 0, 0);
  Color get shadowColor => const Color.fromRGBO(244, 119, 56, 0.25);
  Color get darkprimary1 => const Color.fromRGBO(234, 99, 31, 1);
  Color get background => const Color(0xFF6F6F6F);
  Color get overLayColor => const Color(0xFF0B0C0C);
}

class Light {


  /// Primary
  Color get primary1 => const Color(0xFFC84C0E);
  Color get primary1Bg => const Color(0xFFFBEEE8);
  Color get primary2 => const Color(0xFF0B4B66);

  /// Text
  Color get textPrimary => const Color(0xFF363636);
  Color get textSecondary => const Color(0xFF7D7D7D);
  Color get textDisabled => const Color(0xFFC5C5C5);

  /// Paper
  Color get paperPrimary => const Color(0xFFFFFFFF);
  Color get paperSecondary => const Color(0xFFFAFAFA);

  /// Alert
  Color get alertError => const Color(0xFFB91900);
  Color get alertSuccess => const Color(0xFF00703C);
  Color get alertInfo => const Color(0xFF0057BD);
  Color get alertErrorBg => const Color(0xFFFFF5F4);
  Color get alertSuccessBg => const Color(0xFFF1FFF8);
  Color get alertInfoBg => const Color(0xFFDEEFFF);
  Color get alertWarning => const Color(0xFFEA8D00);
  Color get alertWarningBg => const Color(0xFFFFF9F0);

  /// Generic
  Color get genericBackground => const Color(0xFFEEEEEE);
  Color get genericDivider => const Color(0xFFD6D5D4);
  Color get genericInputBorder => const Color(0xFF505A5F);

  /// Header


}

