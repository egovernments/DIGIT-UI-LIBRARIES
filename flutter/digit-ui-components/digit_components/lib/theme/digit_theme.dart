library digit_theme;

import 'package:digit_ui_components/theme/colors.dart';
import 'package:digit_ui_components/theme/typography.dart';
import 'package:flutter/material.dart';

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
    light: colors.light.textSecondary,
    normal: colors.light.textPrimary,
  );
  DigitDesktopTypography get desktopTypography => DigitDesktopTypography(
    normalBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    displayBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    light: colors.light.textSecondary,
    normal: colors.light.textPrimary,
  );
  DigitMobileTypography get mobileTypography => DigitMobileTypography(
    normalBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    displayBase: const TextStyle(
      fontFamily: 'Roboto',
    ),
    light: colors.light.textSecondary,
    normal: colors.light.textPrimary,
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
      textSelectionTheme:  TextSelectionThemeData(
        cursorColor: const DigitColors().light.primaryOrange,
        selectionColor: const DigitColors().light.primaryOrangeBg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      datePickerTheme:  DatePickerThemeData(
        headerHeadlineStyle: const TextStyle(fontFamily:'Roboto', fontSize: 16,),
        headerHelpStyle: const TextStyle(fontFamily:'Roboto', fontSize: 16,),
        headerBackgroundColor: const DigitColors().light.paperPrimary,
        headerForegroundColor: const DigitColors().light.textPrimary,
        backgroundColor: const DigitColors().light.paperPrimary,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: const DigitColors().light.paperPrimary,
        hourMinuteShape:  RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: const DigitColors().light.primaryOrange, width: 1),
        ),
        dayPeriodBorderSide:  BorderSide(color: const DigitColors().light.primaryOrange, width: 1),
        dayPeriodColor: const DigitColors().light.paperPrimary,
        shape:  RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: const DigitColors().light.primaryOrange, width: 1),
        ),
        dayPeriodTextColor: const DigitColors().light.textPrimary,
        dayPeriodShape:  RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(1)),
          side: BorderSide(color: const DigitColors().light.primaryOrange, width: 1),
        ),
        hourMinuteColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? const DigitColors().light.primaryOrangeBg : const DigitColors().transparent,),
        hourMinuteTextColor: MaterialStateColor.resolveWith(
                (states) => const DigitColors().light.textPrimary),
        dialHandColor: const DigitColors().light.primaryOrange,
        dialBackgroundColor: const DigitColors().light.primaryOrangeBg,
        hourMinuteTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        dayPeriodTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        helpTextStyle:
         TextStyle(fontSize: 16,fontFamily: 'Roboto', color: const DigitColors().light.textPrimary),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
        ),
        dialTextColor: MaterialStateColor.resolveWith(
                (states) => const DigitColors().light.textPrimary,),
        entryModeIconColor: const DigitColors().light.primaryOrange,

      ),
    );
  }

  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: colors.light.primaryOrange,
    onPrimary: colors.light.paperPrimary,
    secondary: colors.light.primaryBlueGray,
    onSecondary: colors.light.paperPrimary,
    error: colors.light.alertError,
    onError: colors.light.paperPrimary,
    background: colors.light.paperPrimary,
    onBackground: colors.light.textPrimary,
    surface: colors.light.paperSecondary,
    onSurface: colors.light.textPrimary,
    onSurfaceVariant: colors.light.alertSuccess,
    inversePrimary: colors.light.alertSuccessBg,
    outline: colors.light.genericDivider,
    shadow: colors.light.textSecondary,
    surfaceTint: colors.light.paperPrimary,
    onTertiaryContainer: colors.light.alertInfoBg,

  );

  EdgeInsets get buttonPadding => const EdgeInsets.symmetric(
    vertical: kPadding,
    horizontal: kPadding * 2,
  );

  EdgeInsets get containerMargin => const EdgeInsets.all(kPadding);

  EdgeInsets get verticalMargin => const EdgeInsets.symmetric(
    vertical: kPadding,
  );

  Duration get toastDuration => const Duration(seconds: 2);

  OutlinedBorder get buttonBorder => const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.zero),
  );

  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: buttonBorder,
      padding: buttonPadding,
      backgroundColor: colorScheme.primary,
      foregroundColor: const DigitColors().light.textSecondary,
      disabledBackgroundColor: colorScheme.secondary.withOpacity(
        0.5,
      ),
      disabledForegroundColor: colorScheme.onSecondary,
      elevation: 0,
    ),
  );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const DigitColors().light.textSecondary,
      side: BorderSide(color: colorScheme.secondary),
      padding: buttonPadding,
    ),
  );

  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: buttonBorder,
      padding: buttonPadding,
      textStyle: const TextStyle(fontSize: 16, fontFamily: 'Roboto'),
      foregroundColor: const DigitColors().light.textSecondary,
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
        color: colors.light.textSecondary,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(
        color: colors.light.primaryOrange,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(color: colors.light.textDisabled, width: 1),
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
        color: colors.light.alertError,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(color: colors.light.alertError, width: 2),
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