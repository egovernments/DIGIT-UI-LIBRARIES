import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_footer.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> footerMoleculeStories() {
  String label = 'Actions';
  return [
    Story(
      name: 'Molecule/Footer/Variant 1',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          FooterAction(
            buttons: DigitButton(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: DigitButtonType.secondary,
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
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
              suffixIcon: Icons.arrow_forward,
            ),
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Footer/Variant 2',
      builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return DigitFooter(
              actionAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                FooterAction(
                  buttons: DigitButton(
                    label: 'back',
                    onPressed: () {
                      print('heeeeeeeeee');
                    },
                    type: DigitButtonType.secondary,
                    size: DigitButtonSize.large,
                    prefixIcon: Icons.arrow_back,
                  ),
                ),
                FooterAction(
                    buttons: DigitButton(
                      label: label,
                      onPressed: () {
                        print('neeeeeeeeeexxxxxxtttttttttt');
                      },
                      type: DigitButtonType.primary,
                      size: DigitButtonSize.large,
                      suffixIcon: Icons.arrow_drop_up,
                    ),
                    dropdownItems: [
                      const DropdownItem(name: 'first', code: '1'),
                      const DropdownItem(name: 'second', code: '2'),
                      const DropdownItem(name: 'third', code: '3'),
                      const DropdownItem(name: 'fourth', code: '4'),
                    ],
                    onDropdownItemSelected: (item){
                      setState((){
                        label = item.name;
                      });
                    }
                ),
              ],
            );
          }
      ),
    ),
    Story(
      name: 'Molecule/Footer/Variant 3',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.end,
        actions: [
          FooterAction(
            buttons: DigitButton(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: DigitButtonType.secondary,
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
                type: DigitButtonType.primary,
                size: DigitButtonSize.large,
                suffixIcon: Icons.arrow_drop_up,
              ),
              dropdownItems: [
                const DropdownItem(name: 'first', code: '1'),
                const DropdownItem(name: 'second', code: '2'),
                // const DropdownItem(name: 'third', code: '3'),
                // const DropdownItem(name: 'forth', code: '4'),
              ]),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Footer/Variant 4',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          FooterAction(
            buttons: DigitButton(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: DigitButtonType.secondary,
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
                type: DigitButtonType.primary,
                size: DigitButtonSize.large,
                suffixIcon: Icons.arrow_drop_up,
              ),
              dropdownItems: [
                const DropdownItem(name: 'first', code: '1'),
                const DropdownItem(name: 'second', code: '2'),
                const DropdownItem(name: 'third', code: '3'),
                const DropdownItem(name: 'fourth', code: '4'),
              ]),
        ],
      ),
    ),
  ];
}