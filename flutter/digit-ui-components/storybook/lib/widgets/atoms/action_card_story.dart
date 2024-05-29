import 'package:digit_ui_components/widgets/atoms/action_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> actionStories() {
  return [
    Story(
      name: 'Atom/Action/1',
      builder: (context) =>  ActionCard(
        actions: [
          ActionItem(
            text: 'Assign as household head',
            onTap: () {
              // Define what should happen when the primary action is tapped
              print('Primary Action 1 tapped');
            },
            icon: Icons.person,
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Action/2',
      builder: (context) =>  ActionCard(
        actions: [
          ActionItem(
            text: 'Assign as household head',
            onTap: () {
              // Define what should happen when the primary action is tapped
              print('Primary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Edit Individual Details',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.edit,
          ),
          ActionItem(
            text: 'Delete Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.delete,
          ),
          // Add more action items as needed
        ],
      ),
    ),
    Story(
      name: 'Atom/Action/3',
      builder: (context) =>  ActionCard(
        actions: [
          ActionItem(
            text: 'Assign as household head',
            onTap: () {
              // Define what should happen when the primary action is tapped
              print('Primary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Edit Individual Details',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.edit,
          ),
          ActionItem(
            text: 'Delete Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.delete,
          ),
          ActionItem(
            text: 'Manage Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Register Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
        ],
      ),
    ),
    Story(
      name: 'Atom/Action/4',
      builder: (context) =>  ActionCard(
        isScrollable: true,
        actions: [
          ActionItem(
            text: 'Assign as household head',
            onTap: () {
              // Define what should happen when the primary action is tapped
              print('Primary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Edit Individual Details',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.edit,
          ),
          ActionItem(
            text: 'Delete Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.delete,
          ),
          ActionItem(
            text: 'Manage Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Register Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Assign as household head',
            onTap: () {
              // Define what should happen when the primary action is tapped
              print('Primary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Edit Individual Details',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.edit,
          ),
          ActionItem(
            text: 'Delete Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.delete,
          ),
          ActionItem(
            text: 'Manage Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Register Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Assign as household head',
            onTap: () {
              // Define what should happen when the primary action is tapped
              print('Primary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Edit Individual Details',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.edit,
          ),
          ActionItem(
            text: 'Delete Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.delete,
          ),
          ActionItem(
            text: 'Manage Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
          ActionItem(
            text: 'Register Individual',
            onTap: () {
              // Define what should happen when the secondary action is tapped
              print('Secondary Action 1 tapped');
            },
            icon: Icons.person,
          ),
        ],
      ),
    ),
  ];
}
