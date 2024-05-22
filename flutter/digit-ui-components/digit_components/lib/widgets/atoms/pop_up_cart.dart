import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../enum/app_enums.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../atoms/digit_button.dart';
import '../helper_widget/button_list.dart';

class Popup extends StatelessWidget {
  final String title;
  final PopUpType type;
  final double? width;
  final Icon? titleIcon;
  final String? subHeading;
  final String? description;
  final List<Widget>? additionalWidgets;
  final String? primaryActionText;
  final String? secondaryActionText;
  final void Function()? onCrossTap;
  final void Function()? onPrimaryAction;
  final void Function()? onSecondaryAction;

  const Popup({
    super.key,
    required this.title,
    this.type = PopUpType.simple,
    this.width,
    this.titleIcon,
    this.subHeading,
    this.description,
    this.additionalWidgets,
    this.primaryActionText,
    this.secondaryActionText,
    this.onCrossTap,
    this.onPrimaryAction,
    this.onSecondaryAction,
  });

  Widget _buildSimplePopUp(DigitTypography currentTypography, double width) {

    double currWidth = titleIcon!=null ? width-108 : width-68;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
              const EdgeInsets.only(left: 24.0, right: 8.0, top: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleIcon != null) titleIcon!,
                  if (titleIcon != null)
                    const SizedBox(
                      width: 8,
                    ),
                  SizedBox(
                    width: currWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: currentTypography.headingL.copyWith(
                              color: const DigitColors().light.textPrimary),
                        ),
                        if (subHeading != null)
                          const SizedBox(
                            height: 8,
                          ),
                        if (subHeading != null)
                          Text(
                            subHeading!,
                            style: currentTypography.captionS.copyWith(
                              color: const DigitColors().light.textSecondary,
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 8,
              ),
              child: InkWell(
                  hoverColor: const DigitColors().transparent,
                  highlightColor: const DigitColors().transparent,
                  splashColor: const DigitColors().transparent,
                  onTap: onCrossTap,
                  child: Icon(
                    Icons.close,
                    size: 28,
                    color: const DigitColors().light.primary2,
                  )),
            ),
          ],
        ),
        if (description != null)
          const SizedBox(
            height: 16,
          ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              description!,
              style: currentTypography.bodyS.copyWith(
                color: const DigitColors().light.textPrimary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAlertPopUp(DigitTypography currentTypography) {
    return Container(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleIcon ??
              Icon(
                Icons.warning,
                size: 48,
                color: const DigitColors().light.alertError,
              ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: currentTypography.headingL
                .copyWith(color: const DigitColors().light.textPrimary),
          ),
          const SizedBox(
            width: 8,
          ),
          if (subHeading != null)
            const SizedBox(
              height: 8,
            ),
          if (subHeading != null)
            Text(
              subHeading!,
              textAlign: TextAlign.center,
              style: currentTypography.captionS.copyWith(
                color: const DigitColors().light.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    double cardWidth = width ?? (isMobile
        ? 328
        : isTab
        ? 500
        : 620);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
      child: Dialog.fullscreen(
        backgroundColor: const DigitColors().overLayColor.withOpacity(.50),
        child: Center(
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const DigitColors().light.paperPrimary,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.16),
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: type == PopUpType.alert
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                type == PopUpType.simple
                    ? _buildSimplePopUp(currentTypography, cardWidth)
                    : _buildAlertPopUp(currentTypography),
                const SizedBox(
                  height: 24,
                ),
                if (additionalWidgets != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: additionalWidgets!
                          .map(
                            (widgets) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: widgets,
                        ),
                      )
                          .toList(),
                    ),
                  ),
                if (additionalWidgets != null)
                  const SizedBox(
                    height: 24,
                  ),
                Padding(
                  padding: primaryActionText == null && secondaryActionText == null
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24),
                  child: isMobile
                      ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (primaryActionText != null)
                        Button(
                          mainAxisSize: MainAxisSize.max,
                          label: primaryActionText!,
                          size: ButtonSize.large,
                          type: ButtonType.primary,
                          onPressed: () {
                            //_closeCamera();
                          },
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (secondaryActionText != null)
                        Button(
                          mainAxisSize: MainAxisSize.max,
                          label: secondaryActionText!,
                          size: ButtonSize.large,
                          type: ButtonType.secondary,
                          isDisabled: onSecondaryAction == null,
                          onPressed: onSecondaryAction != null
                              ? onSecondaryAction!
                              : () {},
                        ),
                    ],
                  )
                      : Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonListTile(
                        spacing: 24,
                        buttons: [
                          if (secondaryActionText != null)
                            Button(
                              label: secondaryActionText!,
                              mainAxisSize: MainAxisSize.max,
                              size: ButtonSize.large,
                              type: ButtonType.secondary,
                              isDisabled: onSecondaryAction == null,
                              onPressed: onSecondaryAction != null
                                  ? onSecondaryAction!
                                  : () {},
                            ),
                          if (primaryActionText != null)
                            Button(
                              label: primaryActionText!,
                              size: ButtonSize.large,
                              mainAxisSize: MainAxisSize.max,
                              type: ButtonType.primary,
                              isDisabled: onPrimaryAction == null,
                              onPressed: onPrimaryAction != null
                                  ? onPrimaryAction!
                                  : () {},
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum PopUpType {
  simple,
  alert,
}