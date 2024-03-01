import 'package:flutter/material.dart';

import '../constants/AppView.dart';
import 'digit_theme.dart';

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

  /// Follows Digit Typography standards
  ///
  /// <https://design-egov.github.io/ui-docs/foundations/typography>
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
      ),
      headlineLarge: _normal.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      displaySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      bodyLarge: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      bodyMedium: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      bodySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      labelLarge: _normal.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
      labelMedium: _light.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
      labelSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
    );
  }
}
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
      ),
      headlineLarge: _normal.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      displaySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      bodyLarge: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      bodyMedium: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      bodySmall: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      labelLarge: _normal.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
      labelMedium: _light.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
      labelSmall: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
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
      ),
      headlineLarge: _normal.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
      ),
      headlineMedium: _normal.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
      ),
      headlineSmall: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
      ),
      displaySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'Robot-bold',
      ),
      bodyLarge: _normal.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      bodyMedium: _normal.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      bodySmall: _normal.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),
      labelLarge: _normal.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
      labelMedium: _light.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
      ),
      labelSmall: _normal.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto Italic',
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

DigitTypography getTypography(BuildContext context) {
  // Get screen width from MediaQuery
  bool isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);
  bool isTab = AppView.isTabletView(MediaQuery.of(context).size.width);
  bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size.width);

  if (isDesktop) {
    // Desktop
    return DigitTheme.instance.desktopTypography;
  } else if (isTab) {
    // Tablet
    return DigitTheme.instance.tabTypography;
  } else {
    // Mobile
    return DigitTheme.instance.mobileTypography;
  }
}
