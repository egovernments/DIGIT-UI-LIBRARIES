import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/widgets/atoms/digit_header.dart';
import 'package:digit_ui_components/widgets/helper_widget/header_dropdown.dart';
import 'package:digit_ui_components/widgets/molecules/header_molecule.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> headerMoleculeStories() {
  return [
    Story(
      name: 'Molecule/Header/light/1',
      builder: (context) => const CustomHeaderMolecule(
        title: 'My Custom Header',
        actions: [],
        type: HeaderType.light,
      ),
    ),
    Story(
      name: 'Molecule/Header/light/2',
      builder: (context) => CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.light,
        leadingWidget: Image.network(
          'https://s3-alpha-sig.figma.com/img/1d0d/d20b/17bba4d1a5b09a0840e516227bbe9364?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kCzBVvYwPETCwHpSAAaIFB1MZQisvQ1avryik4YbCCH0HDVfJp1dxdl8UNPrDgf34YYKgyA~nNbNeGJ8N9eurZz3JbjCzdLdJiGnJL9ANqQgAOdZV4c9TAroinpq9RhTdTOjJg2U4f00PCM8jYTErO2WvNGAlXx~SqSBIj~SuiwYR2Xf2mozObFIDAjyW2gyDa6HbVLPkdINrnDJnm73S3HrqdL3q6DZkYEmEYd7qtZW0XJ3ywZBbXEuRnhumX6Ylf9RTzLdJqlfP5WaQDwjdxhQTNmIUjBYMqaF-SWqR31gZWISkKjK3uXdtfjAQBW2CYzMu-n~Alh9FwD3dx-SZQ__',
          fit: BoxFit.fill,
        ),
        trailingDigitLogo: false,
        leadingDigitLogo: true,
      ),
    ),
    Story(
      name: 'Molecule/Header/light/3',
      builder: (context) => const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomHeaderMolecule(
            title: 'My Custom Header',
            type: HeaderType.light,
            actions: [
              HeaderDropdown(
                title: 'City',
                headerType: HeaderType.light,
                items: [
                  DropdownItem(code: '1', name: 'Option 1'),
                  DropdownItem(code: '2', name: 'Option 2'),
                  DropdownItem(code: '3', name: 'Option 3'),
                  DropdownItem(code: '4', name: 'Option 4'),
                ],
              ),
              HeaderDropdown(
                title: 'Language',
                searchable: true,
                headerType: HeaderType.light,
                items: [
                  DropdownItem(code: '1', name: 'Hindi'),
                  DropdownItem(code: '2', name: 'English'),
                  DropdownItem(code: '3', name: 'French'),
                  DropdownItem(code: '4', name: 'Hindi'),
                  DropdownItem(code: '5', name: 'English'),
                  DropdownItem(code: '6', name: 'French'),
                  DropdownItem(code: '7', name: 'Hindi'),
                  DropdownItem(code: '8', name: 'English'),
                  DropdownItem(code: '9', name: 'French'),
                  DropdownItem(code: '10', name: 'Hindi'),
                  DropdownItem(code: '11', name: 'French'),
                  DropdownItem(code: '12', name: 'English'),
                  DropdownItem(code: '13', name: 'French'),
                  DropdownItem(code: '14', name: 'Hindi'),
                  DropdownItem(code: '15', name: 'English'),
                  DropdownItem(code: '16', name: 'French'),
                  DropdownItem(code: '17', name: 'Hindi'),
                  DropdownItem(code: '18', name: 'English'),
                  DropdownItem(code: '19', name: 'French'),
                  DropdownItem(code: '20', name: 'Hindi'),
                  DropdownItem(code: '21', name: 'English'),
                  DropdownItem(code: '22', name: 'French'),
                  DropdownItem(code: '23', name: 'Hindi'),
                  DropdownItem(code: '24', name: 'English'),
                  DropdownItem(code: '25', name: 'French'),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Header/light/4',
      builder: (context) => const CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.light,
        leadingDigitLogo: false,
        leadingWidget: Icon(Icons.menu, size: 24,),
        trailingDigitLogo: false,
        actions: [HeaderDropdown(
          title: 'Language',
          searchable: true,
          headerType: HeaderType.light,
          items: [
            DropdownItem(code: '1', name: 'Hindi'),
            DropdownItem(code: '2', name: 'English'),
            DropdownItem(code: '3', name: 'French'),
          ],
        ),],
      ),
    ),
    Story(
      name: 'Molecule/Header/light/5',
      builder: (context) => CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.light,
        leadingDigitLogo: false,
        trailingDigitLogo: true,
        actions: [
          const HeaderDropdown(
            title: 'City',
            headerType: HeaderType.light,
            items: [
              DropdownItem(code: '1', name: 'Option 1'),
              DropdownItem(code: '2', name: 'Option 2'),
              DropdownItem(code: '3', name: 'Option 3'),
              DropdownItem(code: '4', name: 'Option 4'),
            ],
          ),
          const HeaderDropdown(
            title: 'Language',
            searchable: true,
            headerType: HeaderType.light,
            items: [
              DropdownItem(code: '1', name: 'Hindi'),
              DropdownItem(code: '2', name: 'English'),
              DropdownItem(code: '3', name: 'French'),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const DigitColors().light.primary2, width: 1.0),
              color: const DigitColors().light.primary2,
            ),
            child:  Center(
              child: Text(
                'R',
                style: TextStyle(fontWeight: FontWeight.w700,color: const DigitColors().light.paperPrimary),
              ),
            ),
          )
        ],

      ),
    ),
    Story(
      name: 'Molecule/Header/dark/1',
      builder: (context) => const CustomHeaderMolecule(
        title: 'My Custom Header',
        actions: [],
        type: HeaderType.dark,
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/2',
      builder: (context) => CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.dark,
        leadingWidget: Image.network(
          'https://s3-alpha-sig.figma.com/img/1d0d/d20b/17bba4d1a5b09a0840e516227bbe9364?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kCzBVvYwPETCwHpSAAaIFB1MZQisvQ1avryik4YbCCH0HDVfJp1dxdl8UNPrDgf34YYKgyA~nNbNeGJ8N9eurZz3JbjCzdLdJiGnJL9ANqQgAOdZV4c9TAroinpq9RhTdTOjJg2U4f00PCM8jYTErO2WvNGAlXx~SqSBIj~SuiwYR2Xf2mozObFIDAjyW2gyDa6HbVLPkdINrnDJnm73S3HrqdL3q6DZkYEmEYd7qtZW0XJ3ywZBbXEuRnhumX6Ylf9RTzLdJqlfP5WaQDwjdxhQTNmIUjBYMqaF-SWqR31gZWISkKjK3uXdtfjAQBW2CYzMu-n~Alh9FwD3dx-SZQ__',
          fit: BoxFit.fill,
        ),
        trailingDigitLogo: false,
        leadingDigitLogo: true,
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/3',
      builder: (context) => const CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.dark,
        actions: [
          HeaderDropdown(
            title: 'City',
            headerType: HeaderType.dark,
            items: [
              DropdownItem(code: '1', name: 'Option 1'),
              DropdownItem(code: '2', name: 'Option 2'),
              DropdownItem(code: '3', name: 'Option 3'),
              DropdownItem(code: '4', name: 'Option 4'),
            ],
          ),
          HeaderDropdown(
            title: 'Language',
            searchable: true,
            headerType: HeaderType.dark,
            items: [
              DropdownItem(code: '1', name: 'Hindi'),
              DropdownItem(code: '2', name: 'English'),
              DropdownItem(code: '3', name: 'French'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/4',
      builder: (context) =>  CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.dark,
        leadingDigitLogo: false,
        leadingWidget: Icon(Icons.menu, size: 24, color: const DigitColors().light.paperPrimary,),
        trailingDigitLogo: false,
        actions: const [HeaderDropdown(
          title: 'Language',
          searchable: true,
          headerType: HeaderType.dark,
          items: [
            DropdownItem(code: '1', name: 'Hindi'),
            DropdownItem(code: '2', name: 'English'),
            DropdownItem(code: '3', name: 'French'),
          ],
        ),],
      ),
    ),
    Story(
      name: 'Molecule/Header/dark/5',
      builder: (context) => CustomHeaderMolecule(
        title: 'My Custom Header',
        type: HeaderType.dark,
        leadingDigitLogo: false,
        trailingDigitLogo: true,
        actions: [
          const HeaderDropdown(
            title: 'City',
            headerType: HeaderType.dark,
            items: [
              DropdownItem(code: '1', name: 'Option 1'),
              DropdownItem(code: '2', name: 'Option 2'),
              DropdownItem(code: '3', name: 'Option 3'),
              DropdownItem(code: '4', name: 'Option 4'),
            ],
          ),
          const HeaderDropdown(
            title: 'Language',
            searchable: true,
            headerType: HeaderType.dark,
            items: [
              DropdownItem(code: '1', name: 'Hindi'),
              DropdownItem(code: '2', name: 'English'),
              DropdownItem(code: '3', name: 'French'),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const DigitColors().light.paperPrimary, width: 1.0),
              color: const DigitColors().light.paperPrimary,
            ),
            child:  Center(
              child: Text(
                'R',
                style: TextStyle(fontWeight: FontWeight.w700,color: const DigitColors().light.primary2),
              ),
            ),
          )
        ],

      ),
    ),
  ];
}
