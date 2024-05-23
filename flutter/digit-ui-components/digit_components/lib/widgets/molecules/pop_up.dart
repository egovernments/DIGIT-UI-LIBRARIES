import 'dart:ui';
import 'package:digit_ui_components/widgets/atoms/action_card.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../atoms/pop_up_cart.dart';

void showPopup({
  required BuildContext context,
  required String title,
  required PopUpType type,
  Icon? titleIcon,
  String? subHeading,
  String? description,
  List<Widget>? additionalWidgets,
  String? primaryActionText,
  String? secondaryActionText,
  void Function()? onCrossTap,
  void Function()? onPrimaryAction,
  void Function()? onSecondaryAction,
}) {
  showDialog(
    context: context,
    barrierColor: const DigitColors().overLayColor.withOpacity(.70),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Popup(
          title: title,
          type: type,
          titleIcon: titleIcon,
          subHeading: subHeading,
          description: description,
          additionalWidgets: additionalWidgets,
          primaryActionText: primaryActionText,
          secondaryActionText: secondaryActionText,
          onCrossTap: () {
            if (Navigator.of(context).mounted) {
              Navigator.of(context).pop();
            }
          },
          onPrimaryAction: onPrimaryAction,
          onSecondaryAction: onSecondaryAction,
        ),
      );
    },
  );
}

void showActionCard({
  required BuildContext context,
  required List<ActionItem> actions,
  final double? width,
}) {
  showDialog(
    context: context,
    barrierColor: const DigitColors().overLayColor.withOpacity(.70),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: ActionCard(
          actions: actions,
          width: width,
        ),
      );
    },
  );
}


