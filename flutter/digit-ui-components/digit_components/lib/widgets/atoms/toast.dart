import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../../constants/AppView.dart';
import '../../utils/utils.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();

  factory ToastManager() {
    return _instance;
  }

  ToastManager._internal();

  void toastShow(BuildContext context, String message, ToastType toastType) {
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastWidget(
        message: message,
        type: toastType,
        onDismiss: () => overlayEntry?.remove(),
      ),
    );

    Overlay.of(context)!.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry!.mounted) {
        overlayEntry?.remove();
      }
    });
  }
}

class ToastWidget extends StatelessWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;

  const ToastWidget({
    Key? key,
    required this.message,
    required this.type,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);

    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? 480
        : 800;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            minWidth: minWidth,
          ),
          color: type == ToastType.success
              ? const DigitColors().light.alertSuccess
              : type == ToastType.error
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
                      type == ToastType.success
                          ? Icons.check_circle
                          : type == ToastType.error
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
                      capitalizeFirstLetter(message)!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: currentTypography.captionS.copyWith(
                        color: const DigitColors().light.paperPrimary,
                      ),
                    ),
                  ),

                ],
              ),
              InkWell(
                onTap: onDismiss,
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
    );
  }
}

