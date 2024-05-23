import 'package:digit_ui_components/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../constants/AppView.dart';
import '../../enum/app_enums.dart';
import '../../theme/theme.dart';
import '../../utils/utils.dart';

/// This class provides a static method to show custom toast notifications
/// with various options like duration, animation, and position.
/// Parameters:
/// - [context]: The build context from where the toast is shown.
/// - [message]: The message to be displayed in the toast.
/// - [type]: The type of toast to display, affecting the color and icon.
/// - [duration]: How long the toast should be visible (default is 5 seconds).
/// - [animationDuration]: The duration of the animation (if specified).
/// - [position]: The position on the screen where the toast appears (default is bottom center).

class Toast {
  static void showToast(
    BuildContext context, {
    required String message,
    required ToastType type,
    Duration? duration,
    Duration? animationDuration,
    StyledToastPosition? position,
  }) {
    showToastWidget(
      _buildToastWidget(message, type, context),
      context: context,
      duration: duration ?? ToastConstant().toastDuration,
      position: position ??
          const StyledToastPosition(
            align: Alignment.bottomCenter,
          ),
      isIgnoring: false,
      animation: StyledToastAnimation.slideFromBottom,
      animDuration: animationDuration,
    );
  }

  static Widget _buildToastWidget(
      String message, ToastType type, BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);

    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width
        : AppView.isTabletView(MediaQuery.of(context).size)
            ? ToastConstant.tabMinWidth
            : ToastConstant.desktopMinWidth;

    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
      ),
      color: type == ToastType.success
          ? const DigitColors().light.alertSuccess
          : type == ToastType.error
              ? const DigitColors().light.alertError
              : const DigitColors().light.alertWarning,
      padding:
          const EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: spacer6,
                width: spacer6,
                child: Icon(
                  type == ToastType.success
                      ? Icons.check_circle
                      : type == ToastType.error
                          ? Icons.error
                          : Icons.warning,
                  color: const DigitColors().light.paperPrimary,
                  size: spacer6,
                ),
              ),
              const SizedBox(width: spacer2),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      spacer6 -
                      spacer6 -
                      spacer6,
                ),
                child: Text(
                  convertInToSentenceCase(message)!,
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
            onTap: () {
              ToastManager().dismissAll(showAnim: false);
            },
            child: Icon(
              Icons.close,
              size: spacer6,
              color: const DigitColors().light.paperPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
