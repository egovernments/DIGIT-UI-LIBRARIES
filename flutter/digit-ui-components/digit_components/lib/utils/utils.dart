/// Capitalize the first letter if required
String? capitalizeFirstLetter(String? text) {
  if (text != null && text.isNotEmpty ) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
  return text;
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