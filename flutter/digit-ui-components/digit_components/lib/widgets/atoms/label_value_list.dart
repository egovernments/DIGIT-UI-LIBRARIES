import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
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
    this.withDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

   final theme = Theme.of(context);
   final textTheme = theme.digitTextTheme(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: spacer2),
            child: Text(
              heading!,
              style: textTheme.headingL.copyWith(
                color: theme.colorTheme.text.primary,
              ),
            ),
          ),
        ..._buildItemsWithDividers(items, context),
      ],
    );
  }

  List<Widget> _buildItemsWithDividers(
      List<LabelValuePair> items, BuildContext context) {
    List<Widget> itemList = [];
    for (int i = 0; i < items.length; i++) {
      itemList.add(_buildItem(items[i], context));
      if (i < items.length - 1 && withDivider) {
        itemList.add(
          const DigitDivider(),
        );
      }
    }
    return itemList;
  }

  Widget _buildItem(LabelValuePair item, BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: spacer2),
      child: item.isInline
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: labelFlex,
            child: Text(
              item.label,
              style: item.labelTextStyle ?? textTheme.headingS.copyWith(
                color: theme.colorTheme.text.primary,
              ),
            ),
          ),
          const SizedBox(width: spacer6),
          Expanded(
            flex: valueFlex,
            child: Text(
              item.value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: item.valueTextStyle ?? textTheme.bodyS.copyWith(
                color: theme.colorTheme.text.primary,
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
            style: item.labelTextStyle ?? textTheme.headingS.copyWith(
              color: theme.colorTheme.text.primary,
            ),
          ),
          const SizedBox(height: spacer1),
          Text(
            item.value,
            style: item.valueTextStyle ?? textTheme.bodyS.copyWith(
              color: theme.colorTheme.text.primary,
            ),
          ),
        ],
      ),
    );
  }
}