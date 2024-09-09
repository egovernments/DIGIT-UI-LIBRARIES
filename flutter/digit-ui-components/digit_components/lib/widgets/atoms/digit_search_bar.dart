import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/colors.dart';
import '../../theme/spacers.dart';

class DigitSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? hintText;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final Widget? icon;
  final List<TextInputFormatter>? inputFormatters;

  const DigitSearchBar({
    super.key,
    this.controller,
    this.padding,
    this.margin,
    this.hintText,
    this.contentPadding,
    this.borderRadius,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.icon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacer3),
        color:  const DigitColors().light.paperPrimary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.16),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon ??
                 Icon(
                  Icons.search,
                  size: 24,
                  color: theme.colorTheme.text.primary,
                ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText ?? 'Enter the field details',
                filled: false,
                contentPadding: contentPadding ??
                    const EdgeInsets.only(
                      left: 0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}