import 'package:digit_ui_components/widgets/atoms/digit_toast.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> textBlockStories() {
  return [
    Story(
      name: 'Atom/Text Block',
      builder: (context) => const TextChunk(
        caption: 'This is a caption',
        heading: 'This is a heading',
        subheading: 'This is a subheading',
        body: 'This is the body text. It contains the main content and can be of any length.',
      ),
    ),
  ];
}
