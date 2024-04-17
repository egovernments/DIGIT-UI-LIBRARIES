import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppView {
  /// Determine the current view based on the screen aspect ratio
  static bool isMobileView(Size screenSize) {
    double aspectRatio = screenSize.aspectRatio;
    return aspectRatio <= 9 / 16; /// Landscape or square aspect ratio
  }

  static bool isTabletView(Size screenSize) {
    double aspectRatio = screenSize.aspectRatio;
    return aspectRatio > 9 / 16 && aspectRatio <= 3 / 4; /// Portrait aspect ratio
  }

  static bool isDesktopView(Size screenSize) {
    double aspectRatio = screenSize.aspectRatio;
    return aspectRatio > 3 / 4; /// Landscape or square aspect ratio
  }
}
