import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/action_card_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_action_card.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';


List<Story> actionStories() {
  return [
    Story(
      name: 'Molecule/Action Card/Basic',
      builder: (context) {
        return DigitActionCard(
          actions:
          [
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 1',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 2',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 3',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 4',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 5',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Molecule/Action Card/custom width and height',
      builder: (context) {
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
              label: 'Lorem Ipsum/Action 1',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 2',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 3',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 4',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 5',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 1',
              onPressed: () {},
              prefixIcon: Icons.person,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 2',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 3',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 4',
              onPressed: () {},
              prefixIcon: Icons.edit,
            ),
            DigitButton(
              size: DigitButtonSize.large,
              type: DigitButtonType.secondary,
              label: 'Lorem Ipsum/Action 5',
              onPressed: () {},
              prefixIcon: Icons.delete,
            ),
          ],
        );
      },
    ),
  ];
}
