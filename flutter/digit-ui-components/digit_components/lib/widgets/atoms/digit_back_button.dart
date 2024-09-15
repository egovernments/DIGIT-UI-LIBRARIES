import 'package:flutter/material.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import '../../theme/ComponentTheme/back_button_theme.dart';


class DigitBackButton extends StatelessWidget {
  final VoidCallback? handleBack;
  final String backDigitButtonText;
  final DigitBackButtonThemeData? digitBackButtonThemeData;

  const DigitBackButton({
    super.key,
    this.handleBack,
    this.backDigitButtonText = 'Back',
    this.digitBackButtonThemeData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backDigitButtonTheme = digitBackButtonThemeData ??
        theme.extension<DigitBackButtonThemeData>() ??
        DigitBackButtonThemeData.defaultTheme(context);

    return Container(
      padding: backDigitButtonTheme.contentPadding,
      child: InkWell(
        onTap: handleBack,
        hoverColor: theme.colorTheme.generic.transparent,
        highlightColor: theme.colorTheme.generic.transparent,
        splashColor: theme.colorTheme.generic.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(backDigitButtonTheme.backDigitButtonIcon != null && backDigitButtonTheme.disabledBackDigitButtonIcon != null)
              handleBack!=null ? backDigitButtonTheme.backDigitButtonIcon! : backDigitButtonTheme.disabledBackDigitButtonIcon!,
            SizedBox(
              width: theme.spacerTheme.spacer1,
            ),
            Text(
              backDigitButtonText,
              style: backDigitButtonTheme.textStyle?.copyWith(
                color: handleBack == null
                    ? backDigitButtonTheme.disabledTextColor
                    : backDigitButtonTheme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}