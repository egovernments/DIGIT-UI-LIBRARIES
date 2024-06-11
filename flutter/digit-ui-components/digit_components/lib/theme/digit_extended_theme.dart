library digit_extended_theme;

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_colors.dart';
import 'package:digit_ui_components/theme/text_theme_extension.dart';
import 'package:flutter/material.dart';

class DigitExtendedTheme {

  static const DigitExtendedTheme _instance = DigitExtendedTheme._internal();

  static DigitExtendedTheme get instance => _instance;

  DigitTabTypography get tabTypography =>
      const DigitTabTypography(
        normalBase: TextStyle(
          fontFamily: 'Roboto',
        ),
        displayBase: TextStyle(
          fontFamily: 'Roboto',
        ),

      );

  ButtonTypography get buttonTypography =>
      const ButtonTypography(
        normalBase: TextStyle(
          fontFamily: 'Roboto',
        ),
        displayBase: TextStyle(
          fontFamily: 'Roboto',
        ),
      );


  DigitDesktopTypography get desktopTypography =>
      const DigitDesktopTypography(
        normalBase: TextStyle(
          fontFamily: 'Roboto',
        ),
        displayBase: TextStyle(
          fontFamily: 'Roboto',
        ),
      );

  DigitMobileTypography get mobileTypography =>
      const DigitMobileTypography(
        normalBase: TextStyle(
          fontFamily: 'Roboto',
        ),
        displayBase: TextStyle(
          fontFamily: 'Roboto',
        ),
      );

  const DigitExtendedTheme._internal();

  ThemeData get mobileTheme {
    const Border(top: BorderSide());
    return ThemeData(
      extensions: [
        AppTextThemeExtension(
            headingXl:mobileTypography.headingXl,
            headingL:mobileTypography.headingL,
            headingM:mobileTypography.headingM,
            headingS:mobileTypography.headingS,
            headingXS: mobileTypography.headingXS,
            captionL: mobileTypography.captionL,
            captionM: mobileTypography.captionM,
            captionS: mobileTypography.captionS,
            bodyL: mobileTypography.bodyL,
            bodyS: mobileTypography.bodyS,
            bodyXS: mobileTypography.bodyXS,
            linkL: mobileTypography.linkL,
            linkM: mobileTypography.linkM,
            linkS: mobileTypography.linkS,
        ),
      ],
      appBarTheme: const AppBarTheme(elevation: 0),
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
              (states) =>
          states.contains(MaterialState.selected)
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
              (states) =>
          states.contains(MaterialState.selected)
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


}