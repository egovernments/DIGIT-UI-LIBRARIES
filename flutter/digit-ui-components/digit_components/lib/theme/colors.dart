import 'dart:ui';

class DigitColors {
  const DigitColors();

  Light get light => Light();

  Color get orangeBG  => const Color.fromRGBO(255, 250, 247, 1);
  Color get transparent => const Color.fromRGBO(0, 0, 0, 0);
  Color get shadowColor => const Color.fromRGBO(244, 119, 56, 0.25);
  Color get darkPrimaryOrange => const Color.fromRGBO(234, 99, 31, 1);
}

class Light {
  /// Primary
  Color get primaryOrange => const Color(0xFFF47738);
  Color get primaryBlueGray => const Color(0xFF0B4B66);
  Color get primaryOrangebg => const Color(0xFFFEEFE7);

  /// Text
  Color get textPrimary => const Color(0xFF0B0C0C);
  Color get textSecondary => const Color(0xFF505A5F);
  Color get textDisabled => const Color(0xFFB1B4B6);

  /// Paper
  Color get paperPrimary => const Color(0xFFFFFFFF);
  Color get paperSecondary => const Color(0xFFFAFAFA);

  /// Alert
  Color get alertError => const Color(0xFFD4351C);
  Color get alertSuccess => const Color(0xFF00703C);
  Color get alertInfo => const Color(0xFF1E8FE1);
  Color get alertErrorBg => const Color(0xFFEFC7C1);
  Color get alertSuccessBg => const Color(0xFFBAD6C9);
  Color get alertInfoBg => const Color(0xFF3498DB);
  Color get alertWarning => const Color(0xFFF19100);
  Color get alertWarningBg => const Color(0xFFF8E5C8);

  /// Generic
  Color get genericBackground => const Color(0xFFEEEEEE);
  Color get genericDivider => const Color(0xFFD6D5D4);
  Color get genericInputBorder => const Color(0xFF505A5F);
}

