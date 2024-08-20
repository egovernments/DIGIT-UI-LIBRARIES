import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required Widget content,
  void Function(BuildContext context)? onPrimaryAction,
  void Function(BuildContext context)? onSecondaryAction,
}) {
  Navigator.of(context).push(
    _CustomBottomSheetRoute(
      content: content,
      onPrimaryAction: onPrimaryAction,
      onSecondaryAction: onSecondaryAction,
    ),
  );
}

class _CustomBottomSheetRoute extends PopupRoute<void> {
  final Widget content;
  final void Function(BuildContext context)? onPrimaryAction;
  final void Function(BuildContext context)? onSecondaryAction;

  _CustomBottomSheetRoute({
    required this.content,
    this.onPrimaryAction,
    this.onSecondaryAction,
  });

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return CustomBottomSheet(
      content: content,
      onPrimaryAction: onPrimaryAction,
      onSecondaryAction: onSecondaryAction,
    );
  }
}
