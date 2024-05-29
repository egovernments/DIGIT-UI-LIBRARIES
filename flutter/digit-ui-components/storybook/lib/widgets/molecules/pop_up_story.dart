import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/action_card.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_cart.dart';
import 'package:digit_ui_components/widgets/molecules/pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> showPopUPStories() {
  return [
    Story(
      name: 'Molecule/show/action',
      builder: (context) =>  ElevatedButton(
        onPressed: () {
          showActionCard(
            isScrollable: true,
            context: context,
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
              // Add more action items as needed
            ],
          );
        },
        child: Text("Show Simple Popup"),
      ),
    ),
    Story(
      name: 'Molecule/show/popUp',
      builder: (context) =>  ElevatedButton(
        onPressed: () {
          showPopup(
            context: context,
            title: "Simple Popup",
            subHeading: "This is a subheading",
            description: "This popup demonstrates a simple popup with a title and description.",
            type: PopUpType.simple,
          );
        },
        child: Text("Show Simple Popup"),
      ),
    ),
  ];
}
