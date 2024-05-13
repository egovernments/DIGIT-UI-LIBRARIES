/// InfoCard is a component used to display information with an icon and a description.
/// It can be used to show different types of information such as success, error, warning, or general info.
/// The card can optionally include additional widgets below the description.
/// InfoCard(
///           title: 'Welcome',
///           type: InfoType.success,
///           description: 'This is a success message.',
///           additionalWidgets: [
///             ElevatedButton(
///               onPressed: () {
///                 // Handle button tap
///               },
///               child: Text('OK'),
///             ),
///           ],
///         ),

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../utils/utils.dart';

class InfoCard extends StatelessWidget {
  /// Title of the card
  final String title;

  /// Description text
  final String description;

  /// Type of information (info, success, error, warning)
  final InfoType type;

  /// Optional icon to override the default one
  final IconData? icon;

  /// Additional widgets to display below the description
  final List<Widget>? additionalWidgets;

  /// Whether to display additional widgets in a row or column
  final bool inline;

  /// Whether to capitalize the first letter of the title and description
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
    /// Define icon, icon color, and container color based on the type of information
    IconData selectedIcon;
    Color iconColor;
    Color containerColor = const DigitColors().light.alertInfoBg;
    DigitTypography currentTypography = getTypography(context, false);

    /// Determine the minimum width of the card based on the device size
    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width * .77
        : AppView.isTabletView(MediaQuery.of(context).size)
            ? MediaQuery.of(context).size.width * .48
            : MediaQuery.of(context).size.width * .27;

    /// Capitalize the title and description if specified(by default always true)
    String capitalizedHeading =
        capitalizedLetter ? capitalizeFirstLetterOfEveryWord(title) : title;
    String capitalizedDescription =
        capitalizedLetter ? capitalizeFirstLetter(description)! : description;

    /// Determine the icon and colors based on the info type
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
            right:
                BorderSide(color: iconColor, width: Common.defaultBorderWidth),
            left: BorderSide(color: iconColor, width: spacer1),
            top: BorderSide(color: iconColor, width: Common.defaultBorderWidth),
            bottom:
                BorderSide(color: iconColor, width: Common.defaultBorderWidth),
          ),
          color: containerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(spacer4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon ?? selectedIcon,

                    /// Use provided icon or default based on type
                    size: spacer6,
                    color: iconColor,
                  ),
                  const SizedBox(width: spacer2),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        top: spacer3 / 4,
                      ),
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
              const SizedBox(height: spacer2),

              /// Description text
              Text(
                capitalizedDescription,
                style: currentTypography.bodyS.copyWith(
                  color: const DigitColors().light.textSecondary,
                ),
              ),

              /// Additional widgets, if provided
              if (additionalWidgets != null) const SizedBox(height: spacer4),
              if (additionalWidgets != null)
                if (inline)

                  /// Display additional widgets in a row
                  Wrap(
                    spacing: spacer2,
                    children: additionalWidgets!
                        .map((widget) => Padding(
                              padding: const EdgeInsets.only(right: spacer2),
                              child: widget,
                            ))
                        .toList(),
                  )
                else

                  /// Display additional widgets in a column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: additionalWidgets!
                        .map((widget) => Padding(
                              padding: const EdgeInsets.only(bottom: spacer2),
                              child: widget,
                            ))
                        .toList(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
