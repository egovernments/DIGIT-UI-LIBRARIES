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
          showPopup(
            context: context,
            title: "Simple Popup",
            subHeading: "This is a subheading",
            description:
                "This popup demonstrates a simple popup with a title and description.",
            type: PopUpType.simple,
          );
        },
        child: const Text("Show Simple Popup"),
      ),
    ),
    Story(
      name: 'Molecule/Show Pop Up/Alert',
      builder: (context) => ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: const DigitColors().overLayColor.withOpacity(.70),
            builder: (BuildContext currentContext) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Popup(
                  title: 'Alert!',
                  subHeading: 'Please contact the administrator if you have any query.',
                  type: PopUpType.alert,
                  actions: [Button(label: 'OK', onPressed: (){
                    Navigator.of(currentContext).pop();
                  }, type: ButtonType.primary, size: ButtonSize.large)],
                ),
              );
            },
          );
        },
        child: const Text("Show alert Popup"),
      ),
    ),
  ];
}
