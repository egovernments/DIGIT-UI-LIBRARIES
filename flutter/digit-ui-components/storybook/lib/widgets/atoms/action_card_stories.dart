import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/action_card_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_action_card.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
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
DigitActionCard(
  actions: [
    DigitButton(
      size: DigitButtonSize.large,
      type: DigitButtonType.secondary,
      label: 'Assign as household head',
      onPressed: () {},
      prefixIcon: Icons.person,
    ),
  ],
)
          ''');
        });

        return DigitActionCard(
          actions: [
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
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
DigitActionCard(
  actions: [
    DigitButton(
      size: DigitButtonSize.large,
      type: DigitButtonType.secondary,
      label: 'Assign as household head',
      onPressed: () {},
      prefixIcon: Icons.person,
    ),
    DigitButton(
      size: DigitButtonSize.large,
      type: DigitButtonType.secondary,
      label: 'Edit Individual Details',
      onPressed: () {},
      prefixIcon: Icons.edit,
    ),
    DigitButton(
      size: DigitButtonSize.large,
      type: DigitButtonType.secondary,
      label: 'Delete Individual',
      onPressed: () {},
      prefixIcon: Icons.delete,
    ),
  ],
)
          ''');
        });

        return DigitActionCard(
          actions: [
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
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
DigitActionCard(
  actions: [
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
        ],
)
          ''');
        });

        return DigitActionCard(
          actions: [
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
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
DigitActionCard(
  DigitActionCardTheme: const DigitDigitActionCardTheme().copyWith(
    context: context,
    width: 700,
    height: 600,
  ),
  actions: [
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Edit Individual Details',
            onPressed: () {},
            prefixIcon: Icons.edit,
          ),
          DigitButton(
            size: DigitButtonSize.large,
            type: DigitButtonType.secondary,
            label: 'Delete Individual',
            onPressed: () {},
            prefixIcon: Icons.delete,
          ),
        ],
)
          ''');
        });

        return DigitActionCard(
          digitActionCardTheme: const DigitDigitActionCardTheme().copyWith(
            context: context,
            width: 700,
            height: 600,
          ),
          actions: [
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Delete Individual',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Assign as household head',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Edit Individual Details',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
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
