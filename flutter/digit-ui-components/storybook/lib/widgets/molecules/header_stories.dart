import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_header.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';

import '../../iframe/iframe_widget.dart';

List<Story> headerMoleculeStories() {
  String city = 'City';
  String langauge = 'Language';
  return [
    Story(
      name: 'Molecule/Header/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/Header/Light',
      builder: (context){
        final String title = context.knobs.text(label: 'Customize title', initial: 'Digit UI Library');
        final bool cityDropdown  = context.knobs.boolean(label: 'City Selection', initial: true);
        final bool langaugeSelection = context.knobs.boolean(label: 'Language Selection', initial: true);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderMolecule(
              title: title,
              type: HeaderType.light,
              leadingDigitLogo: false,
              trailingDigitLogo: true,
              actions: [
                if(cityDropdown)
                HeaderAction(
                  widget: Row(
                    children: [
                      Text(city, style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.textPrimary),),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: const DigitColors().light.textPrimary,
                      )
                    ],
                  ),
                  isSearchable: true,
                  dropdownItems: [
                    const DropdownItem(code: '1', name: 'Option 1'),
                    const DropdownItem(code: '2', name: 'Option 2'),
                    const DropdownItem(code: '3', name: 'Option 3'),
                    const DropdownItem(code: '4', name: 'Option 4'),
                  ],
                ),
                if(langaugeSelection)
                HeaderAction(
                  widget: Row(
                    children: [
                      Text('Language', style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.textPrimary)),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: const DigitColors().light.textPrimary,
                      )
                    ],
                  ),
                  dropdownItems: [
                    const DropdownItem(code: '1', name: 'Hindi'),
                    const DropdownItem(code: '2', name: 'English'),
                    const DropdownItem(code: '3', name: 'French'),
                  ],
                ),
                HeaderAction(
                  widget: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(color: DigitColors().light.primary2, width: 1.0),
                      color: DigitColors().light.primary2,
                    ),
                    child: Center(
                      child: Text(
                        'R',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: DigitColors().light.paperPrimary),
                      ),
                    ),
                  ),
                  dropdownItems: [
                    const DropdownItem(code: '1', name: 'Edit Profile'),
                    const DropdownItem(code: '2', name: 'Logout'),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Molecule/Header/Dark',
      builder: (context) {
        final String title = context.knobs.text(label: 'Customize title', initial: 'Digit UI Library');
        final bool cityDropdown  = context.knobs.boolean(label: 'City Selection', initial: true);
        final bool langaugeSelection = context.knobs.boolean(label: 'Language Selection', initial: true);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderMolecule(
              title: title,
              type: HeaderType.dark,
              leadingDigitLogo: false,
              trailingDigitLogo: true,
              actions: [
                if(cityDropdown)
                HeaderAction(
                  widget: Row(
                    children: [
                      Text(
                          city, style: Theme
                          .of(context)
                          .digitTextTheme(context)
                          .bodyS
                          .copyWith(
                          color: const DigitColors().light.paperPrimary)
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: const DigitColors().light.paperPrimary,
                      )
                    ],
                  ),
                  isSearchable: true,
                  dropdownItems: [
                    const DropdownItem(code: '1', name: 'Option 1'),
                    const DropdownItem(code: '2', name: 'Option 2'),
                    const DropdownItem(code: '3', name: 'Option 3'),
                    const DropdownItem(code: '4', name: 'Option 4'),
                  ],
                ),
                if(langaugeSelection)
                HeaderAction(
                  widget: Row(
                    children: [
                      Text(
                          'Language', style: Theme
                          .of(context)
                          .digitTextTheme(context)
                          .bodyS
                          .copyWith(
                          color: const DigitColors().light.paperPrimary)
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: const DigitColors().light.paperPrimary,
                      )
                    ],
                  ),
                  dropdownItems: [
                    const DropdownItem(code: '1', name: 'Hindi'),
                    const DropdownItem(code: '2', name: 'English'),
                    const DropdownItem(code: '3', name: 'French'),
                  ],
                ),
                HeaderAction(
                  widget: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const DigitColors().light.paperPrimary,
                          width: 1.0),
                      color: const DigitColors().light.paperPrimary,
                    ),
                    child: Center(
                      child: Text(
                        'R',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: const DigitColors().light.primary2),
                      ),
                    ),
                  ),
                  dropdownItems: [
                    const DropdownItem(code: '1', name: 'Edit Profile'),
                    const DropdownItem(code: '2', name: 'Log Out'),
                  ],
                ),
              ],
            ),
          ],
        );
      }
    ),
  ];
}
