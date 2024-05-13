import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';
import '../../utils/utils.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final InfoType type;
  final IconData? icon;
  final List<Widget>? additionalWidgets;
  final bool inline;
  final bool capitalizedLetter;

  const InfoCard({
    super.key,
    required this.title,
    required this.type,
    required this.description,
    this.icon,
    this.additionalWidgets,
    this.inline = false,
    this.capitalizedLetter = true,
  });

  @override
  Widget build(BuildContext context) {
    IconData selectedIcon;
    Color iconColor;
    Color containerColor = const DigitColors().light.alertInfoBg;
    DigitTypography currentTypography = getTypography(context, false);

    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width * .77
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width * .48
        : MediaQuery.of(context).size.width * .27;

    String capitalizedHeading = capitalizedLetter ? capitalizeFirstLetterOfEveryWord(title)! : title;
    String capitalizedDescription = capitalizedLetter ? capitalizeFirstLetter(description)! : description;

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
          borderRadius: Common.radius,
          border: Border(
            right: BorderSide(color: iconColor, width: 1),
            left: BorderSide(color: iconColor, width: 4),
            top: BorderSide(color: iconColor, width: 1),
            bottom: BorderSide(color: iconColor, width: 1),
          ),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(kPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start, // Aligns the icon to the top
                children: [
                  Icon(
                    icon ?? selectedIcon,
                    size: 24,
                    color: iconColor,
                  ),
                  const SizedBox(width: kPadding),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 3,),
                      child: Text(
                        capitalizedHeading,
                        style: currentTypography.headingS.copyWith(
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPadding),
              Text(
                capitalizedDescription,
                style: currentTypography.bodyS.copyWith(
                  color: const DigitColors().light.textSecondary,
                ),
              ),
              if (additionalWidgets != null)
                const SizedBox(height: kPadding * 2),
              if (additionalWidgets != null)
                if (inline)
                  Wrap(
                    spacing: kPadding,
                    children: additionalWidgets!.map((widget) => Padding(
                      padding: const EdgeInsets.only(right: kPadding),
                      child: widget,
                    )).toList(),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: additionalWidgets!.map((widget) => Padding(
                      padding: const EdgeInsets.only(bottom: kPadding),
                      child: widget,
                    )).toList(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

enum InfoType { info, success, error, warning }