import 'package:flutter/material.dart';

class MobileHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget actions;

  const MobileHeader({
    Key? key,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return actions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}


class DesktopHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget actions;

  const DesktopHeader({
    Key? key,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return actions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

enum HeaderType {
  light,
  dark,
}
