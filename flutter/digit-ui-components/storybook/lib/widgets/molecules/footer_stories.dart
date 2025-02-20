import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_footer.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> footerMoleculeStories() {
  String label = 'Actions';
  return [
    Story(
      name: 'Molecule/Footer/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/Footer/Basic',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.end,
        actions: [
          FooterAction(
            buttons: DigitButton(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: context.knobs.options(label: 'First Button Type', initial: DigitButtonType.secondary, options: [
                Option(label: 'Primary', value: DigitButtonType.primary),
                Option(label: 'Secondary', value: DigitButtonType.secondary),
                Option(label: 'Tertiary', value: DigitButtonType.tertiary),
                Option(label: 'Link', value: DigitButtonType.link)
              ]),
              size: DigitButtonSize.large,
              prefixIcon: Icons.arrow_back,
            ),
          ),
          FooterAction(
            buttons: DigitButton(
              label: 'Actions   ',
              onPressed: () {
                print('neeeeeeeeeexxxxxxtttttttttt');
              },
              type: context.knobs.options(label: 'Second Button Type', initial: DigitButtonType.primary, options: [
                Option(label: 'Primary', value: DigitButtonType.primary),
                Option(label: 'Secondary', value: DigitButtonType.secondary),
                Option(label: 'Tertiary', value: DigitButtonType.tertiary),
                Option(label: 'Link', value: DigitButtonType.link)
              ]),
              size: DigitButtonSize.large,
              suffixIcon: Icons.arrow_forward,
            ),
          ),
        ],
        footerContent: context.knobs.boolean(label: 'Show Extra Content', initial: false)
            ? Text(
              'This is extra content for the footer',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
            : null,
      ),
    ),
    Story(
      name: 'Molecule/Footer/Action',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.end,
        actions: [
          FooterAction(
            buttons: DigitButton(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: context.knobs.options(label: 'First Button Type', initial: DigitButtonType.secondary, options: [
                Option(label: 'Primary', value: DigitButtonType.primary),
                Option(label: 'Secondary', value: DigitButtonType.secondary),
                Option(label: 'Tertiary', value: DigitButtonType.tertiary),
                Option(label: 'Link', value: DigitButtonType.link)
              ]),
              size: DigitButtonSize.large,
              prefixIcon: Icons.arrow_back,
            ),
          ),
          FooterAction(
            buttons: DigitButton(
              label: 'Actions   ',
              onPressed: () {
                print('neeeeeeeeeexxxxxxtttttttttt');
              },
              type: context.knobs.options(label: 'Second Button Type', initial: DigitButtonType.primary, options: [
                Option(label: 'Primary', value: DigitButtonType.primary),
                Option(label: 'Secondary', value: DigitButtonType.secondary),
                Option(label: 'Tertiary', value: DigitButtonType.tertiary),
                Option(label: 'Link', value: DigitButtonType.link)
              ]),
              size: DigitButtonSize.large,
              suffixIcon: Icons.arrow_drop_up,
            ),
            dropdownItems: [
              const DropdownItem(name: 'first', code: '1'),
              const DropdownItem(name: 'second', code: '2'),
            ],
          ),
        ],
        footerContent: context.knobs.boolean(label: 'Show Extra Content', initial: false)
            ? Text(
              'This is extra content for the footer',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
            : null,
      ),
    ),
  ];
}