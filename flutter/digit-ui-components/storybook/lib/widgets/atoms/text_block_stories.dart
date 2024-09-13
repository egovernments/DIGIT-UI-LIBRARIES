import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> textBlockStories() {
  return [
    Story(
      name: 'TextBlock/Default',
      builder: (context) => Center(
        child: DigitTextBlock(
          caption: context.knobs.nullable.text(label: 'Caption', initial: 'Caption Text'),
          heading: context.knobs.nullable.text(label: 'Heading', initial: 'Heading Text'),
          subHeading: context.knobs.nullable.text(label: 'Sub heading', initial: 'Sub Heading Text'),
          description: context.knobs.nullable.text(label: 'Description', initial: 'This is the description of the TextBlock component.'),
        ),
      ),
    ),
    Story(
      name: 'TextBlock/Custom Styles',
      builder: (context) => const Center(
        child: DigitTextBlock(
          caption: 'Custom Caption',
          heading: 'Custom Heading',
          subHeading: 'Custom Subheading',
          description: 'Body with custom styles.',
          captionStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          headingStyle: TextStyle(fontSize: 24, color: Colors.green),
          subHeadingStyle: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.purple),
          descriptionStyle: TextStyle(fontSize: 16, color: Colors.red),
          padding: EdgeInsets.all(16),
        ),
      ),
    ),
  ];
}