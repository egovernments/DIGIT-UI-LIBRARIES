import 'dart:ui';

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> showPopUPStories() {
  return [
    Story(
      name: 'Molecule/Show Pop Up/Default',
      builder: (context) => ElevatedButton(
        onPressed: () {
          showCustomPopup(
            context: context,
            builder: (popupContext) => Popup(
              title: "Simple Popup",
              onOutsideTap: () {
                Navigator.of(popupContext).pop();
              },
              subHeading: "This is a subheading",
              description:
              "This popup demonstrates a simple popup with a title and description.",
              type: PopUpType.simple,
              actions: [
                Button(
                  label: 'Submit',
                  onPressed: () {
                    Navigator.of(popupContext)
                        .pop(); // Use popupContext to close the popup
                  },
                  type: ButtonType.primary,
                  size: ButtonSize.large,
                ),
              ],
            ),
          );
        },
        child: const Text("Show Simple Popup"),
      ),
    ),
    Story(
      name: 'Molecule/Show Pop Up/Alert',
      builder: (context) => ElevatedButton(
        onPressed: () {
          showCustomPopup(
            context: context,
            builder: (popupContext) => Popup(
              title: 'Alert!',
              onOutsideTap: () {
                Navigator.of(popupContext).pop();
              },
              subHeading:
              'Please contact the administrator if you have any query.',
              type: PopUpType.alert,
              actions: [
                Button(
                    label: 'OK',
                    onPressed: () {
                      Navigator.of(popupContext).pop();
                    },
                    type: ButtonType.primary,
                    size: ButtonSize.large)
              ],
            ),
          );
        },
        child: const Text("Show Simple Popup"),
      ),
    ),
  ];
}