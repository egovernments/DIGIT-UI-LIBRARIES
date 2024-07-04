import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/panel.dart';
import 'package:digit_ui_components/widgets/molecules/panel_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> panelCardStories() {
  return [
    Story(
      name: 'Molecule/Panel Card/Success/Default',
      builder: (context) =>
       PanelCard(type: PanelType.success, title: context.knobs.text(label: 'Title', initial: 'Success Message'),),
    ),
    Story(
      name: 'Molecule/Panel Card/Success/With Description',
      builder: (context) => PanelCard(
        type: PanelType.success,
        title: 'Success Message',
        description: context.knobs.text(label: 'Description', initial: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Success/With action',
      builder: (context) => PanelCard(
        type: PanelType.success,
        title: 'Success Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Success/With description and action',
      builder: (context) => PanelCard(
        type: PanelType.success,
        title: 'Success Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Success/With additional widgets',
      builder: (context) => PanelCard(
        type: PanelType.success,
        title: 'Success Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
        additionWidgets: const [
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.')
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Success/Action not inline',
      builder: (context) => PanelCard(
        type: PanelType.success,
        title: 'Success Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        inlineActions: context.knobs.boolean(label: 'Inline', initial: false),
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
            label: 'Cancel',
            onPressed: () {},
            type: ButtonType.secondary,
            size: ButtonSize.large,
            mainAxisSize: MainAxisSize.max,
          ),
          Button(
            label: 'Submit',
            onPressed: () {},
            type: ButtonType.primary,
            size: ButtonSize.large,
            mainAxisSize: MainAxisSize.max,
          )
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Success/With scroll',
      builder: (context) => PanelCard(
        type: PanelType.success,
        title: 'Success Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
        additionWidgets: const [
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Success', type: InfoType.success, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Error/Default',
      builder: (context) =>
      const PanelCard(type: PanelType.error, title: 'Error Message', animate: true, repeat: true,),
    ),
    Story(
      name: 'Molecule/Panel Card/Error/With description',
      builder: (context) => PanelCard(
        type: PanelType.error,
        title: 'Error Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Error/With action',
      builder: (context) => PanelCard(
        type: PanelType.error,
        title: 'Error Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Error/With description and action',
      builder: (context) => PanelCard(
        type: PanelType.error,
        title: 'Error Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Error/With additional widgets',
      builder: (context) => PanelCard(
        type: PanelType.error,
        title: 'Error Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
        additionWidgets: const [
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.')
        ],
      ),
    ),
    Story(
      name: 'Molecule/Panel Card/Error/With scroll',
      builder: (context) => PanelCard(
        type: PanelType.error,
        title: 'Error Message',
        additionalDetails: [
          Text(
            'Ref ID',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: const DigitColors().light.paperPrimary),
          ),
          Text(
            '949749795479',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: const DigitColors().light.paperPrimary),
          )
        ],
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        actions: [
          Button(
              label: 'Cancel',
              onPressed: () {},
              type: ButtonType.secondary,
              size: ButtonSize.large),
          Button(
              label: 'Submit',
              onPressed: () {},
              type: ButtonType.primary,
              size: ButtonSize.large)
        ],
        additionWidgets: const [
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
          InfoCard(title: 'Error', type: InfoType.error, description: 'The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern.'),
        ],
      ),
    ),
  ];
}