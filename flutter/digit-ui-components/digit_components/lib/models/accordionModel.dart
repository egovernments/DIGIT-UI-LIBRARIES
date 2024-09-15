import 'package:flutter/material.dart';

class DigitAccordionItem {
  final Widget header;
  final Widget content;
  final bool divider;
  final bool initiallyExpanded;
  final bool showBorder;

  DigitAccordionItem({
    required this.header,
    required this.content,
    this.divider = false,
    this.initiallyExpanded = false,
    this.showBorder = true,
  });
}