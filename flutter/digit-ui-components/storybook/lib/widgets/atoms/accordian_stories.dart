import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/accordionModel.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> accordionStories() {
  return [
    Story(
      name: 'Atom/Accordion/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://app.gitbook.com/o/-MEQmzNGXk5ajuZujG7E/s/egsIWleSdyH9rMLJ8ShI/~/changes/307/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0/atom/accordion',
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/Basic',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);

        bool showDivider = context.knobs.boolean(label: 'Show Divider', initial: false);
        bool showBorder = context.knobs.boolean(label: 'Show Border', initial: true);
        bool withStrokes = context.knobs.boolean(label: 'With Strokes', initial: false);
        bool withIcons = context.knobs.boolean(label: 'With Icons', initial: false);
        bool withNumbers = context.knobs.boolean(label: 'With Numbers', initial: false);

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Row(
                children: [
                  if(withNumbers)
                  Text('1.', style: textTheme.headingS),
                  if(withIcons)
                  const Icon(Icons.account_circle),
                  if(withIcons || withNumbers)
                  const SizedBox(
                    width: spacer3,
                  ),
                  Text(context.knobs.text(label: 'Header', initial: 'Accordion'), style: textTheme.headingS),
                ],
              ),
              content: Text(context.knobs.text(label: 'Content', initial: 'This is the content of Accordion'),
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
              initiallyExpanded: context.knobs.boolean(label: 'Expanded', initial: false),
              divider: showDivider,
              showBorder: showBorder,
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: withStrokes ? 2: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/Nested',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Text('Accordion 1', style: textTheme.headingS),
              content: DigitAccordion(
                padding: EdgeInsets.only(bottom: 16),
                contentBackgroundColor: theme.colorTheme.paper.secondary,
                headerBackgroundColor: theme.colorTheme.paper.secondary,
                items: [
                  DigitAccordionItem(
                    header: Text('Accordion 1.1', style: textTheme.headingS),
                    content: DigitAccordion(
                      padding: EdgeInsets.only(bottom: 16),
                      contentBackgroundColor: theme.colorTheme.paper.primary,
                      headerBackgroundColor: theme.colorTheme.paper.primary,
                      items: [
                        DigitAccordionItem(
                          header: Text('Accordion 1.1', style: textTheme.headingS),
                          content: Text('This is the content of Accordion 1.1.1',
                              style: textTheme.bodyS.copyWith(
                                  color: theme.colorTheme.text.primary)),
                        ),
                      ],
                    ),
                  ),
                  DigitAccordionItem(
                    header: Text('Accordion 1.2', style: textTheme.headingS),
                    content: Text('This is the content of Accordion 1.2',
                        style: textTheme.bodyS
                            .copyWith(color: theme.colorTheme.text.primary)),
                  ),
                ],
              ),
              initiallyExpanded: false,
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
  ];
}
