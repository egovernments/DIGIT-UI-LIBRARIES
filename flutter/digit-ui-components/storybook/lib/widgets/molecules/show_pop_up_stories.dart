import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> showPopUPStories() {
  return [
    Story(
      name: 'Molecule/show/action',
      builder: (context) =>  ElevatedButton(
        onPressed: () {
          showActionCard(
            context: context,
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
          );
        },
        child: const Text("Show Simple Popup"),
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
        child: const Text("Show Simple Popup"),
      ),
    ),
  ];
}