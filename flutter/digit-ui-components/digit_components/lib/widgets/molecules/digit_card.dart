import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class DigitCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final CardType cardType;
  final double? spacing;
  final bool inline;

  const DigitCard({
    required this.children,
    super.key,
    this.padding,
    this.inline = false,
    this.margin,
    this.onPressed,
    this.spacing,
    this.cardType = CardType.primary,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    return Container(
      //width: MediaQuery.of(context).size.width,
      // will take the max width of the content present inside this
      // provide a max width for the card

      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacer1),
        border: cardType == CardType.secondary
            ? Border.all(
          width: Base.defaultBorderWidth,
          color: const DigitColors().light.genericDivider,
        )
            : null,
        color: cardType == CardType.secondary
            ? const DigitColors().light.paperSecondary
            : const DigitColors().light.paperPrimary,
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
          child: SingleChildScrollView(
            child: inline && !isMobile
                ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
                  .asMap()
                  .entries
                  .map((entry) => Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: entry.key == children.length - 1
                        ? 0
                        : spacing ?? (isMobile ?16 : isTab ? 20 : 24),
                  ),
                  child: entry.value,
                ),
              ))
                  .toList(),
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
                  .asMap()
                  .entries
                  .map((entry) => Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == children.length - 1
                      ? 0
                      : spacing ?? (isMobile ?16 : isTab ? 20 : 24),
                ),
                child: entry.value,
              ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}