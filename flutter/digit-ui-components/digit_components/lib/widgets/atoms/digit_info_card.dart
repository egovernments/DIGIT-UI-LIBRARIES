/// InfoCard is a component used to display information with an icon and a description.
/// It can be used to show different types of information such as success, error, warning, or general info.
/// The card can optionally include additional widgets below the description.
/// InfoCard(
///           title: 'Welcome',
///           type: InfoType.success,
///           description: 'This is a success message.',
///           additionalWidgets: [
///             ElevatedDigitButton(
///               onPressed: () {
///                 // Handle DigitButton tap
///               },
///               child: Text('OK'),
///             ),
///           ],
///         ),

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/info_card_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class InfoCard extends StatelessWidget {
  /// Title of the card
  final String title;

  final String? semanticLabel;

  /// Description text
  final String description;

  /// Type of information (info, success, error, warning)
  final InfoType type;

  /// Additional widgets to display below the description
  final List<Widget>? additionalWidgets;

  /// Whether to display additional widgets in a row or column
  final bool inline;

  /// Whether to capitalize the first letter of the title and description
  final bool capitalizedLetter;

  final DigitInfoCardThemeData? infoCardThemeData;

  const InfoCard({
    super.key,
    required this.title,
    this.semanticLabel,
    required this.type,
    required this.description,
    this.additionalWidgets,
    this.inline = false,
    this.capitalizedLetter = true,
    this.infoCardThemeData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = infoCardThemeData ??
        theme.extension<DigitInfoCardThemeData>() ??
        DigitInfoCardThemeData.defaultTheme(context);

    /// Define icon, icon color, and container color based on the type of information
    IconData selectedIcon;
    Color iconColor;
    Color containerColor;


    /// Capitalize the title and description if specified(by default always true)
    String capitalizedHeading =
    capitalizedLetter ? capitalizeFirstLetterOfEveryWord(title) : title;
    String capitalizedDescription =
    capitalizedLetter ? convertInToSentenceCase(description)! : description;

    /// Determine the icon and colors based on the info type
    switch (type) {
      case InfoType.success:
        selectedIcon = themeData.successIcon;
        iconColor = themeData.successColor;
        containerColor = themeData.successBackgroundColor;
        break;
      case InfoType.error:
        selectedIcon = themeData.errorIcon;
        iconColor = themeData.errorColor;
        containerColor = themeData.errorBackgroundColor;
        break;
      case InfoType.warning:
        selectedIcon = themeData.warningIcon;
        iconColor = themeData.warningColor;
        containerColor = themeData.warningBackgroundColor;
        break;
      case InfoType.info:
      default:
        selectedIcon = themeData.infoIcon;
        iconColor = themeData.infoColor;
        containerColor = themeData.infoBackgroundColor;
    }

    return Semantics(
      label: semanticLabel,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: themeData.borderRadius,
            border: Border(
              right: BorderSide(color: iconColor, width: themeData.borderWidth),
              left: BorderSide(color: iconColor, width: theme.spacerTheme.spacer1),
              top: BorderSide(color: iconColor, width: themeData.borderWidth),
              bottom:
              BorderSide(color: iconColor, width: themeData.borderWidth),
            ),
            color: containerColor,
          ),
          child: Padding(
            padding: themeData.contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      selectedIcon,
                      size: themeData.iconSize,
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
                          semanticsLabel: capitalizedHeading,
                          capitalizedHeading,
                          style: themeData.titleTextStyle.copyWith(
                            color: iconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacerTheme.spacer2),
                /// Description text
                Text(
                  capitalizedDescription,
                  semanticsLabel: capitalizedDescription,
                  style: themeData.descriptionTextStyle.copyWith(
                    color: theme.colorTheme.text.secondary,
                  ),
                ),

                /// Additional widgets, if provided
                if (additionalWidgets != null)  SizedBox(height: theme.spacerTheme.spacer4),
                if (additionalWidgets != null)
                  if (inline)

                  /// Display additional widgets in a row
                    Wrap(
                      spacing: theme.spacerTheme.spacer2,
                      children: additionalWidgets!
                          .map((widget) => Padding(
                        padding: EdgeInsets.only(right: theme.spacerTheme.spacer2),
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
                        padding: EdgeInsets.only(bottom: theme.spacerTheme.spacer2),
                        child: widget,
                      ))
                          .toList(),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}