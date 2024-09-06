import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card.dart';
import 'package:digit_ui_components/widgets/molecules/language_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> languageSelectionCardStories() {
  return [
    Story(
      name: 'Molecule/Landing Pag3e Card/1',
      builder: (context) =>  MatrixListComponent(
        icon: Icons.supervisor_account,
        filledIcon: context.knobs.boolean(label: 'Filled Icon', initial: true),
        showIconOnRight: context.knobs.boolean(label: 'Show Icon On Right', initial: true),
        heading: 'Matrix Component',
        matrixList: [
          MatrixModel(title: 'Matrix 1', description: 'Description of Matrix 1'),
          MatrixModel(title: 'Matrix 2', description: 'Description of Matrix 2'),
        ],
        actions: [
          ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
          ActionItem(label: 'Action 2', onPressed: () {}),
        ],
      ),
    ),
  ];
}