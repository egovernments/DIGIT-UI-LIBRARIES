import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class Base{
  static const double height = 40;
  static const double mobileInputWidth = 328;
  static const double desktopInputWidth = 600;
  static const double tabInputWidth = 440;
  static const double defaultCircularRadius = 50;
  static const double defaultBorderWidth = 1;
  static const double selectedBorderWidth = 1;
  static const double focusedBorderWidth = 1.5;
  static const double errorBorderWidth = 1.5;
  static const double hoverBorderWidth = 0.5;
  static const BorderRadius radius = BorderRadius.zero;
  static const double imageSize = 100;
  static const String textAreaSvg = 'assets/icons/svg/text_area_expand.svg';
  static const String profileSvg = 'assets/icons/svg/Profile.svg';
  static const String docSvg = 'assets/icons/svg/doc.svg';
  static const String jpgSvg = 'assets/icons/svg/jpg.svg';
  static const String pdfSvg = 'assets/icons/svg/pdf.svg';
  static const String pngSvg = 'assets/icons/svg/png.svg';
  static const String xlsxSvg = 'assets/icons/svg/xlsx.svg';
  static const String fileSvg = 'assets/icons/svg/file.svg';
  static const String errorJson = 'assets/animated_json/error.json';
  static const String successJson = 'assets/animated_json/success.json';
  static const String digitLogoDarkSvg = 'assets/images/digit_logo_dark.png';
  static const String digitLogoLightSvg = 'assets/images/digit_logo_light.png';
  static const String profileIconSvg = 'assets/icons/svg/profile_icon.svg';
}

class BaseConstants {
  static const double suffixIconSize = 24.0;
  static const double errorIconSize = 16.0;
  static const double inputMaxHeight = 100.0;
  static const double inputMinHeight = 40.0;
  static const double mobileInputMaxWidth = 328.0;
  static const double mobileInputMinWidth = 156.0;
  static const double desktopInputMaxWidth = 600.0;
  static const double desktopInputMinWidth = 200.0;
  static const double tabInputMaxWidth = 440.0;
  static const double tabInputMinWidth = 200.0;
  static const double successAnimationM = 80;
  static const double successAnimationT = 100;
  static const double successAnimationD = 120;
  static const double errorAnimationM = 56;
  static const double errorAnimationT = 64;
  static const double errorAnimationD = 74;

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: const DigitColors().light.primary1, width: 1.5),
    borderRadius: BorderRadius.zero,
  );

  static final OutlineInputBorder disabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: const DigitColors().light.genericDivider, width: 1.0),
    borderRadius: BorderRadius.zero,
  );
  // Spacing
  static const double defaultPadding = 12.0;
}


class ButtonConstants {
  static const EdgeInsets defaultButtonPadding = EdgeInsets.all(spacer1);
  static const EdgeInsets defaultContentPadding = EdgeInsets.symmetric(horizontal: spacer6, vertical: 0);
  static const double largeButtonSize = 40.0;
  static const double mediumButtonSize = 32.0;
  static const double smallButtonSize = 24.0;
  static const double largeIconSize = 24.0;
  static const double mediumIconSize = 20.0;
  static const double smallIconSize = 14.0;
  static const double largeLinkIconSize = 20.0;
  static const double mediumLinkIconSize = 20.0;
  static const double smallLinkIconSize = 14.0;
}
class DigitCheckboxConstants {
  static const double iconSize = 16.0;
  static const double containerSize = 24.0;
  static const double borderWidth = 2.0;
  static const EdgeInsets defaultPadding = EdgeInsets.only(left: 4.0);

  static Color uncheckedBorderColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.textSecondary);

  static Color checkedBorderColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.primary1);

  static Color intermediateBorderColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.primary1);

  static Color iconColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.primary1);
}

class DropdownConstants {
  static const EdgeInsetsGeometry defaultPadding =
  EdgeInsets.only(left: 10, top: 9.5, bottom: 9.5,);
  static const EdgeInsetsGeometry nestedItemPadding =
  EdgeInsets.only(left: 10, top: 9.5, bottom: 9.5,);
  static const EdgeInsetsGeometry nestedItemHeaderPadding =EdgeInsets.all(10);
  static const double defaultProfileSize = 32;
  static const double defaultImageRadius = 72;
  static const double textIconSize = 20;
  static const EdgeInsets noItemAvailablePadding =  EdgeInsets.symmetric(horizontal: spacer4, vertical: 10.0);
  static const Duration animationDuration = Duration(milliseconds: 200);
}

class RadioConstant {
  static const EdgeInsets defaultPadding = EdgeInsets.all(spacer4);
  static const double radioWidth = spacer6;
  static const double radioHeight = spacer6;
}

class ToastConstant {
  static const double tabMinWidth = 480;
  static const double desktopMinWidth = 800;
  Duration get toastDuration => const Duration(seconds: 5);
}

class PopUpCardConstant {
  /// Margins
  static const double verticalMarginMobile = 64.0;
  static const double verticalMarginTab = 100.0;
  static const double verticalMarginDesktop = 74.0;

  static const double horizontalMarginMobile = 16.0;
  static const double horizontalMarginTab = 98.0;
  static const double horizontalMarginDesktop = 446.0;

}

