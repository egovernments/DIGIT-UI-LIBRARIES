import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/utils/utils.dart';
import 'package:flutter/material.dart';

class SelectionChip<T> extends StatelessWidget {
  final String label;
  final VoidCallback onItemDelete;
  final VoidCallback? onClick;
  final bool capitalizedFirstLetter;
  final String? errorMessage;

  const SelectionChip({
    Key? key,
    required this.label,
    required this.onItemDelete,
    this.onClick,
    this.capitalizedFirstLetter = true,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Capitalize the first letter if required

    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    final String capitalizedTitle = capitalizedFirstLetter ? (convertInToSentenceCase(label) ?? label) : label;
    final String? capitalizedErrorMessage = capitalizedFirstLetter ? convertInToSentenceCase(errorMessage) : errorMessage;

    DigitTypography currentTypography = getTypography(context, false);

    return InkWell(
      onTap: onClick,
      hoverColor: const DigitColors().transparent,
      highlightColor: const DigitColors().transparent,
      splashColor: const DigitColors().transparent,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: spacer2,
                vertical: spacer2,
              ),
              decoration: BoxDecoration(
                boxShadow: errorMessage != null
                    ? [
                  BoxShadow(
                    color: const DigitColors()
                        .light
                        .alertError
                        .withOpacity(.15),
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                    blurRadius: 4,
                  ),
                ]
                    : [],
                border: Border.all(
                  color: errorMessage != null
                      ? const DigitColors().light.alertError
                      : const DigitColors().light.genericDivider,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(spacer1),
                color: errorMessage != null
                    ? const DigitColors().light.paperPrimary
                    : const DigitColors().light.genericBackground,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      capitalizedTitle,
                      style: errorMessage != null
                          ? currentTypography.headingXS.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: const DigitColors().light.alertError,
                      )
                          : currentTypography.bodyXS.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: const DigitColors().light.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: spacer2,
                  ),
                  InkWell(
                    onTap: onItemDelete,
                    hoverColor: const DigitColors().transparent,
                    splashColor: const DigitColors().transparent,
                    highlightColor: const DigitColors().transparent,
                    child: Container(
                      width: isDesktop ? spacer6 : spacer5,
                      height: isDesktop ? spacer6 : spacer5,
                      decoration: BoxDecoration(
                        color: errorMessage != null
                            ? const DigitColors().light.alertError
                            : const DigitColors().light.textSecondary,
                        borderRadius: BorderRadius.circular(spacer1),
                      ),
                      child: Icon(
                        Icons.close,
                        size: isDesktop ? spacer6 : spacer5,
                        color: const DigitColors().light.paperPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (errorMessage != null)
              const SizedBox(
                height: spacer1,
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
                        height: spacer1/2,
                      ),
                      Icon(
                        Icons.info,
                        color: const DigitColors().light.alertError,
                        size: spacer4,
                      ),
                    ],
                  ),
                  const SizedBox(width: spacer1),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      errorMessage!.length > 256
                          ? truncateWithEllipsis(256, capitalizedErrorMessage!)
                          : capitalizedErrorMessage!,
                      style: currentTypography.bodyS.copyWith(
                        color: const DigitColors().light.alertError,
                      ),
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