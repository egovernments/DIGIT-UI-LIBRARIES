import 'dart:math';

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../atoms/digit_button.dart';
import 'digit_card.dart';

class DigitLanguageCard extends StatelessWidget {
  final List<DigitRowCardModel> digitRowCardItems;
  final ValueChanged<DigitRowCardModel>? onLanguageChange;
  final VoidCallback onLanguageSubmit;
  final String languageSubmitLabel;
  final Widget? appLogo;
  final double? rowItemWidth;

  const DigitLanguageCard({
    super.key,
    required this.digitRowCardItems,
    this.onLanguageChange,
    required this.onLanguageSubmit,
    required this.languageSubmitLabel,
    this.appLogo,
    this.rowItemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return DigitCard(
      padding: const EdgeInsets.symmetric(
        vertical: spacer4,
        horizontal: spacer4,
      ),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appLogo ?? const SizedBox.shrink(),
            if(appLogo != null) const SizedBox(height: spacer4,),
            DigitRowCard(
              spacing: spacer4,
              alignment: WrapAlignment.spaceBetween,
              onChanged: onLanguageChange,
              rowItems: digitRowCardItems,
              width: rowItemWidth,
            ),
            const SizedBox(height: spacer4,),
            DigitButton(
              mainAxisSize: MainAxisSize.max,
              label: languageSubmitLabel,
              onPressed: onLanguageSubmit,
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
          ],
        )
      ],
    );
  }
}

class DigitRowCardModel {
  final String label;
  final String value;
  bool isSelected;

  DigitRowCardModel({
    required this.label,
    required this.value,
    this.isSelected = false,
  });
}

class DigitRowCard extends StatefulWidget {
  final List<DigitRowCardModel> rowItems;
  final ValueChanged<DigitRowCardModel>? onChanged;
  final double spacing;
  final WrapAlignment alignment;
  final double? width;

  const DigitRowCard({
    Key? key,
    required this.rowItems,
    this.onChanged,
    this.spacing = spacer4,
    this.alignment = WrapAlignment.start,
    this.width,
  }) : super(key: key);

  @override
  _DigitRowCardState createState() => _DigitRowCardState();
}

class _DigitRowCardState extends State<DigitRowCard> {
  late double maxLabelWidth;

  @override
  void initState() {
    super.initState();
  }

  // Function to calculate the width of the largest label based on the text theme of the current screen
  void _calculateMaxLabelWidth() {
    final textTheme = Theme.of(context).digitTextTheme(context);
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double maxWidth = 0;
    for (var item in widget.rowItems) {
      textPainter.text = TextSpan(
        text: item.label,
        style: textTheme.bodyS, // Get the font size and style from the current theme
      );
      textPainter.layout();
      maxWidth = max(maxWidth, textPainter.width);
    }

    // Add padding to the width of the largest label dynamically
    maxLabelWidth = maxWidth + spacer8; // Adjust padding as needed
  }

  void _onItemTap(DigitRowCardModel item) {
    setState(() {
      for (var rowItem in widget.rowItems) {
        rowItem.isSelected = false;
      }
      item.isSelected = true;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(item);
    }
  }

  Widget _buildItem(DigitRowCardModel item, double itemWidth, BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);


    return InkWell(
      onTap: () => _onItemTap(item),
      child: Container(
        width: max(itemWidth, maxLabelWidth), // Use the calculated width
        decoration: BoxDecoration(
          color: item.isSelected
              ? theme.colorTheme.primary.primary1
              : theme.colorTheme.paper.secondary,
          border: Border.all(
            color: item.isSelected
                ? theme.colorTheme.primary.primary1
                : theme.colorTheme.generic.inputBorder,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: spacer2, horizontal: spacer4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.label,
              style: textTheme.bodyS.copyWith(
                fontWeight: item.isSelected ? FontWeight.bold : FontWeight.normal,
                color: item.isSelected
                    ? theme.colorTheme.paper.primary
                    : theme.colorTheme.text.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - spacer12;
    final totalSpacing = (widget.rowItems.length - 1) * widget.spacing;
    final availableWidth = screenWidth - totalSpacing;
    final itemWidth = availableWidth / widget.rowItems.length;
    _calculateMaxLabelWidth();

    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.spacing,
      alignment: widget.alignment,
      children: widget.rowItems.map((item) => _buildItem(item, widget.width ?? itemWidth, context)).toList(),
    );
  }
}
