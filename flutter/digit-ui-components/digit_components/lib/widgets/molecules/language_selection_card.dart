import 'dart:math';

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
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
        vertical: 16,
        horizontal: 16,
      ),
      margin: const EdgeInsets.all(8),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appLogo ?? const SizedBox.shrink(),
            DigitRowCard(
              spacing: 20,
              alignment: WrapAlignment.spaceBetween,
              onChanged: onLanguageChange,
              rowItems: digitRowCardItems,
              width: rowItemWidth,
            ),
            const SizedBox(height: 16,),
            Button(
              mainAxisSize: MainAxisSize.max,
              label: languageSubmitLabel,
              onPressed: onLanguageSubmit,
              type: ButtonType.primary,
              size: ButtonSize.large,
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
    this.spacing = 16.0,
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
    _calculateMaxLabelWidth();
  }

  // Function to calculate the width of the largest label
  void _calculateMaxLabelWidth() {
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double maxWidth = 0;
    for (var item in widget.rowItems) {
      textPainter.text = TextSpan(
        text: item.label,
        style: const TextStyle(
          fontSize: 16,
        ),
      );
      textPainter.layout();
      maxWidth = maxWidth > textPainter.width ? maxWidth : textPainter.width;
    }

    // Add padding to the width of the largest label
    maxLabelWidth = maxWidth + 40; // 16 padding on each side
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

  Widget _buildItem(DigitRowCardModel item, double itemWidth) {
    return GestureDetector(
      onTap: () => _onItemTap(item),
      child: Container(
        width: max(itemWidth, maxLabelWidth), // Use the calculated width
        decoration: BoxDecoration(
          color: item.isSelected
              ? const DigitColors().light.primary1
              : const DigitColors().light.paperSecondary,
          border: Border.all(
            color: item.isSelected
                ? const DigitColors().light.primary1
                : const DigitColors().light.genericInputBorder,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: item.isSelected ? FontWeight.bold : FontWeight.normal,
                color: item.isSelected
                    ? const DigitColors().light.paperPrimary
                    : const DigitColors().light.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 48;
    final totalSpacing = (widget.rowItems.length - 1) * widget.spacing;
    final availableWidth = screenWidth - totalSpacing;
    final itemWidth = availableWidth / widget.rowItems.length;

    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.spacing,
      alignment: widget.alignment,
      children: widget.rowItems.map((item) => _buildItem(item, widget.width ?? itemWidth)).toList(),
    );
  }
}
