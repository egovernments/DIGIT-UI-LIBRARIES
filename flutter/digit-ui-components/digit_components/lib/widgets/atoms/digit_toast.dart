import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../enum/app_enums.dart';
import '../../theme/ComponentTheme/toast_theme_data.dart';
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
    DigitToastThemeData? digitToastThemeData,
  }) {
    final theme = Theme.of(context);
    final toastThemeData = digitToastThemeData ??
        theme.extension<DigitToastThemeData>() ??
        DigitToastThemeData.defaultTheme(context);
    showToastWidget(
      _buildToastWidget(message, type, context, toastThemeData),
      context: context,
      duration: toastThemeData.animationDuration,
      position: toastThemeData.toastPosition,
      isIgnoring: false,
      animation: toastThemeData.animation,
      reverseAnimation: toastThemeData.reverseAnimation,
      animDuration: animationDuration,
    );
  }

  static Widget _buildToastWidget(String message, ToastType type,
      BuildContext context, DigitToastThemeData toastThemeData) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        minWidth: toastThemeData.toastWidth,
      ),
      color: type == ToastType.success
          ? toastThemeData.successColor
          : type == ToastType.error
              ? toastThemeData.errorColor
              : type == ToastType.warning
                  ? toastThemeData.warningColor
                  : toastThemeData.infoColor,
      padding: toastThemeData.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: theme.spacerTheme.spacer6,
                width: theme.spacerTheme.spacer6,
                child: type == ToastType.success
                    ? toastThemeData.successIcon
                    : type == ToastType.error
                        ? toastThemeData.errorIcon
                        : type == ToastType.warning
                            ? toastThemeData.warningIcon
                            : toastThemeData.infoIcon,
              ),
              SizedBox(width: theme.spacerTheme.spacer2),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      (theme.spacerTheme.spacer6) * 3,
                ),
                child: Text(
                  convertInToSentenceCase(message)!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: toastThemeData.textStyle,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              ToastManager().dismissAll(showAnim: false);
            },
            child: toastThemeData.cancelIcon,
          ),
        ],
      ),
    );
  }
}
