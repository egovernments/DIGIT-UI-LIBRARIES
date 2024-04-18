import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../utils/utils.dart';

class Toast {
  final ToastOptions options;

  static FToast fToast = FToast();

  @visibleForTesting
  Toast({
    required this.options,
  });

  static show<T>(
      BuildContext context, {
        required ToastOptions options,
        Duration? duration,
      }) {
    fToast.init(context);

    DigitTypography currentTypography = getTypography(context);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    double inputWidth = isMobile
        ? MediaQuery.of(context).size.width
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width * .64
        : MediaQuery.of(context).size.width * .55;


    return fToast.showToast(
      child: Container(
        constraints: BoxConstraints(
          minWidth: inputWidth,
        ),
        color: options.type == ToastType.success
            ? const DigitColors().light.alertSuccess
            : options.type == ToastType.error
            ? const DigitColors().light.alertError
            : const DigitColors().light.alertWarning,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    options.type == ToastType.success
                        ? Icons.check_circle
                        : options.type == ToastType.error
                        ? Icons.error
                        : Icons.warning,
                    color: const DigitColors().light.paperPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: kPadding),
                Container(
                  constraints: BoxConstraints(
                    maxWidth:  MediaQuery.of(context).size.width- 24 - kPadding * 3 - 24,
                  ),
                  child: Text(
                    capitalizeFirstLetter(options.message)!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: currentTypography.captionS.copyWith(
                      color: const DigitColors().light.paperPrimary,
                      height: 1.172,
                    ),
                  ),
                ),

              ],
            ),
            InkWell(
              onTap: () {
                fToast.removeCustomToast();
              },
              child: Icon(
                Icons.close,
                size: 24,
                color: const DigitColors().light.paperPrimary,
              ),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.SNACKBAR,
      toastDuration: duration ?? toastDuration,
    );
  }
}

class ToastOptions {
  final String message;
  final ToastType type;

  ToastOptions(this.message, this.type);
}

enum ToastType {
  success,
  error,
  warning,
}