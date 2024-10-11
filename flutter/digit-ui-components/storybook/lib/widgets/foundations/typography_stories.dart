import 'package:digit_ui_components/theme/ColorTheme/color_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/desktop_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/digit_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/mobile_text_theme.dart';
import 'package:digit_ui_components/theme/TextTheme/tab_text_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> typographyStories() {
  return [
    // Heading XL
    Story(
      name: 'Foundations/Typography/Heading/XL',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        // Knob to select screen type
        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        // Get the appropriate text theme based on selected screen type
        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.headingXl.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Heading XL / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.headingXl,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Heading L
    Story(
      name: 'Foundations/Typography/Heading/L',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.headingL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Heading L / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.headingL,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Heading M
    Story(
      name: 'Foundations/Typography/Heading/M',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.headingM.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Heading M / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.headingM,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Heading S
    Story(
      name: 'Foundations/Typography/Heading/S',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.headingS.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Heading S / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.',),
          textStyle: textTheme.headingS,
          color: colorTheme.text.primary,
        );
      },
    ),

    Story(
      name: 'Foundations/Typography/Heading/XS',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.headingS.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Heading XS / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.headingXS,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Body L
    Story(
      name: 'Foundations/Typography/Body/L',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.bodyL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Body L / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere. Aliquam accumsan urna nisi, eu ultricies eros aliquam at. Ut rhoncus elit vitae tempus dignissim. Morbi in felis metus. Donec non eros eu est posuere mattis a id sapien. Proin eu efficitur ligula. Integer in rutrum lectus. Fusce ac nibh sed metus gravida fermentum a vitae est. Nunc quis ipsum lacinia, mattis metus eu, consectetur sem. Mauris eu pulvinar arcu. Phasellus tellus dolor, sollicitudin et dolor et, fermentum tempor nisl. Cras vulputate ultricies venenatis. Sed nec lacus mauris.',),
          textStyle: textTheme.bodyL,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Body S
    Story(
      name: 'Foundations/Typography/Body/S',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.bodyS.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Body S / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere. Aliquam accumsan urna nisi, eu ultricies eros aliquam at. Ut rhoncus elit vitae tempus dignissim. Morbi in felis metus. Donec non eros eu est posuere mattis a id sapien. Proin eu efficitur ligula. Integer in rutrum lectus. Fusce ac nibh sed metus gravida fermentum a vitae est. Nunc quis ipsum lacinia, mattis metus eu, consectetur sem. Mauris eu pulvinar arcu. Phasellus tellus dolor, sollicitudin et dolor et, fermentum tempor nisl. Cras vulputate ultricies venenatis. Sed nec lacus mauris.',),
          textStyle: textTheme.bodyS,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Body XS
    Story(
      name: 'Foundations/Typography/Body/XS',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.bodyXS.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Body XS / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere. Aliquam accumsan urna nisi, eu ultricies eros aliquam at. Ut rhoncus elit vitae tempus dignissim. Morbi in felis metus. Donec non eros eu est posuere mattis a id sapien. Proin eu efficitur ligula. Integer in rutrum lectus. Fusce ac nibh sed metus gravida fermentum a vitae est. Nunc quis ipsum lacinia, mattis metus eu, consectetur sem. Mauris eu pulvinar arcu. Phasellus tellus dolor, sollicitudin et dolor et, fermentum tempor nisl. Cras vulputate ultricies venenatis. Sed nec lacus mauris.',),
          textStyle: textTheme.bodyXS,
          color: colorTheme.text.primary,
        );
      },
    ),

    Story(
      name: 'Foundations/Typography/Caption/L',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.captionL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Caption L / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere. Aliquam accumsan urna nisi, eu ultricies eros aliquam at. Ut rhoncus elit vitae tempus dignissim. Morbi in felis metus. Donec non eros eu est posuere mattis a id sapien. Proin eu efficitur ligula. Integer in rutrum lectus. Fusce ac nibh sed metus gravida fermentum a vitae est. Nunc quis ipsum lacinia, mattis metus eu, consectetur sem. Mauris eu pulvinar arcu. Phasellus tellus dolor, sollicitudin et dolor et, fermentum tempor nisl. Cras vulputate ultricies venenatis. Sed nec lacus mauris.'),
          textStyle: textTheme.captionL,
          color: colorTheme.text.primary,
        );
      },
    ),

    Story(
      name: 'Foundations/Typography/Caption/M',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.bodyL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Caption M / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere. Aliquam accumsan urna nisi, eu ultricies eros aliquam at. Ut rhoncus elit vitae tempus dignissim. Morbi in felis metus. Donec non eros eu est posuere mattis a id sapien. Proin eu efficitur ligula. Integer in rutrum lectus. Fusce ac nibh sed metus gravida fermentum a vitae est. Nunc quis ipsum lacinia, mattis metus eu, consectetur sem. Mauris eu pulvinar arcu. Phasellus tellus dolor, sollicitudin et dolor et, fermentum tempor nisl. Cras vulputate ultricies venenatis. Sed nec lacus mauris.'),
          textStyle: textTheme.captionM,
          color: colorTheme.text.primary,
        );
      },
    ),

    Story(
      name: 'Foundations/Typography/Caption/S',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.captionS.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Caption S / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere. Aliquam accumsan urna nisi, eu ultricies eros aliquam at. Ut rhoncus elit vitae tempus dignissim. Morbi in felis metus. Donec non eros eu est posuere mattis a id sapien. Proin eu efficitur ligula. Integer in rutrum lectus. Fusce ac nibh sed metus gravida fermentum a vitae est. Nunc quis ipsum lacinia, mattis metus eu, consectetur sem. Mauris eu pulvinar arcu. Phasellus tellus dolor, sollicitudin et dolor et, fermentum tempor nisl. Cras vulputate ultricies venenatis. Sed nec lacus mauris.'),
          textStyle: textTheme.captionS,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Link L
    Story(
      name: 'Foundations/Typography/Link/L',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.linkL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Link L / ${fontSize?.toInt()}pts',
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.linkL,
          color: colorTheme.text.primary,
        );
      },
    ),

    // Link M
    Story(
      name: 'Foundations/Typography/Link/M',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.linkM.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Link M / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.linkM,
          color: colorTheme.text.primary,
        );
      },
    ),
    Story(
      name: 'Foundations/Typography/Link/S',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final screenType = context.knobs.options(
          label: 'Screen Type',
          initial: ScreenType.desktop,
          options: [
            Option(label: 'Mobile', value: ScreenType.mobile),
            Option(label: 'Tablet', value: ScreenType.tablet),
            Option(label: 'Desktop', value: ScreenType.desktop),
          ],
        );

        final textTheme = _getTextThemeForScreenType(context, screenType);
        final fontSize = textTheme.linkS.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Link S / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.linkS,
          color: colorTheme.text.primary,
        );
      },
    ),
    Story(
      name: 'Foundations/Typography/Button/L',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final textTheme = theme.digitButtonTextTheme;
        final fontSize = textTheme.buttonL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Button M / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.buttonL,
          color: colorTheme.text.primary,
        );
      },
    ),
    Story(
      name: 'Foundations/Typography/Button/M',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final textTheme = theme.digitButtonTextTheme;
        final fontSize = textTheme.buttonL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Button M / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.buttonM,
          color: colorTheme.text.primary,
        );
      },
    ),
    Story(
      name: 'Foundations/Typography/Button/S',
      builder: (context) {
        final theme = Theme.of(context);
        final colorTheme = theme.colorTheme;

        final textTheme = theme.digitButtonTextTheme;
        final fontSize = textTheme.buttonL.fontSize; // Dynamically get the font size

        return _buildTypographyStory(
          title: 'Button S / ${fontSize?.toInt()}pts', // Use the dynamic font size
          description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.'),
          textStyle: textTheme.buttonS,
          color: colorTheme.text.primary,
        );
      },
    ),
  ];
}

// Function to select text theme based on screen type
DigitTextTheme _getTextThemeForScreenType(BuildContext context, ScreenType screenType) {
  if (screenType == ScreenType.mobile) {
    return const DigitMobileTextThemeExtension();
  } else if (screenType == ScreenType.tablet) {
    return  const DigitTabTextThemeExtension();
  } else {
    return  const DigitDesktopTextThemeExtension();
  }
}

Widget _buildTypographyStory({
  required String title,
  required TextStyle textStyle,
  required String description,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle),
        SizedBox(height: 16),
        DigitDivider(),
        SizedBox(height: 16),
        Text(
          description,
          style: textStyle.copyWith(color: color),
        ),
      ],
    ),
  );
}

// Enum to represent different screen types
enum ScreenType { mobile, tablet, desktop }
