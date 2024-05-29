import 'package:digit_ui_components/constants/AppView.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class SelectionChip<T> extends StatelessWidget {
  final String label;
  final VoidCallback onItemDelete;
  final bool capitalizedFirstLetter;
  final String? errorMessage;

  const SelectionChip({
    Key? key,
    required this.label,
    required this.onItemDelete,
    this.capitalizedFirstLetter = true,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Capitalize the first letter if required

    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    String capitalizeFirstLetter(String text) {
      if (text.isNotEmpty && capitalizedFirstLetter) {
        return text.substring(0, 1).toUpperCase() + text.substring(1);
      }
      return text;
    }

    DigitTypography currentTypography = getTypography(context, false);

    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kPadding,
              vertical: kPadding,
            ),
            decoration: BoxDecoration(
              boxShadow: errorMessage != null
                  ? [
                      BoxShadow(
                        color: const DigitColors()
                            .light
                            .alertError
                            .withOpacity(.30),
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
              borderRadius: BorderRadius.circular(4),
              color: errorMessage != null
                  ? const DigitColors().light.paperPrimary
                  : const DigitColors().light.genericBackground,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    capitalizeFirstLetter(label),
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
                  width: kPadding,
                ),
                InkWell(
                  onTap: onItemDelete,
                  hoverColor: const DigitColors().transparent,
                  splashColor: const DigitColors().transparent,
                  highlightColor: const DigitColors().transparent,
                  child: Container(
                    width: isDesktop ? 24 : 20,
                    height: isDesktop ? 24 : 20,
                    decoration: BoxDecoration(
                      color: errorMessage != null
                          ? const DigitColors().light.alertError
                          : const DigitColors().light.textSecondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.close,
                      size: isDesktop ? 24 : 20,
                      color: const DigitColors().light.paperPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (errorMessage != null)
            const SizedBox(
              height: 4,
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
                      height: 2,
                    ),
                    Icon(
                      Icons.info,
                      color: const DigitColors().light.alertError,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(width: kPadding / 2),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    errorMessage!.length > 256
                        ? '${capitalizeFirstLetter(errorMessage!).substring(0, 256)}...'
                        : capitalizeFirstLetter(errorMessage!),
                    style: currentTypography.bodyS.copyWith(
                      color: const DigitColors().light.alertError,
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class FileData {
  final String name;
  final String code;

  FileData({required this.name, required this.code});
}
