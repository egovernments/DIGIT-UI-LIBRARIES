import 'package:flutter/material.dart';

import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';
import '../../utils/utils.dart';

class LabeledField extends StatelessWidget {
  final Widget child;
  final String? label;
  final bool isRequired;
  final IconData? icon;
  final String? tooltipMessage;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final bool preferToolTipBelow;
  final bool? info;
  final String? infoText;
  final TooltipTriggerMode triggerMode;
  final TooltipTriggerMode tooltipTriggerMode;
  final TextStyle? textStyle;
  final bool wrapLabelText;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool capitalizedFirstLetter;

  const LabeledField({
    super.key,
    required this.child,
    this.label,
    this.icon,
    this.tooltipMessage,
    this.labelStyle,
    this.padding,
    this.isRequired = false,
    this.info,
    this.infoText,
    this.preferToolTipBelow = false,
    this.tooltipTriggerMode = TooltipTriggerMode.tap,
    this.textStyle,
    this.triggerMode = TooltipTriggerMode.tap,
    this.wrapLabelText = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.capitalizedFirstLetter = true,
  });

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context);

    /// Capitalize the first letter of the label if required
    final processedLabel = capitalizedFirstLetter
        ? capitalizeFirstLetter(label)
        : label;

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);
    if (!isMobile) {
      return Padding(
        padding: padding ?? const EdgeInsets.only(top: kPadding),
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      processedLabel!.length > 64
                          ? '${processedLabel!.substring(0, 64)}...'
                          : processedLabel!,
                      style: currentTypography.bodyL.copyWith(
                        height: 1.172,
                        color: const DigitColors().light.textPrimary,
                        overflow: wrapLabelText
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (isRequired)
                    Text(
                      ' *',
                      style: currentTypography.bodyL.copyWith(
                        color: const DigitColors().light.alertError,
                      ),
                    ),
                  if (info == true) const SizedBox(width: kPadding / 2),
                  if (info == true)
                    Tooltip(
                      message: infoText,
                      preferBelow: preferToolTipBelow,
                      triggerMode: triggerMode,
                      child: Icon(
                        Icons.info_outline,
                        size: 19,
                        color: const DigitColors().light.textSecondary,
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(child: child),
          ],
        ),
      );
    } else {
      return Padding(
        padding: padding ?? const EdgeInsets.only(top: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (label != null)
                  Flexible(
                    child: Text(
                      processedLabel!.length > 64
                          ? '${processedLabel!.substring(0, 64)}...'
                          : processedLabel!,
                      style: currentTypography.bodyL.copyWith(
                        color: const DigitColors().light.textPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                if (isRequired)
                  Text(
                    ' *',
                    style: currentTypography.bodyL.copyWith(
                      color: const DigitColors().light.alertError,
                    ),
                  ),
                if (info == true) const SizedBox(width: kPadding / 2),
                if (info == true)
                  Tooltip(
                    message: infoText,
                    preferBelow: preferToolTipBelow,
                    triggerMode: triggerMode,
                    child: const Icon(
                      Icons.info_outline,
                      size: 16,
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            child,
          ],
        ),
      );
    }
  }
}
