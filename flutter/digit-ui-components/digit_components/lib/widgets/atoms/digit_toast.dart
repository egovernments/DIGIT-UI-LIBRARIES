import 'package:digit_flutter_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';

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

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);

    double inputWidth = isMobile
        ? 360
        : AppView.isTabletView(MediaQuery.of(context).size.width)
            ? 480
            : 800;

    return fToast.showToast(
      child: Flexible(
        child: Container(
          // width: inputWidth,
          constraints: BoxConstraints(
            minWidth: inputWidth,
          ),
          color: options.type == ToastType.success
              ? const DigitColors().light.alertSuccess
              : options.type == ToastType.error
                  ? const DigitColors().light.alertError
                  : const DigitColors().light.alertWarning,
          padding:
              const EdgeInsets.only(left: 12.0, top: 12.0, right: 8, bottom: 12),
          child: Row(
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
              const SizedBox(
                width: kPadding,
              ),
              Expanded(
                child: Text(
                  options.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: currentTypography.captionS.copyWith(
                    color: const DigitColors().light.paperPrimary,
                    height: 1.172,
                  ),
                ),
              ),
              const SizedBox(width: kPadding),
              InkWell(
                hoverColor: const DigitColors().transparent,
                highlightColor: const DigitColors().transparent,
                splashColor: const DigitColors().transparent,
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
