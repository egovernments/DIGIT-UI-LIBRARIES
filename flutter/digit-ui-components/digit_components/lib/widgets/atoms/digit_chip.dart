import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/chip_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/utils.dart';
import 'package:flutter/material.dart';

class DigitChip extends StatefulWidget {
  final String label;
  final String? semanticsLabel;
  final VoidCallback? onItemDelete;
  final VoidCallback? onClick;
  final bool capitalizedFirstLetter;
  final String? errorMessage;
  final IconData? icon;
  final DigitChipThemeData? digitChipThemeData;

  const DigitChip({
    Key? key,
    required this.label,
    this.semanticsLabel,
    this.onItemDelete,
    this.onClick,
    this.capitalizedFirstLetter = true,
    this.errorMessage,
    this.icon,
    this.digitChipThemeData,
  }) : super(key: key);

  @override
  _DigitChipState createState() => _DigitChipState();
}

class _DigitChipState extends State<DigitChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipThemeData = widget.digitChipThemeData ??
        theme.extension<DigitChipThemeData>() ??
        DigitChipThemeData.defaultTheme(context);

    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    final String capitalizedTitle = widget.capitalizedFirstLetter
        ? (convertInToSentenceCase(widget.label) ?? widget.label)
        : widget.label;
    final String? capitalizedErrorMessage = widget.capitalizedFirstLetter
        ? convertInToSentenceCase(widget.errorMessage)
        : widget.errorMessage;

    return Semantics(
      label: widget.semanticsLabel ?? widget.label,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MouseRegion(
              onEnter: (_) {
                if (widget.onClick != null) {
                  setState(() {
                    isHovered = true;
                  });
                }
              },
              onExit: (_) {
                if (widget.onClick != null) {
                  setState(() {
                    isHovered = false;
                  });
                }
              },
              child: InkWell(
                onTap: widget.onClick,
                hoverColor: theme.colorTheme.generic.transparent,
                highlightColor: theme.colorTheme.generic.transparent,
                splashColor: theme.colorTheme.generic.transparent,
                child: Container(
                  padding: chipThemeData.padding,
                  decoration: BoxDecoration(
                    boxShadow: widget.errorMessage != null &&
                        chipThemeData.errorBoxShadow != null
                        ? [
                      chipThemeData.errorBoxShadow!,
                    ]
                        : widget.onClick != null && isHovered
                        ? [
                      BoxShadow(
                        color: theme.colorTheme.text.primary
                            .withOpacity(.20),
                        offset: const Offset(0, 2),
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ]
                        : [],
                    border: Border.all(
                      color: (widget.errorMessage != null
                          ? chipThemeData.errorBorderColor
                          : chipThemeData.borderColor) ??
                          theme.colorTheme.generic.inputBorder,
                      width: chipThemeData.borderWidth ?? 1,
                    ),
                    borderRadius: BorderRadius.circular(spacer1),
                    color: (widget.errorMessage != null
                        ? chipThemeData.errorBackgroundColor
                        : chipThemeData.backgroundColor) ??
                        theme.colorTheme.generic.background,
                  ),
                  child: Row(
                    children: [
                      if (widget.icon != null)
                        Icon(widget.icon,
                            color: chipThemeData.iconColor, size: spacer4),
                      if (widget.icon != null)
                        const SizedBox(
                          width: spacer1,
                        ),
                      Expanded(
                        child: Text(
                          capitalizedTitle,
                          style: widget.errorMessage != null
                              ? chipThemeData.labelErrorTextStyle
                              : chipThemeData.labelTextStyle,
                        ),
                      ),
                      if (widget.onItemDelete != null)
                        SizedBox(
                          width: theme.spacerTheme.spacer2,
                        ),
                      if (widget.onItemDelete != null)
                        InkWell(
                          onTap: widget.onItemDelete,
                          hoverColor: theme.colorTheme.generic.transparent,
                          highlightColor: theme.colorTheme.generic.transparent,
                          splashColor: theme.colorTheme.generic.transparent,
                          child: Container(
                            width: isDesktop
                                ? theme.spacerTheme.spacer6
                                : theme.spacerTheme.spacer5,
                            height: isDesktop
                                ? theme.spacerTheme.spacer6
                                : theme.spacerTheme.spacer5,
                            decoration: BoxDecoration(
                              color: widget.errorMessage != null
                                  ? theme.colorTheme.alert.error
                                  : theme.colorTheme.text.secondary,
                              borderRadius: BorderRadius.circular(
                                  theme.spacerTheme.spacer1 ?? 0),
                            ),
                            child: chipThemeData.cancelIcon,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.errorMessage != null)
              SizedBox(
                height: theme.spacerTheme.spacer1,
              ),
            if (widget.errorMessage != null)
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
                      if (chipThemeData.errorIcon != null)
                        chipThemeData.errorIcon!,
                    ],
                  ),
                  const SizedBox(width: spacer1),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      widget.errorMessage!.length > 256
                          ? truncateWithEllipsis(
                          256, capitalizedErrorMessage!)
                          : capitalizedErrorMessage!,
                      style: chipThemeData.errorTextStyle,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
