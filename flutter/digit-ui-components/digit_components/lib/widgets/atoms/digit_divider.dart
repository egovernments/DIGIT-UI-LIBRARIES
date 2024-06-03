import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class DigitDivider extends StatelessWidget {
  final double? thickness;
  final DividerType dividerType;
  final Color? color;
  final double indent;
  final double endIndent;

  /// Optional width parameter
  final double? width;

  const DigitDivider({
    Key? key,
    this.thickness,
    this.dividerType = DividerType.medium,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: Container(
        width: width, /// Use the provided width if available, otherwise take full width
        height: thickness ?? (dividerType == DividerType.medium ? 2 : dividerType == DividerType.large ? 4 : 1),
        color: color ?? const DigitColors().light.genericDivider,
      ),
    );
  }
}
