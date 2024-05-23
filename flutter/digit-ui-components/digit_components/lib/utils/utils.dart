import 'package:digit_ui_components/models/DropdownModels.dart';

/// Utility function to capitalize the first letter of the first word
/// and make all other letters lowercase in the entire message
String? convertInToSentenceCase(String? text) {
  if (text == null) {
    return text;
  }

  /// Trim the text to remove leading and trailing whitespace
  text = text.trim();

  /// Split the text into words
  List<String> words = text.split(' ');

  /// Initialize an empty list to hold the processed words
  List<String> sentenceCase = [];

  /// Process the first word separately to capitalize its first letter
  if (words.isNotEmpty) {
    String firstWord = words[0];
    String capitalizedFirstWord =
        firstWord[0].toUpperCase() + firstWord.substring(1).toLowerCase();
    sentenceCase.add(capitalizedFirstWord);

    /// Process the remaining words to make all letters lowercase
    for (int i = 1; i < words.length; i++) {
      sentenceCase.add(words[i].toLowerCase());
    }
  }

  /// Join the processed words back into a single string
  return sentenceCase.join(' ');
}

/// Utility function to capitalize the first letter of every word
String capitalizeFirstLetterOfEveryWord(String text) {
  List<String> words = text.split(' ');
  List<String> capitalizedWords = [];

  for (String word in words) {
    if (word.isNotEmpty) {
      String capitalizedWord =
          word[0].toUpperCase() + word.substring(1).toLowerCase();
      capitalizedWords.add(capitalizedWord);
    }
  }

  return capitalizedWords.join(' ');
}

/// Helper function to get the associated value from the value mapper
String getAssociatedValue(String code, List<ValueMapper> valueMapper ) {
  ValueMapper? mappedValue = valueMapper.firstWhere(
        (value) => value.code == code,
    orElse: () => const ValueMapper(code: '', name: ''),

    /// Provide default values here
  );
  return mappedValue.name;
}

/// truncate string with after a max length
String truncateWithEllipsis(int maxLength, String text) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}