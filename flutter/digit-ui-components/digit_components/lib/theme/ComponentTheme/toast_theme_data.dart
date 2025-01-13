import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../constants/AppView.dart';

class DigitToastThemeData extends ThemeExtension<DigitToastThemeData> {
  final TextStyle? textStyle;
  final Color? successColor;
  final Color? errorColor;
  final Color? warningColor;
  final Color? infoColor;
  final Icon? successIcon;
  final Icon? errorIcon;
  final Icon? warningIcon;
  final Icon? infoIcon;
  final Icon? cancelIcon;
  final double? toastWidth;
  final int? maxLine;
  final EdgeInsets? padding;
  final Duration? animationDuration;
  final StyledToastAnimation? animation;
  final StyledToastAnimation? reverseAnimation;
  final StyledToastPosition? toastPosition;

  const DigitToastThemeData({
    this.textStyle,
    this.successColor,
    this.errorColor,
    this.warningColor,
    this.infoColor,
    this.successIcon,
    this.errorIcon,
    this.warningIcon,
    this.infoIcon,
    this.cancelIcon,
    this.toastWidth,
    this.padding,
    this.maxLine,
    this.animationDuration,
    this.animation,
    this.reverseAnimation,
    this.toastPosition,
  });

  static DigitToastThemeData defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    double width = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? 480
        : 800;

    return DigitToastThemeData(
      textStyle: textTheme.captionS.copyWith(
        color: theme.colorTheme.paper.primary,
      ),
      successColor: theme.colorTheme.alert.success,
      errorColor: theme.colorTheme.alert.error,
      warningColor: theme.colorTheme.alert.warning,
      infoColor: theme.colorTheme.alert.info,
      successIcon: Icon(
       Icons.check_circle,
        color: theme.colorTheme.paper.primary,
        size: theme.spacerTheme.spacer6,
      ),
      errorIcon: Icon(Icons.error, color: theme.colorTheme.paper.primary, size: theme.spacerTheme.spacer6,),
      warningIcon: Icon(Icons.warning, color: theme.colorTheme.paper.primary, size: theme.spacerTheme.spacer6,),
      infoIcon: Icon(Icons.info, color: theme.colorTheme.paper.primary, size: theme.spacerTheme.spacer6,),
      cancelIcon: Icon(Icons.close, color: theme.colorTheme.paper.primary, size: theme.spacerTheme.spacer6,),
      toastWidth: width,
      maxLine: 1,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      animationDuration: const Duration(seconds: 5),
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      toastPosition: const StyledToastPosition(
        align: Alignment.bottomCenter,
        offset: 0
      ),
    );
  }

  @override
  DigitToastThemeData copyWith({
    TextStyle? textStyle,
    Color? successColor,
    Color? errorColor,
    Color? warningColor,
    Color? infoColor,
    Icon? successIcon,
    Icon? errorIcon,
    Icon? warningIcon,
    Icon? infoIcon,
    Icon? cancelIcon,
    double? toastWidth,
    int? maxLine,
    EdgeInsets? padding,
    Duration? animationDuration,
    StyledToastAnimation? animation,
    StyledToastAnimation? reverseAnimation,
    StyledToastPosition? toastPosition,
  }) {
    return DigitToastThemeData(
      textStyle: textStyle ?? this.textStyle,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      successIcon: successIcon ?? this.successIcon,
      errorIcon: errorIcon ?? this.errorIcon,
      warningIcon: warningIcon ?? this.warningIcon,
      infoIcon: infoIcon ?? this.infoIcon,
      cancelIcon: cancelIcon ?? this.cancelIcon,
      toastWidth: toastWidth ?? this.toastWidth,
      maxLine: maxLine ?? this.maxLine,
      padding: padding ?? this.padding,
      animationDuration: animationDuration ?? this.animationDuration,
      animation: animation ?? this.animation,
      reverseAnimation: reverseAnimation ?? this.reverseAnimation,
      toastPosition: toastPosition ?? this.toastPosition,
    );
  }

  @override
  DigitToastThemeData lerp(ThemeExtension<DigitToastThemeData>? other, double t) {
    if (other is! DigitToastThemeData) return this;

    return DigitToastThemeData(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      infoColor: Color.lerp(infoColor, other.infoColor, t),
      successIcon: t<0.5 ? successIcon : other.successIcon,
      errorIcon: t<0.5 ? errorIcon : other.errorIcon,
      warningIcon: t<0.5 ? warningIcon : other.warningIcon,
      infoIcon: t<0.5 ? infoIcon : other.infoIcon,
      cancelIcon: t<0.5 ? cancelIcon : other.cancelIcon,
      toastWidth: t<0.5 ? toastWidth : other.toastWidth,
      maxLine: t<0.5 ? maxLine : other.maxLine,
      padding: EdgeInsets.lerp(padding, other.padding, t),
      animationDuration: t<0.5 ? animationDuration : other.animationDuration,
      animation: t<0.5 ? animation : other.animation,
      reverseAnimation: t<0.5 ? reverseAnimation : other.reverseAnimation,
      toastPosition: t<0.5 ? toastPosition : other.toastPosition,
    );
  }
}
