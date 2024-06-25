import 'package:flutter/material.dart';
import '../../theme/ComponentTheme/back_button_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';

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
    final backButtonTheme = backNavigationButtonThemeData ??
        theme.extension<BackNavigationButtonThemeData>() ??
        BackNavigationButtonThemeData.defaultTheme(context);

    return Container(
      padding: backButtonTheme.contentPadding,
      child: InkWell(
        onTap: handleBack,
        hoverColor: theme.colorTheme.generic.transparent,
        highlightColor: theme.colorTheme.generic.transparent,
        splashColor: theme.colorTheme.generic.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(backButtonTheme.backButtonIcon != null && backButtonTheme.disabledBackButtonIcon != null)
            handleBack!=null ? backButtonTheme.backButtonIcon! : backButtonTheme.disabledBackButtonIcon!,
            SizedBox(
              width: theme.spacerTheme.spacer1,
            ),
            Text(
              backButtonText,
              style: backButtonTheme.textStyle?.copyWith(
                color: handleBack == null
                    ? backButtonTheme.disabledTextColor
                    : backButtonTheme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
