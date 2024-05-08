import 'package:flutter/material.dart';

import 'AppLocalization.dart';


class AppLocalizationDelegate
    extends LocalizationsDelegate<AppLocalization> {
  final Future<dynamic> localizedStrings;
  final List<dynamic> languages;

  const AppLocalizationDelegate(this.localizedStrings, this.languages);

  @override
  bool isSupported(Locale locale) {
    return languages.map((e) {
      final results = e.value.split('_');
      if (results.isNotEmpty) return results.first;
    }).contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization =
    AppLocalization(locale, localizedStrings, languages);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<AppLocalization> old) {
    return true;
  }
}
