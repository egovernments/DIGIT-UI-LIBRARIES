import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_header.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> headerMoleculeStories() {
  String city = 'City';
  String langauge = 'Language';
  return [
    Story(
      name: 'Molecule/Header/light/Variant 1',
      builder: (context) => CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        type: HeaderType.light,
        leadingDigitLogo: false,
        trailingDigitLogo: true,
        actions: [
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
    ),
    Story(
      name: 'Molecule/Header/light/Variant 2',
      builder: (context) => CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        type: HeaderType.light,
        actions: [
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
        trailingDigitLogo: true,
        leadingDigitLogo: false,
      ),
    ),
    Story(
      name: 'Molecule/Header/light/Variant 3',
      builder: (context) => const CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        actions: [],
        type: HeaderType.light,
      ),
    ),
    Story(
      name: 'Molecule/Header/light/Variant 4',
      builder: (context) => CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        type: HeaderType.light,
        leadingDigitLogo: false,
        leadingWidget: const Icon(
          Icons.menu,
          size: 24,
        ),
        trailingDigitLogo: false,
        actions: [
          HeaderAction(
            widget: Row(
              children: [
                Text(city, style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.textPrimary)),
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
              const DropdownItem(code: '1', name: 'Option 1'),
              const DropdownItem(code: '2', name: 'Option 2'),
              const DropdownItem(code: '3', name: 'Option 3'),
              const DropdownItem(code: '4', name: 'Option 4'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/Variant 1',
      builder: (context) => CustomHeaderMolecule(
        title: 'Digit UI Library',
        type: HeaderType.dark,
        leadingDigitLogo: false,
        trailingDigitLogo: true,
        actions: [
          HeaderAction(
            widget: Row(
              children: [
                Text(
                  city, style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.paperPrimary)
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
          HeaderAction(
            widget: Row(
              children: [
                Text(
                  'Language', style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.paperPrimary)
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
                    color: const DigitColors().light.paperPrimary, width: 1.0),
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
    ),
    Story(
      name: 'Molecule/Header/dark/Variant 2',
      builder: (context) => const CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        actions: [],
        type: HeaderType.dark,
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/Variant 3',
      builder: (context) => CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        type: HeaderType.dark,
        trailingDigitLogo: true,
        leadingDigitLogo: false,
        actions: [
          HeaderAction(
            widget: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const DigitColors().light.paperPrimary, width: 1.0),
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
    ),
    Story(
      name: 'Molecule/Header/dark/Variant 4',
      builder: (context) => CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        type: HeaderType.dark,
        actions: [
          HeaderAction(
            widget: Row(
              children: [
                Text(
                  city, style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.paperPrimary)
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
              const DropdownItem(code: '1', name: 'Option 1'),
              const DropdownItem(code: '2', name: 'Option 2'),
              const DropdownItem(code: '3', name: 'Option 3'),
              const DropdownItem(code: '4', name: 'Option 4'),
            ],
          ),
          HeaderAction(
            widget: Row(
              children: [
                Text(
                  'Language', style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.paperPrimary)
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
        ],
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/Variant 5',
      builder: (context) => CustomHeaderMolecule(
        title: 'City Municipal Corporation',
        type: HeaderType.dark,
        leadingDigitLogo: false,
        leadingWidget: Icon(
          Icons.menu,
          size: 24,
          color: const DigitColors().light.paperPrimary,
        ),
        trailingDigitLogo: false,
        actions: [
          HeaderAction(
            widget: Row(
              children: [
                Text(
                  'Language', style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: const DigitColors().light.paperPrimary)
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
        ],
      ),
    ),
  ];
}
