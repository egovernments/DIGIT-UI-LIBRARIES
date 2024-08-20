import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:digit_ui_components/widgets/molecules/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';


List<Story> bottomSheetStories() {
  return [
    Story(
      name: 'Molecule/Bottom Sheet',
      builder: (context) {
        bool isSwitched = false;
        return ElevatedButton(
          onPressed: () {
            showCustomBottomSheet(
              context: context,
              content: Center(child: Text('This is 100% height')),
            );
          },
          child: Text('Show 100% Bottom Sheet'),
        );
      },
    ),
    Story(
      name: 'Molecule/Bottom Sheet with actions',
      builder: (context) {
        bool isSwitched = false;
        return ElevatedButton(
          onPressed: () {
            showCustomBottomSheet(
              context: context,
              content: Center(child: Text('This is 100% height')),
              onPrimaryAction: (context) {

              },
              onSecondaryAction: (context) {

              }
            );
          },
          child: Text('Show 100% Bottom Sheet'),
        );
      },
    ),
  ];
}
