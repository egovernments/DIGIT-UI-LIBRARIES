import 'package:flutter/material.dart';

abstract class AppTypography {

  /// heading
  static const headingXl = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    height: 1.14,
  );

  static const headingL = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    height: 1.14,
  );
  static const headingM = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    height: 1.14,
  );

  static const headingS = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    height: 1.14,
  );
  static const headingXS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    height: 1.14,
  );

  /// caption
  static const captionL = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    height: 1.14,
  );
  static const captionM = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    height: 1.14,
  );

  static const captionS = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    height: 1.14,
  );

  /// body
  static const bodyL = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    height: 1.37,
  );

  static const bodyS = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    height: 1.37,
  );
  static const bodyXS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    height: 1.37,
  );

  /// link
  static const linkL = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    height: 1.37,
  );
  static const linkM = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    height: 1.37,
  );

  static const linkS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    height: 1.37,
  );
}
