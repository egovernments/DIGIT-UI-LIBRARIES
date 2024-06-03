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

class LabelValueWidget extends StatelessWidget {
  final List<LabelValuePair> items;
  final EdgeInsets? padding;

  const LabelValueWidget({
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.label,
                  style: currentTypography.headingS.copyWith(color: const DigitColors().light.textPrimary),
                ),
                SizedBox(width: 8),
                Text(item.value, style: currentTypography.bodyS.copyWith(color: const DigitColors().light.textPrimary),),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: currentTypography.headingS.copyWith(color: const DigitColors().light.textPrimary),
                ),
                SizedBox(height: 8),
                Text(item.value, style: currentTypography.bodyS.copyWith(color: const DigitColors().light.textPrimary),),
              ],
            ),
    );
  }
}
