import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final IconData icon;
  final String heading;
  final String? description;
  final VoidCallback? onTap;

  const MenuCard({
    Key? key,
    required this.icon,
    required this.heading,
    this.description,
    this.onTap,
  }) : super(key: key);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return InkWell(
      onHover: (hover) {
        setState(() {
          isHovered = hover;
        });
      },
      onTap: widget.onTap,
      child: Container(
        decoration: widget.onTap != null && isHovered
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(spacer1),
          border: Border.all(
            width: 1,
            color: theme.colorTheme.primary.primary1,
          ),)
            : null,
        child: DigitCard(
          spacing: 12,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: isMobile ? 24 : isTab ? 32 : 32,
                  color: theme.colorTheme.primary.primary1,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.heading,
                    style: textTheme.headingM.copyWith(
                      color: theme.colorTheme.primary.primary2,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.description != null)
              Text(
                widget.description!,
                style: textTheme.bodyS.copyWith(
                  color: theme.colorTheme.text.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
