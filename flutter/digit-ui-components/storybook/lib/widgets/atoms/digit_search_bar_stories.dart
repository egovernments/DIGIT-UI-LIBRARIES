import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:digit_ui_components/widgets/atoms/digit_search_bar.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> searchBarStories() {
  return [
    Story(
      name: 'Atom/Search Bar/default',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitSearchBar(
          controller: TextEditingController(),
          hintText: 'sdfsdjfsdlkfjsdfksjd',
          textCapitalization:
          TextCapitalization.words,
          onChanged: (value) {
            // print(value);
          },
        );
      },
    ),
  ];
}