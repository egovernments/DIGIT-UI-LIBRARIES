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
    if (_themeMode == ThemeMode.dark) {
      return DigitExtendedTheme.instance.getDarkTheme();
    } else if (_themeMode == ThemeMode.light) {
      return DigitExtendedTheme.instance.getLightTheme();
    } else {
      /// Follow system settings or fallback to light theme
      final brightness = MediaQuery.of(context).platformBrightness;
      if (brightness == Brightness.dark) {
        return DigitExtendedTheme.instance.getDarkTheme(
        );
      } else {
        return DigitExtendedTheme.instance.getLightTheme();
      }
    }
  }
}
