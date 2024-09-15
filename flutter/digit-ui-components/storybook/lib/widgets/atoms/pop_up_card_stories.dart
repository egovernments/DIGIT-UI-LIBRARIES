import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/pop_up_card_theme.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> popUpStories() {
  return [
    Story(
      name: 'Atom/PopUp/default/simple',
      builder: (context) =>  Popup(
        title: context.knobs.text(label: 'Title', initial: 'Title'),
        subHeading: 'SubTitle',
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/description',
      builder: (context) => const Popup(
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/action',
      builder: (context) => Popup(
        title: context.knobs.text(label: 'Title', initial: 'Title'),
        subHeading: 'SubTitle',
        description:'description',
        onCrossTap: () {},
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/icon&description&action ',
      builder: (context) => Popup(
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {},
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with additional widgets',
      builder: (context) => const Popup(
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
        titleIcon: Icon(
          Icons.error_outline,
          size: 32,
        ),
        additionalWidgets: [
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
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {},
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/with description and additional widgets',
      builder: (context) => Popup(
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {},
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/without Action',
      builder: (context) => const Popup(
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
        titleIcon: Icon(
          Icons.error_outline,
          size: 32,
        ),
        additionalWidgets: [
          InfoCard(
              title: 'Info',
              type: InfoType.info,
              description: 'this is info card'),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/default/custom Height and Width',
      builder: (context) => Popup(
        popupTheme: const DigitPopupTheme().copyWith(
          context: context,
          width: 600,
          height: 800,
        ),
        title: 'Title',
        subHeading: 'SubTitle',
        description:'description',
        titleIcon: const Icon(
          Icons.error_outline,
          size: 32,
        ),
        onCrossTap: () {},
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
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/simple',
      builder: (context) => Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        actions: [DigitButton(label: 'OK', onPressed: (){}, type: DigitButtonType.primary, size: DigitButtonSize.large)],
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
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/inline action',
      builder: (context) => Popup(
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        inlineActions: true,
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
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
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
    Story(
      name: 'Atom/PopUp/alert/Custom Width and Height',
      builder: (context) => Popup(
        popupTheme: const DigitPopupTheme().copyWith(
          context: context,
          width: 600,
          height: 800,
        ),
        title: 'Alert!',
        subHeading: 'Please contact the administrator if you have fsdfsdf dsfs',
        type: PopUpType.alert,
        inlineActions: true,
        additionalWidgets: const [
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
          InfoCard(
              title: 'Info',
              type: InfoType.error,
              description: 'this is error card'),
        ],
        actions: [
          DigitButton(
              label: 'Submit',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: 'Cancel',
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large),
        ],
      ),
    ),
  ];
}