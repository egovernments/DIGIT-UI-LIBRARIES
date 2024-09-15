import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';

class LabelValuePair {
  final String label;
  final String value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;
  final bool isInline;

  LabelValuePair({
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
    this.isInline = true, // Default to inline layout
  });
}

class LabelValueList extends StatelessWidget {
  final List<LabelValuePair> items;
  final EdgeInsets? padding;
  final String? heading;
  final int labelFlex;
  final int valueFlex;
  final int? maxLines;
  final bool withDivider;

  const LabelValueList({
    Key? key,
    required this.items,
    this.padding,
    this.heading,
    this.maxLines,
    this.labelFlex = 2,
    this.valueFlex = 8,
    this.withDivider = false, // Default to no divider
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              heading!,
              style: currentTypography.headingL.copyWith(
                color: const DigitColors().light.textPrimary,
              ),
            ),
          ),
        ..._buildItemsWithDividers(items, currentTypography),
      ],
    );
  }

  List<Widget> _buildItemsWithDividers(
      List<LabelValuePair> items, DigitTypography currentTypography) {
    List<Widget> itemList = [];
    for (int i = 0; i < items.length; i++) {
      itemList.add(_buildItem(items[i], currentTypography));
      if (i < items.length - 1 && withDivider) {
        itemList.add(
          const DigitDivider(),
        );
      }
    }
    return itemList;
  }

  Widget _buildItem(LabelValuePair item, DigitTypography currentTypography) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: item.isInline
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label taking 30% width
          Expanded(
            flex: labelFlex, // 30% width
            child: Text(
              item.label,
              style: item.labelTextStyle ?? currentTypography.headingS.copyWith(
                color: const DigitColors().light.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 24), // Gap between label and value
          // Value taking rest of the width
          Expanded(
            flex: valueFlex, // Remaining 70% width
            child: Text(
              item.value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: item.valueTextStyle ?? currentTypography.bodyS.copyWith(
                color: const DigitColors().light.textPrimary,
              ),
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: item.labelTextStyle ?? currentTypography.headingS.copyWith(
              color: const DigitColors().light.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.value,
            style: item.valueTextStyle ?? currentTypography.bodyS.copyWith(
              color: const DigitColors().light.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}