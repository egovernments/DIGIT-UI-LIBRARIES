import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final InfoType type;
  final IconData? icon;

  InfoCard({
    required this.title,
    required this.type,
    required this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    IconData selectedIcon;
    Color iconColor;
    Color containerColor = const DigitColors().lightAlertInfoBg;
    DigitTypography currentTypography = getTypography(context);

    // Choose icon and color based on InfoType
    switch (type) {
      case InfoType.success:
        selectedIcon = Icons.check_circle;
        iconColor = const DigitColors().lightAlertSuccess;
        containerColor =
            const DigitColors().lightAlertSuccessBg; // Set your success color
        break;
      case InfoType.error:
        selectedIcon = Icons.error;
        iconColor = const DigitColors().lightAlertError;
        containerColor =
            const DigitColors().lightAlertErrorBg; // Set your error color
        break;
      case InfoType.warning:
        selectedIcon = Icons.warning;
        iconColor = const DigitColors().warning;
        containerColor =
            const DigitColors().warningBg; // Set your warning color
        break;
      case InfoType.info:
      default:
        selectedIcon = Icons.info;
        iconColor = const DigitColors().info;
        containerColor = const DigitColors().infoBg; // Set your info color
    }

    return Container(
      height: 154,
      width: 344,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: containerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon ?? selectedIcon,
                  size: 24,
                  color: iconColor, // You can customize the color
                ),
                const SizedBox(width: kPadding),
                Text(
                  title,
                  style: currentTypography.headingS.copyWith(
                    color: const DigitColors().lightTextPrimary,
                    height: 1.172,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kPadding),
            Text(
              description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: currentTypography.bodyS.copyWith(
                color: const DigitColors().lightTextSecondary,
                height: 1.094,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum InfoType {
  info,
  success,
  error,
  warning,
}
