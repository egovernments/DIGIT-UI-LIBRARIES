import 'package:flutter/material.dart';

import 'LocalizationDelegate.dart';

// Class responsible for handling attendance localization
class AppLocalization {
  final Locale locale;
  final Future<dynamic> localizedStrings;
  final List<dynamic> languages;

  AppLocalization(this.locale, this.localizedStrings, this.languages);

  // Method to get the current localization instance from context
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(
        context, AppLocalization)!;
  }

  static final List<dynamic> _localizedStrings = <dynamic>[];

  // Method to get the delegate for localization
  static LocalizationsDelegate<AppLocalization> getDelegate(
      Future<dynamic> localizedStrings, List<dynamic> languages) =>
     AppLocalizationDelegate(localizedStrings, languages);

  // Method to load localized strings
  Future<bool> load() async {
    _localizedStrings.clear();
    // Iterate over localized strings and filter based on locale
    for (var element in await localizedStrings) {
      if (element.locale == '${locale.languageCode}_${locale.countryCode}') {
        _localizedStrings.add(element);
      }
    }

    return true;
  }

  // Method to translate a given localized value
  String translate(String localizedValues) {
    if (_localizedStrings.isEmpty) {
      return localizedValues;
    } else {
      final index = _localizedStrings.indexWhere(
            (medium) => medium.code == localizedValues,
      );

      return index != -1 ? _localizedStrings[index].message : localizedValues;
    }
  }
}