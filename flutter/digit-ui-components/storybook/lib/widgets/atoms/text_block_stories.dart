import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/text_block.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> textBlockStories() {
  return [
    Story(
      name: 'Atom/Text Block/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Text Block/Basic',
      builder: (context) => Center(
        child: DigitTextBlock(
          caption: context.knobs.nullable.options(label: 'Caption', initial: 'Caption Text', options: [Option(label: 'Caption Text', value: 'Caption Text'),]),
          heading: context.knobs.nullable.text(label: 'Heading', initial: 'Heading Text', enabled: true),
          subHeading: context.knobs.nullable.text(label: 'Sub heading', initial: 'Sub Heading Text'),
          description: context.knobs.nullable.text(label: 'Description', initial: 'This is the description of the TextBlock component.'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Text Block/Custom',
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