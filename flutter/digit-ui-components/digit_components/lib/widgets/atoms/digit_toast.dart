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
        theme.extension<DigitToastThemeData>();
        final defaultThemeData = DigitToastThemeData.defaultTheme(context);
    showToastWidget(
      _buildToastWidget(message, type, context, toastThemeData, defaultThemeData),
      context: context,
      duration: toastThemeData?.animationDuration ?? defaultThemeData.animationDuration,
      position: toastThemeData?.toastPosition ?? defaultThemeData.toastPosition,
      isIgnoring: false,
      animation: toastThemeData?.animation ?? defaultThemeData.animation,
      reverseAnimation: toastThemeData?.reverseAnimation ?? defaultThemeData.reverseAnimation,
      animDuration: animationDuration,
    );
  }

  static Widget _buildToastWidget(String message, ToastType type,
      BuildContext context, DigitToastThemeData? toastThemeData, DigitToastThemeData defaultThemeData) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        minWidth: toastThemeData?.toastWidth ?? defaultThemeData.toastWidth!,
      ),
      color: type == ToastType.success
          ? toastThemeData?.successColor ?? defaultThemeData.successColor
          : type == ToastType.error
              ? toastThemeData?.errorColor ?? defaultThemeData.errorColor
              : type == ToastType.warning
                  ? toastThemeData?.warningColor ?? defaultThemeData.warningColor
                  : toastThemeData?.infoColor ?? defaultThemeData.infoColor,
      padding: toastThemeData?.padding ?? defaultThemeData.padding,
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
                    ? toastThemeData?.successIcon ?? defaultThemeData.successIcon
                    : type == ToastType.error
                        ? toastThemeData?.errorIcon ?? defaultThemeData.errorIcon
                        : type == ToastType.warning
                            ? toastThemeData?.warningIcon ?? defaultThemeData.warningIcon
                            : toastThemeData?.infoIcon ?? defaultThemeData.infoIcon,
              ),
              SizedBox(width: theme.spacerTheme.spacer2),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      (theme.spacerTheme.spacer6) * 3,
                ),
                child: Text(
                  convertInToSentenceCase(message)!,
                  maxLines: toastThemeData?.maxLine ?? defaultThemeData.maxLine,
                  overflow: TextOverflow.ellipsis,
                  style: toastThemeData?.textStyle ?? defaultThemeData.textStyle,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              ToastManager().dismissAll(showAnim: false);
            },
            child: toastThemeData?.cancelIcon ?? defaultThemeData.cancelIcon,
          ),
        ],
      ),
    );
  }
}
