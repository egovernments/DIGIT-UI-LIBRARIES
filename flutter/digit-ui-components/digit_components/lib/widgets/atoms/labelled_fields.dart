import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    if(isDesktop){
      return Padding(
        padding: padding ?? const EdgeInsets.only(top: kPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      label!.length > 64
                          ? '${label!.substring(0, 64)}...'
                          : label!,
                      style: DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                          ?.copyWith(
                        color: const DigitColors().woodsmokeBlack,
                        overflow: wrapLabelText
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (isRequired)
                    Text(
                      ' *',
                      style: DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                          ?.copyWith(
                        color: const DigitColors().lavaRed,
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
            ),
            const SizedBox(width: 16,),
            child,
          ],
        ),
      );
    }else {
      return Padding(
        padding: padding ?? const EdgeInsets.only(top: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    label!.length > 64
                        ? '${label!.substring(0, 64)}...'
                        : label!,
                    style: DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                        ?.copyWith(
                      color: const DigitColors().woodsmokeBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (isRequired)
                  Text(
                    ' *',
                    style: DigitTheme.instance.mobileTheme.textTheme.bodyLarge
                        ?.copyWith(
                      color: const DigitColors().lavaRed,
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
            const SizedBox(height: 4,),
            child,
          ],
        ),
      );
    }
  }
}