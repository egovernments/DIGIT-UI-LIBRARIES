import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/chip_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/utils.dart';
import 'package:flutter/material.dart';

class DigitChip extends StatelessWidget {
  final String label;
  final VoidCallback onItemDelete;
  final VoidCallback? onClick;
  final bool capitalizedFirstLetter;
  final String? errorMessage;
  final DigitChipThemeData? digitChipThemeData;

  const DigitChip({
    Key? key,
    required this.label,
    required this.onItemDelete,
    this.onClick,
    this.capitalizedFirstLetter = true,
    this.errorMessage,
    this.digitChipThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipThemeData = digitChipThemeData ??
        theme.extension<DigitChipThemeData>() ??
        DigitChipThemeData.defaultTheme(context);

    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    final String capitalizedTitle = capitalizedFirstLetter
        ? (convertInToSentenceCase(label) ?? label)
        : label;
    final String? capitalizedErrorMessage = capitalizedFirstLetter
        ? convertInToSentenceCase(errorMessage)
        : errorMessage;

    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onClick,
            hoverColor: theme.colorTheme.generic.transparent,
            highlightColor: theme.colorTheme.generic.transparent,
            splashColor: theme.colorTheme.generic.transparent,
            child: Container(
              padding: chipThemeData.padding,
              decoration: BoxDecoration(
                boxShadow:
                    errorMessage != null && chipThemeData.errorBoxShadow != null
                        ? [
                            chipThemeData.errorBoxShadow!,
                          ]
                        : [],
                border: Border.all(
                  color: (errorMessage != null
                      ? chipThemeData.errorBorderColor
                      : chipThemeData.borderColor) ?? theme.colorTheme.generic.inputBorder,
                  width: chipThemeData.borderWidth ?? 1,
                ),
                borderRadius: BorderRadius.circular(spacer1),
                color: (errorMessage != null
                    ? chipThemeData.errorBackgroundColor
                    : chipThemeData.backgroundColor) ?? theme.colorTheme.generic.background,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      capitalizedTitle,
                      style: errorMessage != null
                          ? chipThemeData.labelErrorTextStyle
                          : chipThemeData.labelTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: theme.spacerTheme.spacer2,
                  ),
                  InkWell(
                    onTap: onItemDelete,
                    hoverColor: theme.colorTheme.generic.transparent,
                    highlightColor: theme.colorTheme.generic.transparent,
                    splashColor: theme.colorTheme.generic.transparent,
                    child: Container(
                      width: isDesktop ? theme.spacerTheme.spacer6 : theme.spacerTheme.spacer5,
                      height: isDesktop ? theme.spacerTheme.spacer6 : theme.spacerTheme.spacer5,
                      decoration: BoxDecoration(
                        color: errorMessage != null
                            ? theme.colorTheme.alert.error
                            : theme.colorTheme.text.secondary,
                        borderRadius: BorderRadius.circular(theme.spacerTheme.spacer1 ?? 0),
                      ),
                      child: chipThemeData.cancelIcon,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (errorMessage != null)
            SizedBox(
              height: theme.spacerTheme.spacer1,
            ),
          if (errorMessage != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: spacer1 / 2,
                    ),
                    if(chipThemeData.errorIcon!=null)
                    chipThemeData.errorIcon!,
                  ],
                ),
                const SizedBox(width: spacer1),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    errorMessage!.length > 256
                        ? truncateWithEllipsis(256, capitalizedErrorMessage!)
                        : capitalizedErrorMessage!,
                    style: chipThemeData.errorTextStyle,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
