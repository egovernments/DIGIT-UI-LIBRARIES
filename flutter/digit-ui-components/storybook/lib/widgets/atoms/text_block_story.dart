import 'package:digit_ui_components/widgets/atoms/digit_toast.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> textBlockStories() {
  return [
    Story(
      name: 'Atom/Text Block',
      builder: (context) => TextChunk(
        caption: context.knobs.text(label: 'Caption', initial: 'This is a caption'),
        heading: context.knobs.text(label: 'Heading', initial: 'This is a headings'),
        subHeading: context.knobs.text(label: 'Subheading', initial: 'This is a subheading'),
        body: context.knobs.text(label: 'Body', initial: 'This is the body text. It contains the main content and can be of any length.'),
      ),
    ),
  ];
}
