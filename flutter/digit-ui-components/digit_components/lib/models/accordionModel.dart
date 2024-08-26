import 'package:flutter/material.dart';

class DigitAccordionItem {
  final Widget header;
  final Widget content;
  final bool initiallyExpanded;

  DigitAccordionItem({
    required this.header,
    required this.content,
    this.initiallyExpanded = false,
  });
}