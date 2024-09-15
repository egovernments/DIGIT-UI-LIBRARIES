import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card_list.dart';
import 'package:digit_ui_components/widgets/molecules/language_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> languageSelectionCardStories() {
  return [
    Story(
      name: 'Molecule/Landing Page Card/1',
      builder: (context) => MatrixListComponent(
        icon: Icons.supervisor_account,
        filledIcon: context.knobs
            .boolean(label: 'Filled Icon', initial: true),
        showIconOnRight: context.knobs
            .boolean(label: 'Show Icon On Right', initial: true),
        heading: 'Matrix Component',
        matrixList: [
          MatrixModel(
              title: '40', description: 'Description of Matrix 1'),
          MatrixModel(
              title: '40', description: 'Description of Matrix 2'),
        ],
        actions: [
          ActionItem(
              label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Landing Page Card/2',
      builder: (context) => MatrixListComponent(
        icon: Icons.supervisor_account,
        filledIcon: context.knobs
            .boolean(label: 'Filled Icon', initial: true),
        showIconOnRight: context.knobs
            .boolean(label: 'Show Icon On Right', initial: true),
        heading: 'Matrix Component',
        actions: [
          ActionItem(
              label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
    Story(
        name: 'Molecule/Landing Page Card/3',
        builder: (context) => MatrixListScrollComponent(
          matrixListComponents: [
            MatrixListComponent(
              heading: 'Card 1',
              matrixList: [
                MatrixModel(
                    title: 'Title 1',
                    description: 'Description 1'),
                MatrixModel(
                    title: 'Title 2',
                    description: 'Description 2'),
              ],
              actions: [
                ActionItem(label: 'Action 1', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),

            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),

            MatrixListComponent(
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            // Add more MatrixListComponent instances as needed
          ],
        )),
    Story(
        name: 'Molecule/Landing Page Card/4',
        builder: (context) => MatrixListScrollComponent(
          matrixListComponents: [
            MatrixListComponent(
              icon: Icons.supervisor_account,
              heading: 'Card 1',
              matrixList: [
                MatrixModel(
                    title: 'Title 1',
                    description: 'Description 1'),
                MatrixModel(
                    title: 'Title 2',
                    description: 'Description 2'),
              ],
              actions: [
                ActionItem(label: 'Action 1', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              icon: Icons.supervisor_account,
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              icon: Icons.supervisor_account,
              heading: 'Card 2',
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 4',
              icon: Icons.supervisor_account,
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 5',
              icon: Icons.supervisor_account,
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 6',
              icon: Icons.supervisor_account,
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),

            MatrixListComponent(
              heading: 'Card 7',
              icon: Icons.supervisor_account,
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            MatrixListComponent(
              heading: 'Card 8',
              icon: Icons.supervisor_account,
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),

            MatrixListComponent(
              heading: 'Card 9',
              icon: Icons.supervisor_account,
              matrixList: [
                MatrixModel(
                    title: 'Title 3',
                    description: 'Description 3'),
                MatrixModel(
                    title: 'Title 4',
                    description: 'Description 4'),
              ],
              actions: [
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
                ActionItem(label: 'Action 2', onPressed: () {}),
              ],
            ),
            // Add more MatrixListComponent instances as needed
          ],
        )),
  ];
}