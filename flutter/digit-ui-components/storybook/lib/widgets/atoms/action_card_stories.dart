import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/atoms/action_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> actionStories() {
  return [
    Story(
      name: 'Atom/Action/1',
      builder: (context) =>  ActionCard(
        actions: [
          Button(
            size: ButtonSize.large,
            type: ButtonType.secondary,
            label: 'Assign as household head',
            onPressed: () {},
            prefixIcon: Icons.person,
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Action/2',
      builder: (context) =>  ActionCard(
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
          // Add more action items as needed
        ],
      ),
    ),
    Story(
      name: 'Atom/Action/scroll',
      builder: (context) =>  ActionCard(
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
        ],
      ),
    ),
    Story(
      name: 'Atom/Action/custom width and height',
      builder: (context) =>  ActionCard(
        width: 900,
        height: 900,
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
      ),
    ),
  ];
}