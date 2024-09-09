import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/theme/colors.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_header.dart';
import 'package:digit_ui_components/widgets/molecules/hamburger.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card_list.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/widgets/atoms/Info_card_stories.dart';
import 'package:storybook/widgets/atoms/accordian_stories.dart';
import 'package:storybook/widgets/atoms/action_card_stories.dart';
import 'package:storybook/widgets/atoms/back_button_stories.dart';
import 'package:storybook/widgets/atoms/bread_crumbs_stories.dart';
import 'package:storybook/widgets/atoms/button_list_stories.dart';
import 'package:storybook/widgets/atoms/button_stories.dart';
import 'package:storybook/widgets/atoms/checkbox_stories.dart';
import 'package:storybook/widgets/atoms/chip_stories.dart';
import 'package:storybook/widgets/atoms/digit_tab_stories.dart';
import 'package:storybook/widgets/atoms/digit_tag_stories.dart';
import 'package:storybook/widgets/atoms/divider_stories.dart';
import 'package:storybook/widgets/atoms/dropdown_stories.dart';
import 'package:storybook/widgets/atoms/flie_upload_stories.dart';
import 'package:storybook/widgets/atoms/input_field_stories.dart';
import 'package:storybook/widgets/atoms/list_view_stories.dart';
import 'package:storybook/widgets/atoms/menu_card_stories.dart';
import 'package:storybook/widgets/atoms/panel_stories.dart';
import 'package:storybook/widgets/atoms/pop_up_card_stories.dart';
import 'package:storybook/widgets/atoms/radio_list_stories.dart';
import 'package:storybook/widgets/atoms/selection_card_stories.dart';
import 'package:storybook/widgets/atoms/stepper_stories.dart';
import 'package:storybook/widgets/atoms/switch_stories.dart';
import 'package:storybook/widgets/atoms/timeline_stories.dart';
import 'package:storybook/widgets/atoms/toast_stories.dart';
import 'package:storybook/widgets/atoms/toggle_stories.dart';
import 'package:storybook/widgets/atoms/tooltip_2_stories.dart';
import 'package:storybook/widgets/molecules/bottom_sheet_stories.dart';
import 'package:storybook/widgets/molecules/card_stories.dart';
import 'package:storybook/widgets/molecules/digit_table_stories.dart';
import 'package:storybook/widgets/molecules/footer_stories.dart';
import 'package:storybook/widgets/molecules/hamburger_stories.dart';
import 'package:storybook/widgets/molecules/header_stories.dart';
import 'package:storybook/widgets/molecules/language_selection_card_stories.dart';
import 'package:storybook/widgets/molecules/panel_card_stories.dart';
import 'package:storybook/widgets/molecules/show_pop_up_stories.dart';
import 'package:storybook/widgets/molecules/side_nav_stories.dart';
import 'package:storybook/widgets/molecules/timeline_molecule_stories.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DigitExtendedTheme.instance.getTheme(context).copyWith(),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: MediaQuery.of(context).size.width < 500
              ? const Size.fromHeight(56)
              : const Size.fromHeight(64), // here the desired height
          child: Builder(
            builder: (context) => CustomHeaderMolecule(
              title: 'City Municipal Corporation',
              type: HeaderType.light,
              leadingDigitLogo: false,
              trailingDigitLogo: true,
              onMenuTap: () {
                Scaffold.of(context).openDrawer();
              },
              actions: [
                HeaderAction(
                  widget: Row(
                    children: [
                      const Text('City'),
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
                  dropdownItems: const [
                    DropdownItem(code: '1', name: 'Option 1'),
                    DropdownItem(code: '2', name: 'Option 2'),
                    DropdownItem(code: '3', name: 'Option 3'),
                    DropdownItem(code: '4', name: 'Option 4'),
                  ],
                ),
                HeaderAction(
                  widget: Row(
                    children: [
                      const Text('Language'),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: const DigitColors().light.textPrimary,
                      )
                    ],
                  ),
                  dropdownItems: const [
                    DropdownItem(code: '1', name: 'Hindi'),
                    DropdownItem(code: '2', name: 'English'),
                    DropdownItem(code: '3', name: 'French'),
                  ],
                ),
                HeaderAction(
                  widget: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: DigitColors().light.primary2, width: 1.0),
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
                  dropdownItems: const [
                    DropdownItem(code: '1', name: 'Edit Profile'),
                    DropdownItem(code: '2', name: 'Logout'),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: SideBar(
          logOutButtonLabel: 'Log Out',
          sidebarItems: [
            SidebarItem(
              title: 'Home',
              icon: Icons.home,
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to Home
              },
            ),
            SidebarItem(
              title: 'Language',
              icon: Icons.language,
              onPressed: () {
                // Implement language change
              },
            ),
            SidebarItem(
              title: 'Profile',
              icon: Icons.person,
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to Profile
              },
            ),
            SidebarItem(
              title: 'View Downloaded Data',
              icon: Icons.download,
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to Downloaded Data
              },
            ),
          ],
        ),
        body: Inspector(
          isEnabled: true,
          child: Storybook(
            initialStory: 'Screens/Scaffold',
            stories: [
              ...buttonStories(),
              ...checkboxStories(),
              ...chipStories(),
              ...infoCardStories(),
              ...panelStories(),
              ...timeLineStories(),
              ...inputFieldStories(),
              ...radioListStories(),
              ...toastStories(),
              ...toggleGroupStories(),
              ...dropdownStories(),
              ...stepperStories(),
              ...fileUploaderStories(),
              ...actionStories(),
              ...popUpStories(),
              ...panelCardStories(),
              ...cardStories(),
              ...dividerStories(),
              ...buttonListStories(),
              ...showPopUPStories(),
              ...footerMoleculeStories(),
              ...headerMoleculeStories(),
              ...breadCrumbStories(),
              ...backNavigationButtonStories(),
              ...timelineMoleculeStories(),

              ///...customStepperStories(),
              ...hamBurgerStories(),
              ...tableStories(),
              ...sideNavStories(),
              //...toolTipStories(),
              //...selectionCardStories(),
              ...listViewStories(),
              ...toolTip2Stories(),
              ...digitTagStories(),
              ...switchStories(),
              ...bottomSheetStories(),
              ...accordionStories(),
              ...tabStories(),
              ...menuCardStories(),
              ...languageSelectionCardStories(),
              Story(
                name: 'Landing Page Card 1',
                builder: (context) =>  MatrixListComponent(
                  icon: Icons.supervisor_account,
                  filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
                  showIconOnRight: context.knobs.boolean(label: 'Show Icon On Right', initial: true),
                  heading: 'Matrix Component',
                  matrixList: [
                    MatrixModel(title: '40', description: 'Description of Matrix 1'),
                    MatrixModel(title: '40', description: 'Description of Matrix 2'),
                  ],
                  actions: [
                    ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
                    ActionItem(label: 'Action 2', onPressed: () {}),
                  ],
                ),
              ),
              Story(
                name: 'Landing Page Card 2',
                builder: (context) =>  MatrixListComponent(
                  icon: Icons.supervisor_account,
                  filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
                  showIconOnRight: context.knobs.boolean(label: 'Show Icon On Right', initial: true),
                  heading: 'Matrix Component',
                  actions: [
                    ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
                    ActionItem(label: 'Action 2', onPressed: () {}),
                  ],
                ),
              ),
              Story(
                name: 'Landing Page Card 3',
                builder: (context) =>  MatrixListScrollComponent(
                  matrixListComponents: [
                    MatrixListComponent(
                      heading: 'Card 1',
                      matrixList: [
                        MatrixModel(title: 'Title 1', description: 'Description 1'),
                        MatrixModel(title: 'Title 2', description: 'Description 2'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 1', onPressed: () {}),
                      ],
                    ),
                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),
                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),
                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),
                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),
                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),

                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),
                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),

                    MatrixListComponent(
                      heading: 'Card 2',
                      matrixList: [
                        MatrixModel(title: 'Title 3', description: 'Description 3'),
                        MatrixModel(title: 'Title 4', description: 'Description 4'),
                      ],
                      actions: [
                        ActionItem(label: 'Action 2', onPressed: () {}),
                      ],
                    ),
                    // Add more MatrixListComponent instances as needed
                  ],
                )
              ),
              Story(
                  name: 'Landing Page Card 4',
                  builder: (context) =>  MatrixListScrollComponent(
                    matrixListComponents: [
                      MatrixListComponent(
                        icon: Icons.supervisor_account,
                        heading: 'Card 1',
                        matrixList: [
                          MatrixModel(title: 'Title 1', description: 'Description 1'),
                          MatrixModel(title: 'Title 2', description: 'Description 2'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 1', onPressed: () {}),
                        ],
                      ),
                      MatrixListComponent(
                        icon: Icons.supervisor_account,
                        heading: 'Card 2',
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),
                      MatrixListComponent(
                        icon: Icons.supervisor_account,
                        heading: 'Card 2',
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),
                      MatrixListComponent(
                        heading: 'Card 4',
                        icon: Icons.supervisor_account,
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),
                      MatrixListComponent(
                        heading: 'Card 5',
                        icon: Icons.supervisor_account,
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),
                      MatrixListComponent(
                        heading: 'Card 6',
                        icon: Icons.supervisor_account,
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),

                      MatrixListComponent(
                        heading: 'Card 7',
                        icon: Icons.supervisor_account,
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),
                      MatrixListComponent(
                        heading: 'Card 8',
                        icon: Icons.supervisor_account,
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),

                      MatrixListComponent(
                        heading: 'Card 9',
                        icon: Icons.supervisor_account,
                        matrixList: [
                          MatrixModel(title: 'Title 3', description: 'Description 3'),
                          MatrixModel(title: 'Title 4', description: 'Description 4'),
                        ],
                        actions: [
                          ActionItem(label: 'Action 2', onPressed: () {}),
                        ],
                      ),
                      // Add more MatrixListComponent instances as needed
                    ],
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
