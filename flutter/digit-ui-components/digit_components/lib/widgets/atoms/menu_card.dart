import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

import '../../constants/AppView.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String description;
  final VoidCallback? onTap;

  const MenuCard({
    Key? key,
    required this.icon,
    required this.heading,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return GestureDetector(
      onTap: onTap,
      child: DigitCard(
        spacing: 12,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: isMobile ?24 : isTab ? 32 : 40,
                color: theme.colorTheme.primary.primary1,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  heading,
                  style: textTheme.headingM.copyWith(
                    color: theme.colorTheme.primary.primary2,
                  )
                ),
              ),
            ],
          ),
          Text(
            description,
            style: textTheme.bodyS.copyWith(
              color: theme.colorTheme.text.primary,
            ),
          ),
        ],
      ),
    );
  }
}
