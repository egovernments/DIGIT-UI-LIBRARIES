import 'package:flutter/material.dart';

import 'component_localization_delegate.dart';

// Class responsible for handling attendance localization
class ComponentLocalization {
  final Locale locale;
  final Future<dynamic> localizedStrings;
  final List<dynamic> languages;

  ComponentLocalization(this.locale, this.localizedStrings, this.languages);

  // Method to get the current localization instance from context
  static ComponentLocalization of(BuildContext context) {
    return Localizations.of<ComponentLocalization>(context, ComponentLocalization)!;
  }

  static final List<dynamic> _localizedStrings = <dynamic>[];

  // Method to get the delegate for localization
  static LocalizationsDelegate<ComponentLocalization> getDelegate(
      Future<dynamic> localizedStrings, List<dynamic> languages) =>
      ComponentLocalizationDelegate(localizedStrings, languages);

  // Method to load localized strings
  Future<bool> load() async {
    _localizedStrings.clear();

        _localizedStrings.add(localizedStrings);


    return true;
  }

  // Method to translate a given localized value
  String translate(String localizedValues) {
    if (_localizedStrings.isEmpty && _localizedStrings == null) {
      print('sdfjklllllllllllllllllllllllllllllll');
      return localizedValues;
    } else {
      print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      final index = _localizedStrings.indexWhere(
            (medium) => medium.code == localizedValues,
      );

      return index != -1 ? _localizedStrings[index].message : localizedValues;
    }
  }
}
