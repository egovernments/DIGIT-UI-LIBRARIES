import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ChipConfig {
  final Icon? deleteIcon;
  // final Color deleteIconColor;
  // final Color labelColor;
  final Color? backgroundColor;
  // final TextStyle? labelStyle;
  final EdgeInsets padding;
  final EdgeInsets labelPadding;
  final double radius;
  final double spacing;
  final double runSpacing;
  final Widget? separator;
  final bool autoScroll;

  const ChipConfig({
    this.deleteIcon,
    // this.deleteIconColor = Colors.paperPrimary,
    this.backgroundColor,
    this.padding = Default.defaultChipPadding,
    this.radius = Default.defaultChipRadius,
    this.spacing = kPadding,
    this.runSpacing = kPadding,
    this.separator,
    // this.labelColor = Colors.paperPrimary,
    // this.labelStyle,
    this.labelPadding = EdgeInsets.zero,
    this.autoScroll = false,
  });
}
