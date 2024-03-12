library digit_theme;

import 'package:digit_flutter_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../constants/AppView.dart';

const kPadding = 8.0;

class DigitTheme {
  static const DigitTheme _instance = DigitTheme._internal();

  static DigitTheme get instance => _instance;

  DigitColors get colors => const DigitColors();

  DigitTabTypography get tabTypography => DigitTabTypography(
    normalBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    displayBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    light: colors.lightTextSecondary,
    normal: colors.lightTextPrimary,
  );
  DigitDesktopTypography get desktopTypography => DigitDesktopTypography(
    normalBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    displayBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    light: colors.lightTextSecondary,
    normal: colors.lightTextPrimary,
  );
  DigitMobileTypography get mobileTypography => DigitMobileTypography(
    normalBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    displayBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    light: colors.lightTextSecondary,
    normal: colors.lightTextPrimary,
  );

  const DigitTheme._internal();

  ThemeData get mobileTheme {
    const Border(top: BorderSide());

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: mobileTypography.textTheme,
      appBarTheme: const AppBarTheme(elevation: 0),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      dialogTheme: dialogTheme,
    );
  }
  ThemeData get tabTheme {
    const Border(top: BorderSide());

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: tabTypography.textTheme,
      appBarTheme: const AppBarTheme(elevation: 0),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      dialogTheme: dialogTheme,
    );
  }
  ThemeData get desktopTheme {
    const Border(top: BorderSide());

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: desktopTypography.textTheme,
      appBarTheme: const AppBarTheme(elevation: 0),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      dialogTheme: dialogTheme,
    );
  }

  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: colors.lightPrimaryOrange,
    onPrimary: colors.lightPaperPrimary,
    secondary: colors.lightPrimaryBlueGray,
    onSecondary: colors.lightPaperPrimary,
    error: colors.lightAlertError,
    onError: colors.lightPaperPrimary,
    background: colors.lightPaperPrimary,
    onBackground: colors.lightTextPrimary,
    surface: colors.lightPaperSecondary,
    onSurface: colors.lightTextPrimary,
    onSurfaceVariant: colors.lightAlertSuccess,
    tertiaryContainer: colors.tropicalBlue,
    inversePrimary: colors.lightAlertSuccessBg,
    surfaceTint: colors.waterBlue,
    outline: colors.lightGenericDivider,
    shadow: colors.lightTextSecondary,
    tertiary: colors.paleRose,
    onTertiaryContainer: colors.lightAlertInfoBg,
  );

  EdgeInsets get buttonPadding => const EdgeInsets.symmetric(
    vertical: kPadding,
    horizontal: kPadding * 2,
  );

  EdgeInsets get containerMargin => const EdgeInsets.all(kPadding);

  EdgeInsets get verticalMargin => const EdgeInsets.symmetric(
    vertical: kPadding,
  );



  OutlinedBorder get buttonBorder => const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.zero),
  );

  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: buttonBorder,
      padding: buttonPadding,
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
      disabledBackgroundColor: colorScheme.secondary.withOpacity(
        0.5,
      ),
      disabledForegroundColor: colorScheme.onSecondary,
      elevation: 0,
    ),
  );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colorScheme.secondary,
      side: BorderSide(color: colorScheme.secondary),
      padding: buttonPadding,
    ),
  );

  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: buttonBorder,
      padding: buttonPadding,
      textStyle: const TextStyle(fontSize: 16),
      foregroundColor: colorScheme.secondary,
    ),
  );

  CardTheme get cardTheme => const CardTheme(
    margin: EdgeInsets.fromLTRB(kPadding, kPadding * 2, kPadding, 0),
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
  );

  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(
        color: colors.lightTextSecondary,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(
        color: colors.lightPrimaryOrange,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(color: colors.lightTextDisabled, width: 1),
    ),
    contentPadding: const EdgeInsets.all(12),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(
        color: colors.lightAlertError,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(color: colors.lightAlertError, width: 2),
    ),
  );

  DialogTheme get dialogTheme => DialogTheme(
    titleTextStyle: mobileTypography.headingL,
    contentTextStyle: mobileTypography.bodyL,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          4,
        ),
      ),
    ),
    actionsPadding: const EdgeInsets.all(kPadding),
  );

  BorderSide get tableCellBorder => BorderSide(
    color: colorScheme.outline,
    width: 0.5,
  );

  BorderSide get tableCellStrongBorder => BorderSide(
    color: colorScheme.outline,
    width: 2,
  );
}