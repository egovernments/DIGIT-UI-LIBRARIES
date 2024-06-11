import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/widgets/atoms/digit_footer.dart';
import 'package:digit_ui_components/widgets/molecules/digit_footer_molecule.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> footerMoleculeStories() {
  String label = 'Actions';
  return [
    Story(
      name: 'Molecule/Footer/1',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          FooterAction(
            button: Button(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: ButtonType.secondary,
              size: ButtonSize.large,
              prefixIcon: Icons.arrow_back,
            ),
          ),
          FooterAction(
              button: Button(
                label: 'Actions   ',
                onPressed: () {
                  print('neeeeeeeeeexxxxxxtttttttttt');
                },
                type: ButtonType.primary,
                size: ButtonSize.large,
                suffixIcon: Icons.arrow_forward,
              ),
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Footer/2',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return DigitFooter(
            actionAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              FooterAction(
                button: Button(
                  label: 'back',
                  onPressed: () {
                    print('heeeeeeeeee');
                  },
                  type: ButtonType.secondary,
                  size: ButtonSize.large,
                  prefixIcon: Icons.arrow_back,
                ),
              ),
              FooterAction(
                  button: Button(
                    label: label,
                    onPressed: () {
                      print('neeeeeeeeeexxxxxxtttttttttt');
                    },
                    type: ButtonType.primary,
                    size: ButtonSize.large,
                    suffixIcon: Icons.arrow_drop_up,
                  ),
                  dropdownItems: [
                    const DropdownItem(name: 'first', code: '1'),
                    const DropdownItem(name: 'second', code: '2'),
                    const DropdownItem(name: 'third', code: '3'),
                    const DropdownItem(name: 'forth', code: '4'),
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
      name: 'Molecule/Footer/3',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.end,
        actions: [
          FooterAction(
            button: Button(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: ButtonType.secondary,
              size: ButtonSize.large,
              prefixIcon: Icons.arrow_back,
            ),
          ),
          FooterAction(
              button: Button(
                label: 'Actions   ',
                onPressed: () {
                  print('neeeeeeeeeexxxxxxtttttttttt');
                },
                type: ButtonType.primary,
                size: ButtonSize.large,
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
      name: 'Molecule/Footer/4',
      builder: (context) => DigitFooter(
        actionAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          FooterAction(
            button: Button(
              label: 'back',
              onPressed: () {
                print('heeeeeeeeee');
              },
              type: ButtonType.secondary,
              size: ButtonSize.large,
              prefixIcon: Icons.arrow_back,
            ),
          ),
          FooterAction(
              button: Button(
                label: 'Actions   ',
                onPressed: () {
                  print('neeeeeeeeeexxxxxxtttttttttt');
                },
                type: ButtonType.primary,
                size: ButtonSize.large,
                suffixIcon: Icons.arrow_drop_up,
              ),
              dropdownItems: [
                const DropdownItem(name: 'first', code: '1'),
                const DropdownItem(name: 'second', code: '2'),
                const DropdownItem(name: 'third', code: '3'),
                const DropdownItem(name: 'forth', code: '4'),
              ]),
        ],
      ),
    ),
    // Story(
    //   name: 'Atom/Footer/2',
    //   builder: (context) => CustomFooter(
    //     actions: [
    //       Button(
    //           label: 'go to hcm campaign',
    //           onPressed: () {},
    //           type: ButtonType.primary,
    //           size: ButtonSize.large),
    //       Button(
    //         label: 'go back to home',
    //         onPressed: () {},
    //         type: ButtonType.secondary,
    //         size: ButtonSize.large,
    //         prefixIcon: Icons.arrow_back,
    //       ),
    //     ],
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Footer/3',
    //   builder: (context) => CustomFooter(
    //     actionAlignment: MainAxisAlignment.spaceBetween,
    //     actions: [
    //       Button(
    //           label: 'Go to home',
    //           onPressed: () {},
    //           type: ButtonType.primary,
    //           size: ButtonSize.large),
    //       Button(
    //         label: 'Back',
    //         onPressed: () {},
    //         type: ButtonType.secondary,
    //         size: ButtonSize.large,
    //         prefixIcon: Icons.arrow_back,
    //       ),
    //     ],
    //   ),
    // ),
  ];
}
