library digit_theme;

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/colors.dart';
import 'package:digit_ui_components/theme/typography.dart';
import 'package:digit_ui_components/theme/typography.dart';
import 'package:flutter/material.dart';

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
      elevatedButtonTheme: elevatedDigitButtonTheme,
      outlinedButtonTheme: outlinedDigitButtonTheme,
      textButtonTheme: textDigitButtonTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      dialogTheme: dialogTheme.copyWith(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const DigitColors().light.primary1,
        selectionColor: const DigitColors().light.primary1Bg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      datePickerTheme: DatePickerThemeData(
        headerHeadlineStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto-bold',
        ),
        headerHelpStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto-bold',
        ),
        headerBackgroundColor: const DigitColors().light.paperPrimary,
        headerForegroundColor: const DigitColors().light.textPrimary,
        backgroundColor: const DigitColors().light.paperPrimary,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: const DigitColors().light.paperPrimary,
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          side: BorderSide(
              color: const DigitColors().light.primary1, width: 1),
        ),
        dayPeriodBorderSide: BorderSide(
            color: const DigitColors().light.primary1, width: 1),
        dayPeriodColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.selected)
              ? const DigitColors().light.primary1
              : const DigitColors().transparent,
        ),
        dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.textPrimary),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(1)),
          side: BorderSide(
              color: const DigitColors().light.primary1, width: 1),
        ),
        hourMinuteColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.selected)
              ? const DigitColors().light.primary1
              : const DigitColors().transparent,
        ),
        hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.textPrimary),
        dialHandColor: const DigitColors().light.primary1,
        dialBackgroundColor: const DigitColors().light.primary1Bg,
        hourMinuteTextStyle:
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        dayPeriodTextStyle:
        const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        helpTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto-bold',
            color: const DigitColors().light.textPrimary),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
        ),
        dialTextColor: MaterialStateColor.resolveWith(
              (states) => const DigitColors().light.textPrimary,
        ),
        entryModeIconColor: const DigitColors().light.primary1,
        cancelButtonStyle: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                return TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: const DigitColors().light.primary1,
                );
              }),
        ),
        confirmButtonStyle: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                return TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: const DigitColors().light.primary1,
                );
              }),
        ),
      ),
    );
  }

  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: colors.light.primary1,
    onPrimary: colors.light.paperPrimary,
    secondary: colors.light.primary2,
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

  EdgeInsets get DigitButtonPadding => const EdgeInsets.symmetric(
    vertical: spacer2,
    horizontal: spacer4,
  );

  EdgeInsets get containerMargin => const EdgeInsets.all(spacer2);

  EdgeInsets get verticalMargin => const EdgeInsets.symmetric(
    vertical: spacer2,
  );

  Duration get toastDuration => const Duration(seconds: 2);

  OutlinedBorder get DigitButtonBorder => const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.zero),
  );

  ElevatedButtonThemeData get elevatedDigitButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: DigitButtonBorder,
      padding: DigitButtonPadding,
      backgroundColor: colorScheme.primary,
      foregroundColor: const DigitColors().light.primary1,
      disabledBackgroundColor: colorScheme.secondary.withOpacity(
        0.5,
      ),
      disabledForegroundColor: colorScheme.onSecondary,
      elevation: 0,
    ),
  );

  OutlinedButtonThemeData get outlinedDigitButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const DigitColors().light.primary1,
      side: BorderSide(color: colorScheme.secondary),
      padding: DigitButtonPadding,
    ),
  );

  TextButtonThemeData get textDigitButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: DigitButtonBorder,
      padding: DigitButtonPadding,
      textStyle:  TextStyle(fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 19,
        color: const DigitColors().light.primary1,),
      foregroundColor: const DigitColors().light.primary1,
    ),
  );

  CardTheme get cardTheme => const CardTheme(
    margin: EdgeInsets.fromLTRB(spacer2, spacer4, spacer2, 0),
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
        color: colors.light.primary1,
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
    actionsPadding: const EdgeInsets.all(spacer2),
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