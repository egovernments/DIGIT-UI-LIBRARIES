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
            context: context,
            actions: [],
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
