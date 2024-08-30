import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> accordionStories() {
  return [
    Story(
      name: 'Atom/Accordion/default',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Text('Panel 1', style: textTheme.headingS),
              content: Text('This is the content of panel 1', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              initiallyExpanded: false,
            ),
            DigitAccordionItem(
              header: Text('Panel 2', style: textTheme.headingS),
              content: Text('This is the content of panel 2', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
            ),
            DigitAccordionItem(
              header: Text('Panel 3', style: textTheme.headingS),
              content: Text('This is the content of panel 3', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/Without border',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Text('Panel 1', style: textTheme.headingS),
              content: Text('This is the content of panel 1', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              initiallyExpanded: false,
              showBorder: false,
            ),
            DigitAccordionItem(
              header: Text('Panel 2', style: textTheme.headingS),
              content: Text('This is the content of panel 2', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              showBorder: false,
            ),
            DigitAccordionItem(
              header: Text('Panel 3', style: textTheme.headingS),
              content: Text('This is the content of panel 3', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              showBorder: false,
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/Divider',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitCard(
          cardType: CardType.primary,
          children:[
          DigitAccordion(
            items: [
              DigitAccordionItem(
                header: Text('Panel 1', style: textTheme.headingS),
                content: Text('This is the content of panel 1', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
                initiallyExpanded: false,
                showBorder: false,
              ),
              DigitAccordionItem(
                header: Text('Panel 2', style: textTheme.headingS),
                content: Text('This is the content of panel 2', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
                showBorder: false,
              ),
              DigitAccordionItem(
                header: Text('Panel 3', style: textTheme.headingS),
                content: Text('This is the content of panel 3', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
                showBorder: false,
              ),
            ],
            allowMultipleOpen: false,
            headerElevation: 0,
            divider: true,
            animationDuration: const Duration(milliseconds: 200),
          ),
        ],
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/Without border and with divider',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Text('Panel 1', style: textTheme.headingS),
              content: Text('This is the content of panel 1', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              initiallyExpanded: false,
              showBorder: false,
              divider: true,
            ),
            DigitAccordionItem(
              header: Text('Panel 2', style: textTheme.headingS),
              content: Text('This is the content of panel 2', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              showBorder: false,
              divider: true,
            ),
            DigitAccordionItem(
              header: Text('Panel 3', style: textTheme.headingS),
              content: Text('This is the content of panel 3', style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
              showBorder: false,
              divider: true,
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with default one open',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: Text('Panel 1', style: textTheme.headingS),
              content: Text('This is the content of panel 1', style: textTheme.bodyS),
              initiallyExpanded: true,
            ),
            DigitAccordionItem(
              header: Text('Panel 2', style: textTheme.headingS),
              content: Text('This is the content of panel 2', style: textTheme.bodyS),
            ),
            DigitAccordionItem(
              header: Text('Panel 3', style: textTheme.headingS),
              content: Text('This is the content of panel 3', style: textTheme.bodyS),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with multiple open',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          allowMultipleOpen: true,
          items: [
            DigitAccordionItem(
              header: Text('Panel 1', style: textTheme.headingS),
              content: Text('This is the content of panel 1', style: textTheme.bodyS),
              initiallyExpanded: true,
            ),
            DigitAccordionItem(
              header: Text('Panel 2', style: textTheme.headingS),
              content: Text('This is the content of panel 2', style: textTheme.bodyS),
            ),
            DigitAccordionItem(
              header: Text('Panel 3', style: textTheme.headingS),
              content: Text('This is the content of panel 3', style: textTheme.bodyS),
            ),
          ],
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with shadow',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        return DigitAccordion(
          allowMultipleOpen: false,
          items: [
            DigitAccordionItem(
              header: Text('Panel 1', style: textTheme.headingS),
              content: Text('This is the content of panel 1', style: textTheme.bodyS),
              initiallyExpanded: true,
            ),
            DigitAccordionItem(
              header: Text('Panel 2', style: textTheme.headingS),
              content: Text('This is the content of panel 2', style: textTheme.bodyS),
            ),
            DigitAccordionItem(
              header: Text('Panel 3', style: textTheme.headingS),
              content: Text('This is the content of panel 3', style: textTheme.bodyS),
            ),
          ],
          headerElevation: 8,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
  ];
}
