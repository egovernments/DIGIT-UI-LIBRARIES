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
        ToastPosition? position,
        StyledToastPosition? customPosition,
        DigitToastThemeData? digitToastThemeData,
      }) {
    final theme = Theme.of(context);
    final toastThemeData = digitToastThemeData ??
        theme.extension<DigitToastThemeData>();
    final defaultThemeData = DigitToastThemeData.defaultTheme(context);

    /// Determine the position based on the enum or custom position
    final styledPosition = position == ToastPosition.custom && customPosition != null
        ? customPosition
        : _mapPosition(context, position ?? ToastPosition.bottom, defaultThemeData);

    showToastWidget(
      buildToastWidget(message, type, context, toastThemeData,),
      context: context,
      duration: toastThemeData?.animationDuration ?? defaultThemeData.animationDuration,
      position: toastThemeData?.toastPosition ?? styledPosition,
      isIgnoring: false,
      animation: toastThemeData?.animation ?? defaultThemeData.animation,
      reverseAnimation: toastThemeData?.reverseAnimation ?? defaultThemeData.reverseAnimation,
      animDuration: animationDuration,
    );
  }

  /// Maps the custom [ToastPosition] to [StyledToastPosition]
  static StyledToastPosition _mapPosition(
      BuildContext context, ToastPosition position, DigitToastThemeData defaultThemeData) {
    switch (position) {
      case ToastPosition.aboveOneButtonFooter:
      // Position above a single-button footer
        return const StyledToastPosition(
          align: Alignment.bottomCenter,
          offset: 72,
        );
      case ToastPosition.aboveTwoButtonFooter:
      // Position above a two-button footer
        return const StyledToastPosition(
          align: Alignment.bottomCenter,
          offset: 128,
        );
      case ToastPosition.bottom:
        return defaultThemeData.toastPosition!;
      case ToastPosition.custom:
      // This case is handled directly in the `showToast` method if `customPosition` is provided
        throw ArgumentError(
            "Custom position requires a customPosition parameter.");
      default:
        return StyledToastPosition.bottom;
    }
  }

  static Widget buildToastWidget(String message, ToastType type,
      BuildContext context, DigitToastThemeData? toastThemeData) {
    final theme = Theme.of(context);
    final defaultThemeData = DigitToastThemeData.defaultTheme(context);


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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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