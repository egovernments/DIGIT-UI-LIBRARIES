import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

enum LayoutType { horizontal, vertical }

class FlexibleDigitCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final CardType cardType;
  final double? spacing;
  final Color? borderColor;
  final bool showDivider;
  final LayoutType layoutType; // Horizontal or Vertical layout
  final int columnCount; // 1 for one column, 2 for two columns

  const FlexibleDigitCard({
    required this.children,
    super.key,
    this.padding,
    this.margin,
    this.onPressed,
    this.spacing,
    this.borderColor,
    this.showDivider = false,
    this.cardType = CardType.primary,
    this.layoutType = LayoutType.vertical, // Default to vertical layout
    this.columnCount = 2, // Default to two columns
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    List<Widget> firstColumnChildren = [];
    List<Widget> secondColumnChildren = [];

    // Split children between columns if columnCount is 2
    if (columnCount == 2) {
      for (int i = 0; i < children.length; i++) {
        if (i % 2 == 0) {
          firstColumnChildren.add(children[i]);
        } else {
          secondColumnChildren.add(children[i]);
        }
      }
    } else {
      firstColumnChildren = children;
    }

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacer1),
        border: cardType == CardType.secondary
            ? Border.all(
                width: Base.defaultBorderWidth,
                color: borderColor ?? const DigitColors().light.genericDivider,
              )
            : null,
        color: cardType == CardType.secondary
            ? theme.colorTheme.paper.secondary
            : theme.colorTheme.paper.primary,
        boxShadow: cardType == CardType.primary
            ? [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.16),
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ]
            : [],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(spacer1),
        onTap: onPressed,
        child: Padding(
          padding: padding ??
              (isMobile
                  ? const EdgeInsets.all(spacer4)
                  : isTab
                      ? const EdgeInsets.all(spacer5)
                      : const EdgeInsets.all(spacer6)),
          child: layoutType == LayoutType.horizontal
              ? IntrinsicHeight(
                  // Ensures all children have the same height
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // Stretches children to take full height
                    children: [
                      // First column
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: firstColumnChildren
                              .asMap()
                              .entries
                              .map((entry) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: entry.key ==
                                              firstColumnChildren.length - 1
                                          ? 0
                                          : spacing ??
                                              (isMobile
                                                  ? 16
                                                  : isTab
                                                      ? 20
                                                      : 24),
                                    ),
                                    child:entry.value,
                                  ))
                              .toList(),
                        ),
                      ),
                      if (showDivider &&
                          columnCount == 2) // Optional divider between columns
                        VerticalDivider(
                          width: 48,
                          thickness: 1,
                          color: const DigitColors().light.genericDivider,
                        ),
                      if (columnCount == 2)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: secondColumnChildren
                                .asMap()
                                .entries
                                .map((entry) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: entry.key ==
                                                secondColumnChildren.length - 1
                                            ? 0
                                            : spacing ??
                                                (isMobile
                                                    ? 16
                                                    : isTab
                                                        ? 20
                                                        : 24),
                                      ),
                                      child: entry.value,
                                    ))
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: firstColumnChildren
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  entry.key == firstColumnChildren.length - 1
                                      ? 0
                                      : spacing ??
                                          (isMobile
                                              ? 16
                                              : isTab
                                                  ? 20
                                                  : 24),
                            ),
                            child: entry.value,
                          ))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
