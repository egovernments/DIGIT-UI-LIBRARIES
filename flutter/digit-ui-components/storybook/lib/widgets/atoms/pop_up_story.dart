import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_cart.dart';
import 'package:digit_ui_components/widgets/molecules/pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> popUpStories() {
  return [
    Story(
      name: 'Atom/PopUp/default/simple',
      builder: (context) => Popup(
        title: context.knobs.text(label: 'Title', initial: 'Title'),
        subHeading: context.knobs.text(label: 'SubTitle', initial: 'SubTitle'),
        description: context.knobs.text(label: 'Description', initial: 'description'),
        primaryActionText: 'Submit',
        secondaryActionText: 'Cancel',
        onCrossTap: () {
          print('cross icon tap');
        },
        onPrimaryAction: () {
          print('primary tap');
        },
        onSecondaryAction: () {
          print('secondary tap');
        },
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/icon&description',
      builder: (context) =>  Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: Icon(
          Icons.error_outline,
          size: 32,
        ),
        primaryActionText: 'Submit',
        secondaryActionText: 'Cancel',
        onCrossTap: () {
          print('cross icon tap');
        },
        // onPrimaryAction: () {
        //   print('primary tap');
        // },
        // onSecondaryAction: () {
        //   print('secondary tap');
        // },
        description:
        'sdfffffffffffffffffffffffffffffdsfffffffffffffdsfsdfsdddddddddddd',
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with additional widgets',
      builder: (context) =>  Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: Icon(
          Icons.error_outline,
          size: 32,
        ),
        primaryActionText: 'Submit',
        secondaryActionText: 'Cancel',
        onCrossTap: () {
          print('cross icon tap');
        },
        onPrimaryAction: () {
          print('primary tap');
        },
        onSecondaryAction: () {
          print('secondary tap');
        },
        additionalWidgets: [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with description and additional widgets',
      builder: (context) => Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: Icon(
          Icons.error_outline,
          size: 32,
        ),
        primaryActionText: 'Submit',
        secondaryActionText: 'Cancel',
        onCrossTap: () {
          print('cross icon tap');
        },
        onPrimaryAction: () {
          print('primary tap');
        },
        onSecondaryAction: () {
          print('secondary tap');
        },
        description:
        'sdfffffffffffffffffffffffffffffdsfffffffffffffdsfsdfsdddddddddddd',
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/without Action',
      builder: (context) => const Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: Icon(
          Icons.error_outline,
          size: 32,
        ),
        description:
        'sdfffffffffffffffffffffffffffffdsfffffffffffffdsfsdfsdddddddddddd',
        additionalWidgets: [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert',
      builder: (context) =>  const Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
      ),
    ),
  ];
}
