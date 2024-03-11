library digit_flutter_components;

export 'theme/theme.dart';
export 'widgets/widgets.dart';

class DigitUi {
  static const DigitUi _instance = DigitUi._internal();
  static DigitUi get instance => _instance;

  const DigitUi._internal();

  Future<void> initThemeComponents() async {
    /// can be used to add custom theme components
  }
}
