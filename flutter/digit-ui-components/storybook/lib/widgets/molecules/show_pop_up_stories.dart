import 'dart:ui';

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';

List<Story> showPopUPStories() {
  return [
    Story(
      name: 'Molecule/Show Pop Up/Basic',
      builder: (context){

         bool withIcon = context.knobs.boolean(label: 'Icon for heading', initial: false);
         bool description = context.knobs.boolean(label: 'Description', initial: false);
         bool actions = context.knobs.boolean(label: 'Actions', initial: false);
         bool close = context.knobs.boolean(label: 'Close', initial: false);

        return DigitButton(
          type: DigitButtonType.secondary,
          size: DigitButtonSize.large,
          label: 'Click to open popup',
          onPressed: () {
            showCustomPopup(
              context: context,
              builder: (popupContext) => Popup(
                title: "Simple Popup",
                onOutsideTap: () {
                  Navigator.of(popupContext).pop();
                },
                titleIcon: withIcon ? Icon(Icons.article, size: 32,) : null,
                onCrossTap: close ? (){
                  Navigator.of(popupContext).pop();
                } : null,
                subHeading: "This is a subheading",
                description:
                description ? "This popup demonstrates a simple popup with a title and description." : null,
                type: PopUpType.simple,
                actions: actions ? [
                  DigitButton(
                    label: 'Submit',
                    onPressed: () {
                      Navigator.of(popupContext)
                          .pop(); // Use popupContext to close the popup
                    },
                    type: DigitButtonType.primary,
                    size: DigitButtonSize.large,
                  ),
                ] : null ,
              ),
            );
          },
        );
      },
    ),
    Story(
      name: 'Molecule/Show Pop Up/Alert',
      builder: (context){
        bool withIcon = context.knobs.boolean(label: 'Icon for heading', initial: false);
        bool description = context.knobs.boolean(label: 'Description', initial: false);
        bool actions = context.knobs.boolean(label: 'Actions', initial: false);
        bool close = context.knobs.boolean(label: 'Close', initial: false);

        return DigitButton(
          type: DigitButtonType.secondary,
          size: DigitButtonSize.large,
          label: 'Click to open alert popup',
          onPressed: () {
            showCustomPopup(
              context: context,
              builder: (popupContext) => Popup(
                title: "Alert Popup",
                titleIcon: withIcon ? Icon(Icons.article, size: 32,) : null,
                onCrossTap: close ? (){
                  Navigator.of(popupContext).pop();
                } : null,
                onOutsideTap: () {
                  Navigator.of(popupContext).pop();
                },
                subHeading: "This is a subheading",
                description:
                description ? "This popup demonstrates a alert popup with a title and description." : null,
                type: PopUpType.alert,
                actions: actions ? [
                  DigitButton(
                    label: 'Submit',
                    onPressed: () {
                      Navigator.of(popupContext)
                          .pop(); // Use popupContext to close the popup
                    },
                    type: DigitButtonType.primary,
                    size: DigitButtonSize.large,
                  ),
                ] : null,
              ),
            );
          },
        );
      },
    ),
  ];
}
