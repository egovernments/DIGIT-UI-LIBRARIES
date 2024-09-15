import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitDivider extends StatelessWidget {
  final DividerType dividerType;
  final DigitDividerThemeData? dividerThemeData;

  const DigitDivider({
    Key? key,
    this.dividerType = DividerType.medium,
    this.dividerThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final theme = Theme.of(context);
    final themeData = dividerThemeData ??
        theme.extension<DigitDividerThemeData>() ?? const DigitDividerThemeData();

    return Container(
      padding: EdgeInsets.only(left: themeData.indent, right: themeData.endIndent),
      width: themeData.width,
      height: dividerType == DividerType.medium ? themeData.mediumDividerThickness : dividerType == DividerType.large ? themeData.largeDividerThickness : themeData.smallDividerThickness,
      color: themeData.color ?? theme.colorTheme.generic.divider,
    );
  }
}