import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:digit_ui_components/widgets/molecules/language_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> languageSelectionCardStories() {
  return [
    Story(
      name: 'Molecule/Language Selection Card/1',
      builder: (context) =>  DigitLanguageCard(
        digitRowCardItems: [
          DigitRowCardModel(label: 'English', value: 'EN', isSelected: true),
          DigitRowCardModel(label: 'Spanish', value: 'ES'),
          DigitRowCardModel(label: 'French', value: 'FR'),
        ],
        onLanguageChange: (DigitRowCardModel selectedLanguage) {
          // Handle language change
          print('Selected Language: ${selectedLanguage.label}');
        }, // Step 2: Handle language selection
        onLanguageSubmit: (){

        }, // Step 2: Handle submit action
        languageSubmitLabel: 'Confirm', // Customize the submit DigitButton label
        // Optional: Add your app logo
      ),
    ),
    Story(
        name: 'Molecule/Language Selection Card/2',
        builder: (context) {
          final List<DigitRowCardModel> languages = [
            DigitRowCardModel(label: 'English', value: 'EN'),
            DigitRowCardModel(label: 'Spanish', value: 'ES'),
            DigitRowCardModel(label: 'French', value: 'FR'),
          ];

          return DigitLanguageCard(
            digitRowCardItems: [
              DigitRowCardModel(label: 'English', value: 'EN'),
              DigitRowCardModel(label: 'Spanish', value: 'ES'),
              DigitRowCardModel(label: 'French', value: 'FR'),
            ],
            // Step 1: Pass the language list
            onLanguageChange: (DigitRowCardModel selectedLanguage) {
              // Handle language change
              print('Selected Language: ${selectedLanguage.label}');
            },
            // Step 2: Handle language selection
            onLanguageSubmit: () {
              // Handle language submit
              final selectedLanguage = languages.firstWhere((lang) =>
              lang.isSelected);
              print('Submitted Language: ${selectedLanguage.label}');
            },
            // Step 2: Handle submit action
            languageSubmitLabel: 'Confirm',
            // Customize the submit DigitButton label// Optional: Add your app logo
          );
        }
    ),
  ];
}