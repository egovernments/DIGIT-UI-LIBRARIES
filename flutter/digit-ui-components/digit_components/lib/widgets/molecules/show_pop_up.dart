import 'dart:ui';
import 'package:digit_ui_components/widgets/atoms/action_card.dart';
import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../../theme/colors.dart';
import '../atoms/digit_button.dart';
import '../atoms/pop_up_card.dart';

void showPopup({
   required final BuildContext context,
  required final String title,
  required final PopUpType type,
  final double? width,
  final double? height,
  final Icon? titleIcon,
  final String? subHeading,
  final String? description,
  final List<Widget>? additionalWidgets,
  final List<Button>? actions,
  final void Function()? onCrossTap,
  final bool? inlineAction,
  final MainAxisAlignment? actionAlignment,
  final double? actionSpacing,
}) {
  showDialog(
    context: context,
    barrierColor: const DigitColors().overLayColor.withOpacity(.70),
    builder: (BuildContext currentContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Popup(
          title: title,
          type: type,
          titleIcon: titleIcon,
          subHeading: subHeading,
          width: width,
          height: height,
          description: description,
          additionalWidgets: additionalWidgets,
          actions: actions,
          inlineActions: inlineAction,
          actionAlignment: actionAlignment,
          actionSpacing: actionSpacing,
          onCrossTap: () {
            if (Navigator.of(currentContext).mounted) {
              Navigator.of(currentContext).pop();
            }
          },
        ),
      );
    },
  );
}

void showActionCard({
  required final BuildContext context,
  required final List<Button> actions,
  final double? width,
  final double? height,
  final double? spacing,
}) {
  showDialog(
    context: context,
    barrierColor: const DigitColors().overLayColor.withOpacity(.70),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: ActionCard(
          actions: actions,

        ),
      );
    },
  );
}