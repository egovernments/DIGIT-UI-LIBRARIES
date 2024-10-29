import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card_list.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> landingPageCardStories() {
  return [
    Story(
      name: 'Molecule/Landing Page Card/Basic',
      builder: (context) {

        final bool showMatrix = context.knobs.boolean(
            label: 'Show Matrix', initial: true);

        final bool showActions = context.knobs.boolean(
            label: 'Show Actions', initial: true);

        final bool showCustomWidget = context.knobs.boolean(
            label: 'Show Custom Widget', initial: false);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: MatrixListComponent(
            alignCenterMatrixList:
            context.knobs.boolean(label: 'Centered Matrix', initial: true),
            icon: Icons.supervisor_account,
            filledIcon: context.knobs.options<bool>(
              label: 'Icon',
              initial: true,
              options: const [
                Option(label: 'Filled', value: true),
                Option(label: 'Default', value: false),
              ],
            ),
            showIconOnRight: context.knobs.options<bool>(
              label: 'Icon alignment',
              initial: false,
              options: const [
                Option(label: 'Right', value: true),
                Option(label: 'Left', value: false),
              ],
            ),
            heading: context.knobs.text(label: 'Heading', initial: 'Heading'),
            matrixList: showMatrix ?[
              MatrixModel(
                  title: '30', description: 'Description of Matrix 1'),
              MatrixModel(
                  title: '30', description: 'Description of Matrix 2'),
            ] : null ,
            actions: showActions ? [
              ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
              ActionItem(label: 'Action 2', icon: Icons.edit, onPressed: () {}),
            ] : null,
            additionalWidget: showCustomWidget ? const InfoCard(
              title: 'this is a custom widget',
              type: InfoType.info,
              description: 'which provide details about the card',
            ) : null,
          ),
        );
      }
    ),
    Story(
        name: 'Molecule/Landing Page Card/Custom',
        builder: (context) {

          final bool showMatrix = context.knobs.boolean(
              label: 'Show Matrix', initial: true);

          final bool showActions = context.knobs.boolean(
              label: 'Show Actions', initial: true);

          final bool showCustomWidget = context.knobs.boolean(
              label: 'Show Custom Widget', initial: false);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: MatrixListComponent(
              alignCenterMatrixList:
              context.knobs.boolean(label: 'Centered Matrix', initial: true),
              icon: Icons.supervisor_account,
              filledIcon: context.knobs.options<bool>(
                label: 'Icon',
                initial: true,
                options: const [
                  Option(label: 'Filled', value: true),
                  Option(label: 'Default', value: false),
                ],
              ),
              showIconOnRight: context.knobs.options<bool>(
                label: 'Icon alignment',
                initial: false,
                options: const [
                  Option(label: 'Right', value: true),
                  Option(label: 'Left', value: false),
                ],
              ),
              heading: context.knobs.text(label: 'Heading', initial: 'Heading'),
              matrixList: showMatrix ?[
                MatrixModel(
                    title: '30', description: 'Description of Matrix 1'),
                MatrixModel(
                    title: '30', description: 'Description of Matrix 2'),
              ] : null ,
              actions: showActions ? [
                ActionItem(label: 'Action 1', icon: Icons.edit, onPressed: () {}),
                ActionItem(label: 'Action 2', icon: Icons.edit, onPressed: () {}),
              ] : null,
              additionalWidget: showCustomWidget ? const InfoCard(
                title: 'this is a custom widget',
                type: InfoType.info,
                description: 'which provide details about the card',
              ) : null,
            ),
          );
        }
    ),
    Story(
      name: 'Molecule/Landing Page Card Group/Basic',
      builder: (context) {
        // Dropdown to select the number of cards to display
        final numberOfCards = context.knobs.options<int>(
          label: 'Number of Cards',
          initial: 3,
          options: const [
            Option(label: '1 Card', value: 1),
            Option(label: '3 Cards', value: 3),
            Option(label: '5 Cards', value: 5),
            Option(label: '8 Cards', value: 8),
          ],
        );

        // Generate the list of MatrixListComponent based on selected number
        final matrixListComponents = List.generate(
          numberOfCards,
              (index) => MatrixListComponent(
            heading: 'Card ${index + 1}',
            alignCenterMatrixList: true,
            icon: Icons.supervisor_account,
            filledIcon: true,
            matrixList: [
              MatrixModel(title: '50', description: 'Description for matrix'),
              MatrixModel(title: '90', description: 'Description for matrix'),
            ],
            actions: [
              ActionItem(label: 'Action ${index + 1}', onPressed: () {}),
            ],
          ),
        );

        return MatrixListScrollComponent(
          matrixListComponents: matrixListComponents,
        );
      },
    ),

  ];
}
