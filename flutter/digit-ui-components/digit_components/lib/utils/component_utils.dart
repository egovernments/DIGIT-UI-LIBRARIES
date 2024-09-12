import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitComponentsUtils {
  static void hideDialog(BuildContext context) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).popUntil(
          (route) => route is! PopupRoute,
    );
  }

  static void showDialog(
      BuildContext context, String? label, DialogType dialogType) {
    DigitSyncDialog.show(
      context,
      type: dialogType,
      label: label,
    );
  }

}


class DigitSyncDialog {
  static Future<T?> show<T>(
      BuildContext context, {
        Key? key,
        bool barrierDismissible = false,
        required DialogType type, String? label,
        DigitDialogActions? primaryAction,
        DigitDialogActions? secondaryAction,
      }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: const DigitColors().overLayColor.withOpacity(.70),
      builder: (context) => DigitSyncDialogContent(type: type, label: label, primaryAction: primaryAction, secondaryAction: secondaryAction),
    );
  }

}

class DigitSyncDialogContent extends StatelessWidget {
  final String? label;
  final DialogType type;

  final DigitDialogActions? primaryAction;
  final DigitDialogActions? secondaryAction;

  const DigitSyncDialogContent({
    super.key,
    this.label,
    required this.type,
    this.primaryAction,
    this.secondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    IconData icon;
    Color color;
    TextStyle? labelStyle;

    switch (type) {
      case DialogType.inProgress:
        icon = Icons.autorenew;
        color = theme.colorTheme.primary.primary1;
        labelStyle = textTheme.headingM;
        break;
      case DialogType.complete:
        icon = Icons.check_circle_outline;
        color = theme.colorTheme.alert.success;
        labelStyle = textTheme.headingM;
        break;
      case DialogType.failed:
        icon = Icons.error_outline;
        color = theme.colorTheme.alert.error;
        labelStyle = textTheme.headingM;
        break;
    }

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(spacer4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: theme.colorTheme.paper.primary,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.16),
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
            [
              Icon(icon, size: 32, color: color),
              if(label != null)
                ...[ const SizedBox(height: spacer4),
                  Text(label!, style: labelStyle?.copyWith(color: color)),]
            ],
          )
        ),
      ),
    );
  }
}

enum DialogType { inProgress, complete, failed }

class DigitDialogActions<T> {
  final String label;
  final T Function(BuildContext context)? action;

  const DigitDialogActions({
    required this.label,
    this.action,
  });
}
