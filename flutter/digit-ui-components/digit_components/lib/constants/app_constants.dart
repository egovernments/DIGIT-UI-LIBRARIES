import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/digit_theme.dart';

class Default{
  static const double height = 40;
  static const double mobileInputWidth = 328;
  static const double desktopInputWidth = 600;
  static const double tabInputWidth = 440;
  static const double defaultChipRadius = 50;
  static const EdgeInsets defaultChipPadding = EdgeInsets.only(
    left: 12,
    right: kPadding / 2,
  );
  static const String textAreaSvg = 'assets/icons/svg/text_area_expand.svg';
  static const String profileSvg = 'assets/icons/svg/Profile.svg';
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

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: const DigitColors().light.primaryOrange, width: 1.5),
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


class DigitButtonConstants {
  static const EdgeInsets defaultButtonPadding = EdgeInsets.all(8.0);
  static const EdgeInsets defaultContentPadding = EdgeInsets.only(left: 24.0, top: 7.0, right: 24.0, bottom: 8.0);
  static const double defaultIconSize = 24.0;
  static final Color defaultDisabledColor = const DigitColors().light.textDisabled;
  static final Color defaultPrimaryColor = const DigitColors().light.primaryOrange;
  static final Color defaultSecondaryColor = const DigitColors().light.textPrimary;
  static final Color defaultTextColor = const DigitColors().light.paperPrimary;
  static const double defaultWidth = 1.0;
  static const double defaultHoverWidth = 2.0;
}
class CheckboxConstants {
  static const double iconSize = 16.0;
  static const double containerSize = 24.0;
  static const double borderWidth = 2.0;
  static const EdgeInsets defaultPadding = EdgeInsets.only(left: 4.0);

  static Color uncheckedBorderColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.textSecondary);

  static Color checkedBorderColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.primaryOrange);

  static Color intermediateBorderColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.primaryOrange);

  static Color iconColor({required bool isDisabled, required Color? customColor}) =>
      customColor ?? (isDisabled ? const DigitColors().light.textDisabled : const DigitColors().light.primaryOrange);
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
  static const EdgeInsets noItemAvailablePadding =  EdgeInsets.symmetric(horizontal: kPadding*2, vertical: 10.0);
  static const Duration animationDuration = Duration(milliseconds: 200);
}

class RadioConstant {
  static const EdgeInsets defaultPadding = EdgeInsets.all(8);
  static const double radioWidth = 24.0;
  static const double radioHeight = 24.0;
}

Duration get toastDuration => const Duration(seconds: 5);