import 'package:digit_ui_components/widgets/molecules/language_selection_card.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';


List<Story> languageSelectionCardStories() {
  return [
    Story(
      name: 'Molecule/Language Selection Card/Basic',
      builder: (context) =>  DigitLanguageCard(
        digitRowCardItems: [
          DigitRowCardModel(label: 'English', value: 'EN', isSelected: true),
          DigitRowCardModel(label: 'Spanish', value: 'ES'),
          DigitRowCardModel(label: 'French', value: 'FR'),
        ],
        onLanguageChange: (DigitRowCardModel selectedLanguage) {
          // Handle language change
          print('Selected Language: ${selectedLanguage.label}');
        },
        onLanguageSubmit: (){

        },
        languageSubmitLabel: 'Confirm',
        appLogo: Center(
          child: Image.asset(
            'assets/images/digit_logo_light.png',
            height: 24,
          ),
        ),
      ),
    ),
    Story(
      name: 'Molecule/Language Selection Card/Custom',
      builder: (context) =>  DigitLanguageCard(
        digitRowCardItems: [
          DigitRowCardModel(label: 'English', value: 'EN', isSelected: true),
          DigitRowCardModel(label: 'Spanish', value: 'ES'),
          DigitRowCardModel(label: 'French', value: 'FR'),
        ],
        onLanguageChange: (DigitRowCardModel selectedLanguage) {
          // Handle language change
          print('Selected Language: ${selectedLanguage.label}');
        },
        onLanguageSubmit: (){

        },
        languageSubmitLabel: 'Confirm',
        appLogo: Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg'), // Default image
          ),
        ),
      ),
    ),
  ];
}