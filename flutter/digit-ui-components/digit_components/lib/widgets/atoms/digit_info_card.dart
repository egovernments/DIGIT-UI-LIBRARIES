import 'package:flutter/material.dart';

import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';
import '../../utils/utils.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final InfoType type;
  final IconData? icon;

  /// List of additional widgets
  final List<Widget>? additionalWidgets;

  /// Whether to display additional widgets inline or one below the other
  final bool inline;

  const InfoCard({super.key,
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
    Color containerColor = const DigitColors().light.alertInfoBg;
    DigitTypography currentTypography = getTypography(context);
    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width * .77
        : AppView.isTabletView(MediaQuery.of(context).size)
            ? MediaQuery.of(context).size.width * .48
            : MediaQuery.of(context).size.width * .27;

    String capitalizedHeading = capitalizeFirstLetter(title)!;
    String capitalizedDescription = capitalizeFirstLetter(description)!;

    /// Choose icon and color based on InfoType
    switch (type) {
      case InfoType.success:
        selectedIcon = Icons.check_circle;
        iconColor = const DigitColors().light.alertSuccess;
        containerColor = const DigitColors().light.alertSuccessBg;
        break;
      case InfoType.error:
        selectedIcon = Icons.error;
        iconColor = const DigitColors().light.alertError;
        containerColor = const DigitColors().light.alertErrorBg;
        break;
      case InfoType.warning:
        selectedIcon = Icons.warning;
        iconColor = const DigitColors().light.alertWarning;
        containerColor = const DigitColors().light.alertWarningBg;
        break;
      case InfoType.info:
      default:
        selectedIcon = Icons.info;
        iconColor = const DigitColors().light.alertInfo;
        containerColor = const DigitColors().light.alertInfoBg;
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
                  Expanded(
                    child: Text(
                      capitalizedHeading,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: currentTypography.headingS.copyWith(
                        color: const DigitColors().light.textPrimary,
                        height: 1.172,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPadding),
              Text(
                capitalizedDescription,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                style: currentTypography.bodyS.copyWith(
                  color: const DigitColors().light.textSecondary,
                  height: 1.094,
                ),
              ),
              if (additionalWidgets != null)
              const SizedBox(
                height: kPadding * 2,
              ),

              /// Display additional widgets based on the 'inline' prop
              if (additionalWidgets != null)
                if (inline)
                  Wrap(
                    spacing: kPadding,
                    children: additionalWidgets!
                        .map(
                          (widget) => Padding(
                            padding: const EdgeInsets.only(right: kPadding),
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
                            padding: const EdgeInsets.only(right: kPadding),
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
