// import 'package:digit_ui_components/theme/theme_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:storybook_flutter/storybook_flutter.dart';
//
// class ThemeSwitcherPlugin extends Plugin {
//   ThemeSwitcherPlugin({
//     required bool enableThemeSwitch,
//     ValueSetter<bool>? onThemeChanged,
//   }) : super(
//     icon: enableThemeSwitch ? _buildIcon : null,
//     onPressed: (context) => _onPressed(context, onThemeChanged),
//   );
//
//   static Widget _buildIcon(BuildContext context) => Icon(
//     context.watch<ThemeNotifier>().themeMode == ThemeMode.dark
//         ? Icons.dark_mode
//         : Icons.light_mode,
//   );
//
//   static void _onPressed(BuildContext context, ValueSetter<bool>? onThemeChanged) {
//     final themeNotifier = context.read<ThemeNotifier>();
//     themeNotifier.setThemeMode(
//       themeNotifier.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
//     );
//   }
//
// }
//
