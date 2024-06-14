import 'dart:math';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/back_button_theme.dart';
import 'package:flutter/material.dart';

class BackNavigationButton extends StatelessWidget {
  final VoidCallback? handleBack;
  final String backButtonText;
  final BackNavigationButtonThemeData? backNavigationButtonThemeData;

  const BackNavigationButton({
    super.key,
    this.handleBack,
    this.backButtonText = 'Back',
    this.backNavigationButtonThemeData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backButtonTheme = backNavigationButtonThemeData ?? theme.extension<BackNavigationButtonThemeData>() ?? BackNavigationButtonThemeData.defaultTheme(context);

    return Container(
      padding: backButtonTheme.contentPadding,
      child: InkWell(
        onTap: handleBack,
        hoverColor: const DigitColors().transparent,
        highlightColor: const DigitColors().transparent,
        splashColor: const DigitColors().transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
                angle: backButtonTheme.backButtonIcon != null ? 0 : pi,
                alignment: Alignment.center,
                child: Icon(
                  backButtonTheme.backButtonIcon ?? Icons.double_arrow,
                  size: 24,
                  color: handleBack==null ? const DigitColors().light.textDisabled : const DigitColors().light.primary1,
                )),
            const SizedBox(
              width: 4,
            ),
            Text(
              backButtonText,
              // style: currentTypography.bodyL.copyWith(
              //   color: handleBack==null ? const DigitColors().light.textDisabled : const DigitColors().light.primary1,
              // ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}