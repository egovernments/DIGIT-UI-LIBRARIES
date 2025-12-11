import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final CardType cardType;
  final double? spacing;
  final Color? borderColor;
  final bool inline;
  final BorderRadiusGeometry? borderRadius;
  final ScrollPhysics? scrollPhysics;
  final double? width;

  const DigitCard({
    required this.children,
    super.key,
    this.padding,
    this.inline = false,
    this.margin,
    this.onPressed,
    this.spacing,
    this.borderColor,
    this.cardType = CardType.primary,
    this.borderRadius,
    this.scrollPhysics,
    this.width,
  });

  /// Removes widgets that should not create spacing
  List<Widget> _filterVisibleChildren(List<Widget> items) {
    return items.where((w) {
      if (w is SizedBox) {
        final h = w.height ?? -1;
        final k = w.width ?? -1;
        // SizedBox.shrink() → height=0,width=0
        if (h == 0 && k == 0) return false;
      }
      if (w is Container && w.child == null) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final isTab = AppView.isTabletView(MediaQuery.of(context).size);

    final spacingValue = spacing ??
        (isMobile
            ? 16
            : isTab
                ? 20
                : 24);

    // Keep only visible children
    final visibleChildren = _filterVisibleChildren(children);

    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(spacer1),
        border: cardType == CardType.secondary
            ? Border.all(
                width: Base.defaultBorderWidth,
                color: borderColor ?? theme.colorTheme.generic.divider,
              )
            : null,
        color: cardType == CardType.secondary
            ? theme.colorTheme.paper.secondary
            : theme.colorTheme.paper.primary,
        boxShadow: cardType == CardType.primary
            ? [
                BoxShadow(
                  color: theme.colorTheme.text.primary.withOpacity(.16),
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
          child: SingleChildScrollView(
            physics: scrollPhysics,
            child: inline && !isMobile
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: visibleChildren.asMap().entries.map(
                      (entry) {
                        final isLast = entry.key == visibleChildren.length - 1;
                        return Padding(
                          padding:
                              EdgeInsets.only(right: isLast ? 0 : spacingValue),
                          child: entry.value,
                        );
                      },
                    ).toList(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: visibleChildren.asMap().entries.map(
                      (entry) {
                        final isLast = entry.key == visibleChildren.length - 1;
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: isLast ? 0 : spacingValue),
                          child: entry.value,
                        );
                      },
                    ).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
