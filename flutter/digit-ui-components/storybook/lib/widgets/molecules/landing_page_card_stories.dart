import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card_list.dart';
import 'package:digit_ui_components/widgets/molecules/language_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> landingPageCardStories() {
  return [
    Story(
      name: 'Molecule/Landing Page Card/Default',
      builder: (context) => MatrixListComponent(
        alignCenterMatrixList:
            context.knobs.boolean(label: 'Centered Matrix', initial: true),
        icon: Icons.supervisor_account,
        filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
        showIconOnRight:
            context.knobs.boolean(label: 'Show Icon On Right', initial: true),
        heading: context.knobs.text(label: 'Heading', initial: 'Heading'),
        matrixList: [
          MatrixModel(
              title: 'Matrix 1', description: 'Description of Matrix 1'),
          MatrixModel(
              title: 'Matrix 2', description: 'Description of Matrix 2'),
        ],
        actions: [
          ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Landing Page Card/Without Matrix',
      builder: (context) => MatrixListComponent(
        alignCenterMatrixList:
            context.knobs.boolean(label: 'Centered Matrix', initial: true),
        icon: Icons.supervisor_account,
        filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
        showIconOnRight:
            context.knobs.boolean(label: 'Show Icon On Right', initial: true),
        heading: 'Matrix Component',
        actions: [
          ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Landing Page Card/With Middle Widget',
      builder: (context) => MatrixListComponent(
        alignCenterMatrixList:
            context.knobs.boolean(label: 'Centered Matrix', initial: true),
        icon: Icons.supervisor_account,
        filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
        matrixList: [
          MatrixModel(title: 'Title 1', description: 'Description 1'),
          MatrixModel(title: 'Title 2', description: 'Description 2'),
        ],
        centerWidget: const InfoCard(
          title: 'this is info card',
          type: InfoType.info,
          description: 'details about the component',
        ),
        showIconOnRight:
            context.knobs.boolean(label: 'Show Icon On Right', initial: true),
        heading: 'Matrix Component',
        actions: [
          ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Landing Page Card/With Middle Widget And Bottom Widget',
      builder: (context) => MatrixListComponent(
        alignCenterMatrixList:
            context.knobs.boolean(label: 'Centered Matrix', initial: true),
        icon: Icons.supervisor_account,
        filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
        matrixList: [
          MatrixModel(title: 'Title 1', description: 'Description 1'),
          MatrixModel(title: 'Title 2', description: 'Description 2'),
        ],
        centerWidget: const InfoCard(
          title: 'this is info card',
          type: InfoType.info,
          description: 'details about the component',
        ),
        additionalWidget: const InfoCard(
          title: 'this is info card',
          type: InfoType.info,
          description: 'details about the component',
        ),
        showIconOnRight:
            context.knobs.boolean(label: 'Show Icon On Right', initial: true),
        heading: 'Matrix Component',
        actions: [
          ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Landing Page Card/List of Matrix Card',
      builder: (context) => MatrixListScrollComponent(
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
      ),
    ),
  ];
}
