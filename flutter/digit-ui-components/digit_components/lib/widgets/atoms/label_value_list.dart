
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

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

  const LabelValueList({
    Key? key,
    required this.items,
    this.padding,
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
      children: items.map((item) => _buildItem(item, currentTypography)).toList(),
    );
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
              style: currentTypography.headingS.copyWith(color: const DigitColors().light.textPrimary),
            ),
          ),
          const SizedBox(width: 24), // Gap between label and value
          // Value taking rest of the width
          Expanded(
            flex: 8, // Remaining 70% width
            child: Text(
              item.value,
              style: currentTypography.bodyS.copyWith(color: const DigitColors().light.textPrimary),
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: currentTypography.headingS.copyWith(color: const DigitColors().light.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            item.value,
            style: currentTypography.bodyS.copyWith(color: const DigitColors().light.textPrimary),
          ),
        ],
      ),
    );
  }

}
