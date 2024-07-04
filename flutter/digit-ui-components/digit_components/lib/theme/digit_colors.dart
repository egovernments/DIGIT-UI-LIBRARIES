import 'package:flutter/material.dart';

/// DigitColors is abstract because we don’t ever need to instantiate it.
abstract class DigitExtendedColors {
  const DigitExtendedColors();

  static const light = _lightTheme();

  Color get transparent => const Color.fromRGBO(0, 0, 0, 0);
  Color get shadowColor => const Color.fromRGBO(244, 119, 56, 0.25);
  Color get darkPrimary1 => const Color.fromRGBO(234, 99, 31, 1);
  Color get background => const Color(0xFF6F6F6F);
  Color get overLayColor => const Color(0xFF0B0C0C);
}


/// _lightTheme is private because we don’t allow access to it directly but only through the DigitColors.
class _lightTheme {
  const _lightTheme();
  /// Primary
  final primary1 = const Color(0xFFC84C0E);
  final primary1Bg = const Color(0xFFFBEEE8);
  final primary2 = const Color(0xFF0B4B66);

  /// Text
  final textPrimary = const Color(0xFF363636);
  final textSecondary = const Color(0xFF787878);
  final textDisabled = const Color(0xFFC5C5C5);

  /// Paper
  final paperPrimary = const Color(0xFFFFFFFF);
  final paperSecondary = const Color(0xFFFAFAFA);

  /// Alert
  final alertError = const Color(0xFFB91900);
  final alertErrorBg = const Color(0xFFFFF5F4);
  final alertSuccess = const Color(0xFF00703C);
  final alertSuccessBg = const Color(0xFFF1FFF8);
  final alertInfo = const Color(0xFF0057BD);
  final alertInfoBg = const Color(0xFFDEEFFF);
  final alertWarning = const Color(0xFFEA8D00);
  final alertWarningBg = const Color(0xFFFFF9F0);

  /// Generic
  final genericBackground = const Color(0xFFEEEEEE);
  final genericDivider = const Color(0xFFD6D5D4);
  final genericInputBorder = const Color(0xFF505A5F);

/// Header
}