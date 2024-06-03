import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final HeaderType type;
  final IconData? leadingIcon;
  final List<Widget>? actions;

  const CustomHeader({
    Key? key,
    this.type = HeaderType.light,
    this.leadingIcon,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: type == HeaderType.light ? const DigitColors().light.paperPrimary : const DigitColors().light.primary2,
        boxShadow: type == HeaderType.light ? [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.15),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ] : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions != null ? actions! : [],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

enum HeaderType {
  light,
  dark,
}
