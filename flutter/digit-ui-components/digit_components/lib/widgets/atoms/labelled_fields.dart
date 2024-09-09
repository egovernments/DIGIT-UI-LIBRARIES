import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class LabeledField extends StatelessWidget {
  final Widget child;
  final String? label;
  final bool isRequired;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final bool preferToolTipBelow;
  final String? infoText;
  final TooltipTriggerMode tooltipTriggerMode;
  final TextStyle? textStyle;
  final bool wrapLabelText;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool capitalizedFirstLetter;
  final bool labelInline;

  const LabeledField({
    super.key,
    required this.child,
    this.label,
    this.labelStyle,
    this.padding,
    this.isRequired = false,
    this.infoText,
    this.preferToolTipBelow = false,
    this.tooltipTriggerMode = TooltipTriggerMode.tap,
    this.textStyle,
    this.wrapLabelText = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.capitalizedFirstLetter = true,
    this.labelInline = true,
  });

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    /// Capitalize the first letter of the label if required
    final processedLabel =
        capitalizedFirstLetter ? convertInToSentenceCase(label) : label;

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    if (isMobile || !labelInline) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  text: processedLabel!.length > 64
                      ? '${processedLabel!.substring(0, 64)}...'
                      : processedLabel!,
                  style: currentTypography.bodyL.copyWith(
                    color: const DigitColors().light.textPrimary,
                    overflow: TextOverflow.ellipsis,
                  ),
                  children: isRequired
                      ? [
                    TextSpan(
                      text: ' *',
                      style: currentTypography.bodyL.copyWith(
                        color: const DigitColors().light.alertError,
                      ),
                    ),
                  ]
                      : [],
                ),
                maxLines: wrapLabelText ? 5 : 1,
                overflow: TextOverflow.ellipsis, // To handle overflow
              ),
              if (infoText != null) const SizedBox(width: spacer1),
              if (infoText != null)
                Tooltip(
                  message: infoText,
                  preferBelow: preferToolTipBelow,
                  triggerMode: tooltipTriggerMode,
                  child: const Icon(
                    Icons.info_outline,
                    size: spacer4,
                  ),
                )
            ],
          ),
          const SizedBox(
            height: spacer1,
          ),
          child,
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.33,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.33,
            ),
            child: Row(
              crossAxisAlignment: wrapLabelText
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    processedLabel!.length > 64
                        ? '${processedLabel.substring(0, 64)}...'
                        : processedLabel,
                    maxLines: wrapLabelText ? 5 : 1,
                    style: currentTypography.bodyL.copyWith(
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
                if (infoText != null) const SizedBox(width: spacer1),
                if (infoText != null)
                  Tooltip(
                    message: infoText,
                    preferBelow: preferToolTipBelow,
                    triggerMode: tooltipTriggerMode,
                    child: Icon(
                      Icons.info_outline,
                      size: spacer5,
                      color: const DigitColors().light.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            width: spacer4,
          ),
          Flexible(
            child: child,
          ),
        ],
      );
    }
  }
}
