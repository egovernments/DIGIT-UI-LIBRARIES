import 'dart:ui';

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:lottie/lottie.dart';

class DigitLoaders {

  // Full Page Loader Dialog with Lottie Animation
  static Widget showFullPageLoader({
    required BuildContext context,
    String? label,
    String? animationPath,
    Color? backgroundColor,
    TextStyle? textStyle,
    double? size,
    bool barrierDismissible = false,
  })  {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return PopScope(
      onPopInvoked: null,
      canPop: barrierDismissible,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    animationPath ?? Base.fullPageLoaderAnimation,
                    width: size ?? spacer5*5,
                    height: size ?? spacer5*5,

                  ),
                  if (label != null) ...[
                    const SizedBox(height: spacer1),
                    Text(
                      label,
                      style: textStyle ?? textTheme.headingS.copyWith(
                          color: theme.colorTheme.primary.primary2
                      ),
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

  // Overlay Loader with Lottie Animation
  static Future<void> overlayLoader({
    required BuildContext context,
    String? label,
    String? animationPath,
    Color? backgroundColor,
    TextStyle? textStyle,
    double? size,
    bool barrierDismissible = false,
  }) async {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            color: backgroundColor?.withOpacity(0.7) ??
                theme.colorTheme.text.primary.withOpacity(.7),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    animationPath ?? Base.overlayLoaderAnimation,
                    width: size ?? spacer5*5,
                    height: size ?? spacer5*5,
                  ),
                  if (label != null) ...[
                    const SizedBox(height: spacer1),
                    Text(
                      label,
                      style: textStyle ?? textTheme.headingS.copyWith(
                        color: theme.colorTheme.paper.primary
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget inlineLoader({
    String? animationPath,
    double? size,
  }) {
    return Lottie.asset(
      animationPath ?? Base.inlineLoaderAnimation,
      width: size ?? spacer12,
      height: size ?? spacer12,
    );
  }

  // Function to hide the loader dialog
  static void hideLoaderDialog(BuildContext context) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).popUntil(
          (route) => route is! PopupRoute,
    );
  }
}
