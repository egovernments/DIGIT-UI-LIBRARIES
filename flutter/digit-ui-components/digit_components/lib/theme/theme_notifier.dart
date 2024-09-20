import 'package:flutter/material.dart';

import 'digit_extended_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  ThemeData loadThemeData(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.dark:
        return DigitExtendedTheme.instance.getDarkTheme();
      case ThemeMode.light:
        return DigitExtendedTheme.instance.getLightTheme();
      default:
      /// Follow system settings or fallback to light theme
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark
            ? DigitExtendedTheme.instance.getDarkTheme()
            : DigitExtendedTheme.instance.getLightTheme();
    }
  }
}
