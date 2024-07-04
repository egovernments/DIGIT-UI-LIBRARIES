library digit_ui_components;

export 'theme/theme.dart';
export 'widgets/widgets.dart';
export 'enum/app_enums.dart';
export 'models/models.dart';
export 'constants/constant.dart';

class DigitUi {
  static const DigitUi _instance = DigitUi._internal();
  static DigitUi get instance => _instance;

  const DigitUi._internal();

  Future<void> initThemeComponents() async {
    /// can be used to add custom theme components
  }
}
