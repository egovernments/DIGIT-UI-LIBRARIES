import 'package:flutter/material.dart';

import '../constants/AppView.dart';
import 'digit_theme.dart';

/// Abstract Digit Typography class defining common typography structure

abstract class DigitTypography {
  final Color? _textColorNormal;
  final Color? _textColorLight;
  final TextStyle _normalBase;
  final TextStyle _displayBase;

  const DigitTypography({
    required TextStyle normalBase,
    required TextStyle displayBase,
    Color? normal,
    Color? light,
  })  : _normalBase = normalBase,
        _displayBase = displayBase,
        _textColorLight = light,
        _textColorNormal = normal;

  TextStyle get _normal =>
      _normalBase.copyWith(color: _textColorNormal, fontFamily: 'Roboto');
  TextStyle get _light =>
      _normalBase.copyWith(color: _textColorLight, fontFamily: 'Roboto');
  TextStyle get _big =>
      _displayBase.copyWith(color: _textColorNormal, fontFamily: 'Roboto');
  TextTheme get textTheme;

  /// Heading styles
  TextStyle get headingXl => textTheme.displayMedium!;
  TextStyle get headingL => textTheme.headlineLarge!;
  TextStyle get headingM => textTheme.headlineMedium!;
  TextStyle get headingS => textTheme.headlineSmall!;
  TextStyle get headingXS => textTheme.displaySmall!;

  /// Caption styles
  TextStyle get captionL => textTheme.labelLarge!;
  TextStyle get captionM => textTheme.labelMedium!;
  TextStyle get captionS=> textTheme.labelSmall!;

  /// Body styles
  TextStyle get bodyL => textTheme.bodyLarge!;
  TextStyle get bodyS => textTheme.bodyMedium!;
  TextStyle get bodyXS => textTheme.bodySmall!;


  /// link
  TextStyle get linkL => textTheme.bodyLarge!;
  TextStyle get linkM => textTheme.bodyMedium!;
  TextStyle get linkS => textTheme.bodySmall!;

  /// Miscellaneous styles
  TextStyle get label => textTheme.bodyLarge!;
  TextStyle get link => textTheme.bodyLarge!.copyWith(
    decoration:TextDecoration.underline,
  );
  TextStyle get button => textTheme.labelLarge!.copyWith(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 19,
  );
}

/// Mobile-specific typography class
class DigitMobileTypography extends DigitTypography {
  const DigitMobileTypography({
    required TextStyle normalBase,
    required TextStyle displayBase,
    Color? normal,
    Color? light,
  }) : super(
    normal: normal,
    light: light,
    displayBase: displayBase,
    normalBase: normalBase,
  );

  @override
  TextTheme get textTheme {
    return TextTheme(
      displayMedium: _big.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto Condensed Bold',
        height: 1.14,
      ),
      headlineLarge: _normal.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      displaySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      bodyLarge: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodyMedium: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      labelLarge: _normal.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      labelMedium: _light.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      labelSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
    );
  }
}

/// Tablet-specific typography class
class DigitTabTypography extends DigitTypography {
  const DigitTabTypography({
    required TextStyle normalBase,
    required TextStyle displayBase,
    Color? normal,
    Color? light,
  }) : super(
    normal: normal,
    light: light,
    displayBase: displayBase,
    normalBase: normalBase,
  );

  @override
  TextTheme get textTheme {
    return TextTheme(
      displayMedium: _big.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto Condensed Bold',
        height: 1.14,
      ),
      headlineLarge: _normal.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      displaySmall: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      bodyLarge: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodyMedium: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodySmall: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      labelLarge: _normal.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      labelMedium: _light.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      labelSmall: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
    );
  }
  @override
  TextStyle get link {
    return textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      decoration:TextDecoration.underline,
    );
  }
  @override
  TextStyle get label {
    return textTheme.bodyLarge!.copyWith(
      fontSize: 16,
    );
  }
  @override
  TextStyle get button {
    return textTheme.labelLarge!.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontSize: 19,
    );
  }
}

/// Tablet-specific typography class
class DigitDesktopTypography extends DigitTypography {
  const DigitDesktopTypography({
    required TextStyle normalBase,
    required TextStyle displayBase,
    Color? normal,
    Color? light,
  }) : super(
    normal: normal,
    light: light,
    displayBase: displayBase,
    normalBase: normalBase,
  );

  @override
  TextTheme get textTheme {
    return TextTheme(
      displayMedium: _big.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto Condensed Bold',
        height: 1.14,
      ),
      headlineLarge: _normal.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
        height: 1.14,
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
        height: 1.14,
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
        height: 1.14,
      ),
      displaySmall: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
        height: 1.14,
      ),
      bodyLarge: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodyMedium: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      bodySmall: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        height: 1.37,
      ),
      labelLarge: _normal.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      labelMedium: _light.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
      labelSmall: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        height: 1.14,
      ),
    );
  }
  @override
  TextStyle get link {
    return textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      decoration:TextDecoration.underline,
    );
  }
  @override
  TextStyle get label {
    return textTheme.bodyLarge!.copyWith(
      fontSize: 16,
    );
  }
  @override
  TextStyle get button {
    return textTheme.labelLarge!.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontSize: 19,
    );
  }

}


/// Button-specific typography class
 class ButtonTypography extends DigitTypography{

  const ButtonTypography({
    required TextStyle normalBase,
    required TextStyle displayBase,
    Color? normal,
    Color? light,
  }) : super(
    normal: normal,
    light: light,
    displayBase: displayBase,
    normalBase: normalBase,
  );

  TextStyle get _normal =>
      _normalBase.copyWith(color: _textColorNormal, fontFamily: 'Roboto');
  TextStyle get _light =>
      _normalBase.copyWith(color: _textColorLight, fontFamily: 'Roboto');
  TextStyle get _big =>
      _displayBase.copyWith(color: _textColorNormal, fontFamily: 'Roboto');
  @override
  TextTheme get textTheme {
    return TextTheme(

      headlineLarge: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto-bold',
        height: 1.14,
      ),
    );
  }

  /// Heading styles
  TextStyle get buttonLarge => textTheme.headlineLarge!;
  TextStyle get buttonMedium => textTheme.headlineMedium!;
  TextStyle get buttonSmall => textTheme.headlineSmall!;
}

DigitTypography getTypography(BuildContext context, isButtonTypography) {

  if(isButtonTypography){
    return DigitTheme.instance.buttonTypography;
  }

  if (AppView.isDesktopView(MediaQuery.of(context).size)) {
    /// Desktop
    return DigitTheme.instance.desktopTypography;
  } else if (AppView.isTabletView(MediaQuery.of(context).size)) {
    /// Tablet
    return DigitTheme.instance.tabTypography;
  } else {
    /// else return mobile typography
    return DigitTheme.instance.mobileTypography;
  }
}