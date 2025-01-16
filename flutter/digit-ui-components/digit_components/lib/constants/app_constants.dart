import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class Base {
  // Basic layout constants
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
  static const String digitLogo = 'assets/images/powered_by_digit.png';
  static const String profileIconSvg = 'assets/icons/svg/profile_icon.svg';
  // Lottie animation paths for different loader categories
  static const String fullPageLoaderAnimation = 'assets/animated_json/page_loader.json';
  static const String overlayLoaderAnimation = 'assets/animated_json/overlay_loader.json';
  static const String inlineLoaderAnimation = 'assets/animated_json/inline_loader.json';
}

class BaseConstants {
  // Constants for input field sizes, borders, and spacing
  static const double suffixIconSize = 24.0;  // Size for suffix icons
  static const double errorIconSize = 16.0;   // Size for error icons
  static const double inputMaxHeight = 100.0; // Max height for input fields
  static const double inputMinHeight = 40.0;  // Min height for input fields
  static const double mobileInputMaxWidth = 328.0;  // Max width for mobile input
  static const double mobileInputMinWidth = 156.0;  // Min width for mobile input
  static const double desktopInputMaxWidth = 600.0; // Max width for desktop input
  static const double desktopInputMinWidth = 200.0; // Min width for desktop input
  static const double tabInputMaxWidth = 440.0;     // Max width for tablet input
  static const double tabInputMinWidth = 200.0;     // Min width for tablet input
  static const double successAnimationM = 80;       // Success animation size for mobile
  static const double successAnimationT = 100;      // Success animation size for tablet
  static const double successAnimationD = 120;      // Success animation size for desktop
  static const double errorAnimationM = 56;         // Error animation size for mobile
  static const double errorAnimationT = 64;         // Error animation size for tablet
  static const double errorAnimationD = 74;         // Error animation size for desktop

  // Custom borders for focused and disabled states
  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: const DigitColors().light.primary1, width: 1.5),
    borderRadius: BorderRadius.zero,
  );

  static final OutlineInputBorder disabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: const DigitColors().light.genericDivider, width: 1.0),
    borderRadius: BorderRadius.zero,
  );

  // Default padding value
  static const double defaultPadding = 12.0;
}

class DigitButtonConstants {
  // Button padding and size constants
  static const EdgeInsets defaultDigitButtonPadding = EdgeInsets.all(spacer1);   // Default button padding
  static const EdgeInsets defaultContentPadding = EdgeInsets.symmetric(horizontal: spacer6, vertical: 0);  // Default content padding
  static const double largeDigitButtonSize = 40.0;   // Large button size
  static const double mediumDigitButtonSize = 32.0;  // Medium button size
  static const double smallDigitButtonSize = 24.0;   // Small button size
  static const double largeIconSize = 24.0;          // Large icon size
  static const double mediumIconSize = 20.0;         // Medium icon size
  static const double smallIconSize = 14.0;          // Small icon size
  static const double largeLinkIconSize = 20.0;      // Large link icon size
  static const double mediumLinkIconSize = 20.0;     // Medium link icon size
  static const double smallLinkIconSize = 14.0;      // Small link icon size
}

class DigitCheckboxConstants {
  // Checkbox size and border constants
  static const double iconSize = 16.0;               // Size of checkbox icon
  static const double containerSize = 24.0;          // Size of checkbox container
  static const double borderWidth = 2.0;             // Border width for checkboxes
  static const EdgeInsets defaultPadding = EdgeInsets.only(left: 4.0); // Default padding for checkboxes

  // Color utilities for checkbox states (checked, unchecked, intermediate)
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
  // Padding and size constants for dropdown menus
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.only(left: 10, top: 9.5, bottom: 9.5);
  static const EdgeInsetsGeometry nestedItemPadding = EdgeInsets.only(left: 10, top: 9.5, bottom: 9.5);
  static const EdgeInsetsGeometry nestedItemHeaderPadding = EdgeInsets.all(10);
  static const double defaultProfileSize = 32;       // Default profile image size
  static const double defaultImageRadius = 72;       // Default image radius for circular images
  static const double textIconSize = 20;             // Size of text icons
  static const EdgeInsets noItemAvailablePadding = EdgeInsets.symmetric(horizontal: spacer4, vertical: 10.0);
  static const Duration animationDuration = Duration(milliseconds: 200); // Animation duration for dropdowns
}

class RadioConstant {
  // Constants for radio button padding and size
  static const EdgeInsets defaultPadding = EdgeInsets.all(spacer4);   // Default radio button padding
  static const double radioWidth = spacer6;   // Radio button width
  static const double radioHeight = spacer6;  // Radio button height
}

class ToastConstant {
  // Constants for toast notifications
  static const double tabMinWidth = 480;     // Minimum width for toast on tablet
  static const double desktopMinWidth = 800; // Minimum width for toast on desktop
  Duration get toastDuration => const Duration(seconds: 5); // Default toast duration
}

class PopUpCardConstant {
  // Margins for pop-up cards
  static const double verticalMarginMobile = 64.0;    // Vertical margin for mobile pop-up
  static const double verticalMarginTab = 100.0;      // Vertical margin for tablet pop-up
  static const double verticalMarginDesktop = 74.0;   // Vertical margin for desktop pop-up

  static const double horizontalMarginMobile = 16.0;  // Horizontal margin for mobile pop-up
  static const double horizontalMarginTab = 98.0;     // Horizontal margin for tablet pop-up
  static const double horizontalMarginDesktop = 446.0; // Horizontal margin for desktop pop-up
}
