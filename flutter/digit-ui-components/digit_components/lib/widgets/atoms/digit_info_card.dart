import 'package:flutter/material.dart';

import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';


class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final InfoType type;
  final IconData? icon;
  /// List of additional widgets
  final List<Widget>? additionalWidgets;
  /// Whether to display additional widgets inline or one below the other
  final bool inline;

  InfoCard({
    required this.title,
    required this.type,
    required this.description,
    this.icon,
    this.additionalWidgets,
    this.inline = false,
  });

  @override
  Widget build(BuildContext context) {
    IconData selectedIcon;
    Color iconColor;
    Color containerColor = const DigitColors().lightAlertInfoBg;
    DigitTypography currentTypography = getTypography(context);
    double minWidth = AppView.isMobileView(MediaQuery.of(context).size.width)
        ? 240
        : AppView.isTabletView(MediaQuery.of(context).size.width)
        ? 360
        : 400;

    /// Choose icon and color based on InfoType
    switch (type) {
      case InfoType.success:
        selectedIcon = Icons.check_circle;
        iconColor = const DigitColors().lightAlertSuccess;
        containerColor =
            const DigitColors().lightAlertSuccessBg;
        break;
      case InfoType.error:
        selectedIcon = Icons.error;
        iconColor = const DigitColors().lightAlertError;
        containerColor =
            const DigitColors().lightAlertErrorBg;
        break;
      case InfoType.warning:
        selectedIcon = Icons.warning;
        iconColor = const DigitColors().warning;
        containerColor =
            const DigitColors().warningBg;
        break;
      case InfoType.info:
      default:
        selectedIcon = Icons.info;
        iconColor = const DigitColors().info;
        containerColor = const DigitColors().infoBg;
    }

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minWidth: minWidth,
        ),
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
                    color: iconColor,
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
              const SizedBox(height: kPadding*2,),
              /// Display additional widgets based on the 'inline' prop
              if (additionalWidgets != null)
                if (inline)
                  Wrap(
                    spacing: kPadding,
                    children: additionalWidgets!
                        .map(
                          (widget) => Padding(
                        padding: const EdgeInsets.only(right: kPadding, bottom: kPadding, top: kPadding),
                        child: widget,
                      ),
                    )
                        .toList(),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: additionalWidgets!
                        .map(
                          (widget) => Padding(
                        padding: const EdgeInsets.only(right: kPadding, bottom: kPadding, top: kPadding),
                        child: widget,
                      ),
                    )
                        .toList(),
                  ),
            ],
          ),
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
