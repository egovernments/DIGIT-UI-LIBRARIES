import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/accordionModel.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> accordionListStories() {
  return [
    Story(
      name: 'Molecule/Accordion List/Basic',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Text('Accordion 1', style: textTheme.headingS),
              content: Text('This is the content of Accordion 1',
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
              initiallyExpanded: false,
            ),
            DigitAccordionItem(
              header: Text('Accordion 2', style: textTheme.headingS),
              content: Text('This is the content of Accordion 2',
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
            ),
            DigitAccordionItem(
              header: Text('Accordion 3', style: textTheme.headingS),
              content: Text('This is the content of Accordion 3',
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
            ),
          ],
          allowMultipleOpen: true,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Molecule/Accordion List/With Icons',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Row(
                children: [
                  const Icon(Icons.account_circle),
                  const SizedBox(
                    width: spacer3,
                  ),
                  Text('Accordion 1', style: textTheme.headingS),
                ],
              ),
              content: Text('This is the content of Accordion 1',
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
              initiallyExpanded: false,
            ),
            DigitAccordionItem(
              header: Row(
                children: [
                  const Icon(Icons.account_circle),
                  const SizedBox(
                    width: spacer3,
                  ),
                  Text('Accordion 2', style: textTheme.headingS),
                ],
              ),
              content: Text('This is the content of Accordion 2',
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
            ),
            DigitAccordionItem(
              header: Row(
                children: [
                  const Icon(Icons.account_circle),
                  const SizedBox(
                    width: spacer3,
                  ),
                  Text('Accordion 3', style: textTheme.headingS),
                ],
              ),
              content: Text('This is the content of Accordion 3',
                  style: textTheme.bodyS
                      .copyWith(color: theme.colorTheme.text.primary)),
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
