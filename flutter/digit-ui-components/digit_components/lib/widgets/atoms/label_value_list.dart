import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';

class LabelValuePair {
  final String label;
  final String value;
  final bool isInline;

  LabelValuePair({
    required this.label,
    required this.value,
    this.isInline = true, // Default to inline layout
  });
}

class LabelValueList extends StatelessWidget {
  final List<LabelValuePair> items;
  final EdgeInsets? padding;
  final String? heading;
  final bool withDivider;

  const LabelValueList({
    Key? key,
    required this.items,
    this.padding,
    this.heading,
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
                  flex: 2, // 30% width
                  child: Text(
                    item.label,
                    style: currentTypography.headingS.copyWith(
                      color: const DigitColors().light.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 24), // Gap between label and value
                // Value taking rest of the width
                Expanded(
                  flex: 8, // Remaining 70% width
                  child: Text(
                    item.value,
                    style: currentTypography.bodyS.copyWith(
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
                  style: currentTypography.headingS.copyWith(
                    color: const DigitColors().light.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: currentTypography.bodyS.copyWith(
                    color: const DigitColors().light.textPrimary,
                  ),
                ),
              ],
            ),
    );
  }
}
