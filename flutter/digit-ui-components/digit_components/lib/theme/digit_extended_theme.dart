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
      scaffoldBackgroundColor: const DigitColors().light.genericBackground,
      appBarTheme: const AppBarTheme(elevation: 0),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      dialogTheme: dialogTheme.copyWith(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const DigitColors().light.primary1,
        selectionColor: const DigitColors().light.primary1Bg,
        selectionHandleColor: const DigitColors().transparent,
      ),
      colorScheme: colorScheme,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Roboto',  // Apply the Roboto font to the entire text theme
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
    primary: const DigitColors().light.primary2,
    onPrimary: const DigitColors().light.paperPrimary,
    secondary: const DigitColors().light.primary1,
    onSecondary: const DigitColors().light.paperPrimary,
    error: const DigitColors().light.alertError,
    onError: const DigitColors().light.paperPrimary,
    surface: const DigitColors().light.genericBackground,
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
      dayPeriodColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
            ? const DigitColors().light.primary1
            : const DigitColors().transparent,
      ),
      dayPeriodTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.textPrimary,
      ),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(1)),
        side: BorderSide(color: const DigitColors().light.primary1, width: 1),
      ),
      hourMinuteColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
            ? const DigitColors().light.primary1
            : const DigitColors().transparent,
      ),
      hourMinuteTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
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
      dialTextColor: WidgetStateColor.resolveWith(
            (states) => const DigitColors().light.textPrimary,
      ),
      entryModeIconColor: const DigitColors().light.primary1,
      cancelButtonStyle: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
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
        textStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
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

  EdgeInsets get buttonPadding => const EdgeInsets.symmetric(
    vertical: spacer2,
    horizontal: spacer4,
  );

  EdgeInsets get containerMargin => const EdgeInsets.all(spacer2);

  EdgeInsets get verticalMargin => const EdgeInsets.symmetric(
    vertical: spacer2,
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
      foregroundColor: const DigitColors().light.primary1,
      disabledBackgroundColor: colorScheme.secondary.withOpacity(
        0.5,
      ),
      disabledForegroundColor: colorScheme.onSecondary,
      elevation: 0,
    ),
  );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const DigitColors().light.primary1,
      side: BorderSide(color: colorScheme.secondary),
      padding: buttonPadding,
    ),
  );

  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: buttonBorder,
      padding: buttonPadding,
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
        color: const DigitColors().light.textSecondary,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(
        color: const DigitColors().light.primary1,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(color: const DigitColors().light.textDisabled, width: 1),
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
        color: const DigitColors().light.alertError,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          0,
        ),
      ),
      borderSide: BorderSide(color: const DigitColors().light.alertError, width: 2),
    ),
  );

  DialogTheme get dialogTheme => const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          4,
        ),
      ),
    ),
    actionsPadding: EdgeInsets.all(spacer2),
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
