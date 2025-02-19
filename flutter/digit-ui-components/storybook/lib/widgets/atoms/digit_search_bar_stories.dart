import 'package:digit_ui_components/widgets/atoms/digit_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> searchBarStories() {
  return [
    Story(
      name: 'Atom/Search Bar/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Search Bar/Basic',
      builder: (context) {
        final theme = Theme.of(context);

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