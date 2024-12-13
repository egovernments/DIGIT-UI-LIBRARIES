import 'dart:ui';
import 'package:digit_ui_components/widgets/atoms/digit_action_card.dart';
import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../../theme/colors.dart';
import '../atoms/digit_button.dart';
import '../atoms/pop_up_card.dart';

Future<dynamic> showCustomPopup({
  required BuildContext context,
  required Widget Function(BuildContext) builder,  // Pass builder instead of child
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
}) async
{
  return showGeneralDialog<dynamic>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    barrierColor: const DigitColors().overLayColor.withOpacity(.70), // Overlay color
    pageBuilder: (BuildContext dialogContext, Animation<double> animation, Animation<double> secondaryAnimation)
    {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: builder(dialogContext),  // Provide the dialog context to the builder
      );
    },
    transitionDuration: transitionDuration,
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child)
    {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        child: child,
      );
    },
  );
}

