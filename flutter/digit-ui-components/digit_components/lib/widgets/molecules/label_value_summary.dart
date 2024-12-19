import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/helper_widget/button_list.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import '../atoms/label_value_list.dart';

class LabelValueSummary extends StatelessWidget {
  final String? heading;
  final List<LabelValueItem> items;
  final EdgeInsets? padding;
  final bool withDivider;
  final List<DigitButton>? action;
  final bool withCard;

  const LabelValueSummary({
    Key? key,
    this.heading,
    required this.items,
    this.padding,
    this.withDivider = false,
    this.action,
    this.withCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    Widget content = Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: withCard ? 0 : isMobile ? spacer4 : spacer6, horizontal: withCard ? 0 : isMobile ? spacer4:spacer6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading != null)
            Padding(
              padding: const EdgeInsets.only(bottom: spacer4),
              child: Text(
                heading!,
                style: textTheme.headingL.copyWith(
                  color: theme.colorTheme.text.primary,
                ),
              ),
            ),
          ..._buildItemsWithDividers(),
          if (action != null) ...[
            const SizedBox(height: spacer4),
            DigitButtonListTile(
              alignment: !withCard && !isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
                buttons: action!),
          ],
        ],
      ),
    );

    // Wrap the content in a Card if withCard is true
    if (withCard) {
      content = DigitCard(
        children: [content],
      );
    }

    return content;
  }

  List<Widget> _buildItemsWithDividers() {
    List<Widget> itemList = [];
    for (int i = 0; i < items.length; i++) {
      itemList.add(items[i]);
      if (i < items.length - 1 && withDivider) {
        itemList.add(
          const Divider(),
        );
      }
    }
    return itemList;
  }
}
