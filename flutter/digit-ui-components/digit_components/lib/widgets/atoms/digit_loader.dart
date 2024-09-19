import 'dart:ui';

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';

class DigitLoaders {
  // Circular Loader with customizable options
  static Widget circularLoader({
    required BuildContext context,
    String? label,
    Color? loaderColor,
    Color? textColor,
    double? loaderSize,
    TextStyle? textStyle,
    bool fullPageOverlay = true,
    bool barrierDismissible = false,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return PopScope(
      onPopInvoked: null,
      canPop: barrierDismissible,
      child: SizedBox(
        height: fullPageOverlay ? MediaQuery.of(context).size.height : null,
        width: fullPageOverlay ? MediaQuery.of(context).size.width : null,
        child: SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: loaderColor ?? theme.colorTheme.primary.primary1,
                    strokeWidth: loaderSize ?? 4.0,
                  ),
                  if (label != null) ...[
                    const SizedBox(height: spacer3),
                    Text(
                      label,
                      style: textStyle ?? textTheme.headingS,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Full Page Loader Dialog with customization
  static Future<void> showLoadingDialog({
    required BuildContext context,
    String? label,
    Color? loaderColor,
    Color? backgroundColor,
    Color? textColor,
    double? loaderSize,
    TextStyle? textStyle,
    bool barrierDismissible = false,
  }) async {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return PopScope(
          onPopInvoked: null,
          canPop: barrierDismissible,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: backgroundColor?.withOpacity(0.7) ??
                    theme.colorTheme.text.primary.withOpacity(.7),
                child: SimpleDialog(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: loaderColor ??
                                Theme.of(context).colorTheme.primary.primary1,
                            strokeWidth: loaderSize ?? 4.0,
                          ),
                          if (label != null) ...[
                            const SizedBox(height: spacer3),
                            Text(label,
                                style: textStyle ??
                                    textTheme.headingS.copyWith(
                                      color: theme.colorTheme.paper.primary,
                                    )),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to hide the loader dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).popUntil(
          (route) => route is! PopupRoute,
    );
  }
}