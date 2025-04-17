import 'package:flutter/material.dart';

class DigitAccordionItem {
  final Widget header;
  final String? semanticLabel;
  final Widget content;
  final bool divider;
  final bool initiallyExpanded;
  final bool showBorder;

  DigitAccordionItem({
    required this.header,
    this.semanticLabel,
    required this.content,
    this.divider = false,
    this.initiallyExpanded = false,
    this.showBorder = true,
  });
}