library digit_theme;

import 'dart:js';

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ColorTheme/dark_color_theme.dart';
import 'package:digit_ui_components/theme/ColorTheme/light_color_theme.dart';
import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/theme/ComponentTheme/chip_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/button_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/desktop_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/mobile_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/tab_text_theme.dart';
import 'package:flutter/material.dart';
import 'ColorTheme/color_theme.dart';
import 'ComponentTheme/action_card_theme.dart';
import 'ComponentTheme/back_button_theme.dart';
import 'SpacerTheme/spacer_theme.dart';
import 'TextTheme/digit_text_theme.dart';

class DigitExtendedTheme {
  static const DigitExtendedTheme _instance = DigitExtendedTheme._internal();

  static DigitExtendedTheme get instance => _instance;

  const DigitExtendedTheme._internal();

  ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(elevation: 0),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const DigitColors().light.primary1,
        selectionColor: const DigitColors().light.primary1Bg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      datePickerTheme: _getDatePickerTheme(),
      timePickerTheme: _getTimePickerTheme(),
      extensions: [
        const DigitColorTheme(alert: Alert(
          error: Color(0xFFB91900),
          success: Color(0xFF00703C),
          info: Color(0xFF0057BD),
          warning: Color(0xFFEA8D00),
          errorBg: Color(0xFFFFF5F4),
          successBg: Color(0xFFF1FFF8),
          infoBg: Color(0xFFDEEFFF),
          warningBg: Color(0xFFFFF9F0),
        ), text: Dtext(
          primary: Color(0xFF363636),
          secondary: Color(0xFF787878),
          disabled: Color(0xFFC5C5C5),
        ),
             paper: Paper(
               primary: Color(0xFFFFFFFF),
               secondary: Color(0xFFFAFAFA),
             ), generic: Generic(
              background: Color(0xFFEEEEEE),
              divider: Color(0xFFD6D5D4),
              inputBorder: Color(0xFF505A5F),
              transparent: Color(0x00000000),
            ), primary: Primary(
            primary1: Color(0xFFC84C0E),
            primary2: Color(0xFF0B4B66),
            primaryBg: Color(0xFFFBEEE8),
          ),)
      ]
    );
  }
  ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(elevation: 0),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const DigitColors().light.primary1,
        selectionColor: const DigitColors().light.primary1Bg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      datePickerTheme: _getDatePickerTheme(),
      timePickerTheme: _getTimePickerTheme(),
      extensions: [
        const DigitColorTheme(
          alert: Alert(
            error: Color(0xFFCF6C6C), // Darker red for errors
            success: Color(0xFF008A57), // Darker green for success
            info: Color(0xFF0062A0), // Darker blue for info
            warning: Color(0xFFEAA80D), // Darker orange for warnings
            errorBg: Color(0xFF2D2D2D), // Darker background for errors
            successBg: Color(0xFF003C30), // Darker background for success
            infoBg: Color(0xFF002D5F), // Darker background for info
            warningBg: Color(0xFF4D3A00), // Darker background for warnings
          ),
          text: Dtext(
            primary: Color(0xFFE0E0E0), // Light gray for primary text
            secondary: Color(0xFFB0B0B0), // Medium gray for secondary text
            disabled: Color(0xFF6F6F6F), // Darker gray for disabled text
          ),
          paper: Paper(
            primary: Color(0xFF121212), // Dark background for primary paper
            secondary: Color(0xFF1E1E1E), // Slightly lighter dark background for secondary paper
          ),
          primary: Primary(
            primary1: Color(0xFF9A3D00), // Darker orange for primary1
            primary2: Color(0xFF00526A), // Darker blue for primary2
            primaryBg: Color(0xFF1A1A1A), // Darker background for primary
          ),
          generic: Generic(
            background: Color(0xFF121212), // Dark background
            divider: Color(0xFF444444), // Dark gray for dividers
            inputBorder: Color(0xFFB0B0B0), // Medium gray for input borders
            transparent: Color(0x00000000), // Transparent color remains the same
          ),
        )
      ]
    );
  }

  DatePickerThemeData _getDatePickerTheme() {
    return DatePickerThemeData(
      headerHeadlineStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      headerHelpStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto-bold',
      ),
      headerBackgroundColor: const DigitColors().light.paperPrimary,
      headerForegroundColor: const DigitColors().light.textPrimary,
      backgroundColor: const DigitColors().light.paperPrimary,
    );
  }

  TimePickerThemeData _getTimePickerTheme() {
    return TimePickerThemeData(
      backgroundColor: const DigitColors().light.paperPrimary,
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        side: BorderSide(color: const DigitColors().light.primary1, width: 1),
      ),
      dayPeriodBorderSide:
      BorderSide(color: const DigitColors().light.primary1, width: 1),
      dayPeriodColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
            ? const DigitColors().light.primary1
            : const DigitColors().transparent,
      ),
      dayPeriodTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.textPrimary,
      ),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(1)),
        side: BorderSide(color: const DigitColors().light.primary1, width: 1),
      ),
      hourMinuteColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
            ? const DigitColors().light.primary1
            : const DigitColors().transparent,
      ),
      hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.textPrimary,
      ),
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
        color: const DigitColors().light.textPrimary,
      ),
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
          },
        ),
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
          },
        ),
      ),
    );
  }
}

/// extension on theme data to access these theme directly
/// Theme.of(context).colorTheme
/// Theme.of(context).textTheme
/// Theme.of(context).spacerTheme

extension DigitThemeExtension on ThemeData {
  DigitColorTheme get colorTheme {
    print('Brightness: $brightness');
    final isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? const DigitDarkColorTheme() : const DigitLightColorTheme();
  }

  DigitSpacerTheme get spacerTheme =>
  extension<DigitSpacerTheme?>() ?? const DigitSpacerTheme();

  DigitButtonTextTheme get digitButtonTextTheme =>
  extension<DigitButtonTextTheme>() ?? const DigitButtonTextTheme();

  DigitTextTheme digitTextTheme(BuildContext context) {
    if (AppView.isMobileView(MediaQuery.of(context).size)) {
      return extension<DigitMobileTextThemeExtension>() ?? const DigitMobileTextThemeExtension();
    } else if (AppView.isTabletView(MediaQuery.of(context).size)) {
      return extension<DigitTabTextThemeExtension>() ?? const DigitTabTextThemeExtension();
    } else {
      return extension<DigitDesktopTextThemeExtension>() ?? const DigitDesktopTextThemeExtension();
    }
  }
}
