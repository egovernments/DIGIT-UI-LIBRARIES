import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
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
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/description',
      builder: (context) => Popup(
        title: context.knobs.text(label: 'Title', initial: 'Title'),
        subHeading: context.knobs.text(label: 'SubTitle', initial: 'SubTitle'),
        description:
            context.knobs.text(label: 'Description', initial: 'description'),
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/action',
      builder: (context) => Popup(
        title: context.knobs.text(label: 'Title', initial: 'Title'),
        subHeading: context.knobs.text(label: 'SubTitle', initial: 'SubTitle'),
        description:
            context.knobs.text(label: 'Description', initial: 'description'),
        onCrossTap: () {
          print('cross icon tap');
        },
        actions: [
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large),
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/icon&description&action ',
      builder: (context) => Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {
          print('cross icon tap');
        },
        description:
            'sdfffffffffffffffffffffffffffffdsfffffffffffffdsfsdfsdddddddddddd',
        actions: [
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large),
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with additional widgets',
      builder: (context) => Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with additional widgets with action',
      builder: (context) => Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {
          print('cross icon tap');
        },
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
        actions: [
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large),
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with description and additional widgets',
      builder: (context) => Popup(
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {
          print('cross icon tap');
        },
        description:
            'sdfffffffffffffffffffffffffffffdsfffffffffffffdsfsdfsdddddddddddd',
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
        actions: [
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large),
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
      name: 'Atom/PopUp/default/scrollable',
      builder: (context) => Popup(
        //isScrollable: true,
        title: 'HHfffffff',
        subHeading: 'dsffffffff',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {
          print('cross icon tap');
        },
        description:
            'sdfffffffffffffffffffffffffffffdsfffffffffffffdsfsdfsdddddddddddd',
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
        actions: [
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large),
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/simple',
      builder: (context) => const Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/with additional widget',
      builder: (context) => const Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        additionalWidgets: [
          InfoCard(
              title: 'Error',
              type: InfoType.error,
              description: 'this is error')
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/action',
      builder: (context) => Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/inline action',
      builder: (context) => Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        inlineActions: true,
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/with additional widget & action',
      builder: (context) => Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        additionalWidgets: const [
          InfoCard(
              title: 'Error',
              type: InfoType.error,
              description: 'this is error')
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/scrollable',
      builder: (context) => Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        inlineActions: true,
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
      ),
    ),
  ];
}
