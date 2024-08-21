import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/action_card_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/atoms/digit_action_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> actionStories() {
  return [
    Story(
      name: 'Atom/Action/1',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
ActionCard(
  actions: [
    Button(
      size: ButtonSize.large,
      type: ButtonType.secondary,
      label: 'Assign as household head',
      onPressed: () {},
      prefixIcon: Icons.person,
    ),
  ],
)
          ''');
        });

        return ActionCard(
          actions: [
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/Action/2',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
ActionCard(
  actions: [
    Button(
      size: ButtonSize.large,
      type: ButtonType.secondary,
      label: 'Assign as household head',
      onPressed: () {},
      prefixIcon: Icons.person,
    ),
    Button(
      size: ButtonSize.large,
      type: ButtonType.secondary,
      label: 'Edit Individual Details',
      onPressed: () {},
      prefixIcon: Icons.edit,
    ),
    Button(
      size: ButtonSize.large,
      type: ButtonType.secondary,
      label: 'Delete Individual',
      onPressed: () {},
      prefixIcon: Icons.delete,
    ),
  ],
)
          ''');
        });

        return ActionCard(
          actions: [
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/Action/scroll',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
ActionCard(
  actions: [
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
        ],
)
          ''');
        });

        return ActionCard(
          actions: [
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/Action/custom width and height',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
ActionCard(
  actionCardTheme: const DigitActionCardTheme().copyWith(
    context: context,
    width: 700,
    height: 600,
  ),
  actions: [
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
        ],
)
          ''');
        });

        return ActionCard(
          actionCardTheme: const DigitActionCardTheme().copyWith(
            context: context,
            width: 700,
            height: 600,
          ),
          actions: [
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            Button(
              size: ButtonSize.large,
              type: ButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
          ],
        );
      },
    ),
  ];
}
