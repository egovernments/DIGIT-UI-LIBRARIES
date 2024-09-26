library digit_theme;
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ColorTheme/dark_color_theme.dart';
import 'package:digit_ui_components/theme/ColorTheme/light_color_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/desktop_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/mobile_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/tab_text_theme.dart';
import 'package:flutter/material.dart';
import 'ColorTheme/color_theme.dart';
import 'SpacerTheme/spacer_theme.dart';
import 'TextTheme/button_text_theme.dart';
import 'TextTheme/digit_text_theme.dart';

class DigitExtendedTheme {
  static const DigitExtendedTheme _instance = DigitExtendedTheme._internal();

  static DigitExtendedTheme get instance => _instance;

  const DigitExtendedTheme._internal();

  ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      colorScheme: colorScheme,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Roboto',  // Apply the Roboto font to the entire text theme
      ),
      appBarTheme: const AppBarTheme(elevation: 0),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const DigitColors().light.primary1,
        selectionColor: const DigitColors().light.primary1Bg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      datePickerTheme: _getDatePickerTheme(),
      timePickerTheme: _getTimePickerTheme(),

    );
  }
  ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Roboto',  // Apply the Roboto font to the entire text theme
      ),
      appBarTheme: const AppBarTheme(elevation: 0),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const DigitColors().light.primary1,
        selectionColor: const DigitColors().light.primary1Bg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      datePickerTheme: _getDatePickerTheme(),
      timePickerTheme: _getTimePickerTheme(),
    );
  }

  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: const DigitColors().light.primary1,
    onPrimary: const DigitColors().light.paperPrimary,
    secondary: const DigitColors().light.primary2,
    onSecondary: const DigitColors().light.paperPrimary,
    error: const DigitColors().light.alertError,
    onError: const DigitColors().light.paperPrimary,
    background: const DigitColors().light.paperPrimary,
    onBackground: const DigitColors().light.textPrimary,
    surface: const DigitColors().light.paperSecondary,
    onSurface: const DigitColors().light.textPrimary,
    onSurfaceVariant: const DigitColors().light.alertSuccess,
    inversePrimary: const DigitColors().light.alertSuccessBg,
    outline: const DigitColors().light.genericDivider,
    shadow: const DigitColors().light.textSecondary,
    surfaceTint: const DigitColors().light.paperPrimary,
    onTertiaryContainer: const DigitColors().light.alertInfoBg,
  );

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
