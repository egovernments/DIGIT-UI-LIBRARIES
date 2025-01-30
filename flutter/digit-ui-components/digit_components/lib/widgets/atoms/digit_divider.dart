import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitDivider extends StatelessWidget {
  final DividerType dividerType;
  final DividerOrientation dividerOrientation;
  final DigitDividerThemeData? dividerThemeData;
  final String? semanticLabel;

  const DigitDivider({
    Key? key,
    this.dividerType = DividerType.medium,
    this.dividerOrientation = DividerOrientation.horizontal,
    this.dividerThemeData,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = dividerThemeData ??
        theme.extension<DigitDividerThemeData>() ??
        const DigitDividerThemeData();

    final double thickness = dividerType == DividerType.medium
        ? themeData.mediumDividerThickness
        : dividerType == DividerType.large
        ? themeData.largeDividerThickness
        : themeData.smallDividerThickness;

    return Semantics(
      label: semanticLabel,
      child: Container(
        width: dividerOrientation == DividerOrientation.horizontal
            ? themeData.width
            : thickness,
        height: dividerOrientation == DividerOrientation.horizontal
            ? thickness
            : themeData.height,
        color: themeData.color ?? theme.colorTheme.generic.divider,
        margin: EdgeInsets.only(
          left: themeData.indent,
          right: themeData.endIndent,
        ),
      ),
    );
  }
}