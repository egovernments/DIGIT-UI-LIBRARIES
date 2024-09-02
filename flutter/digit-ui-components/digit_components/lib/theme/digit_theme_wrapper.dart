import 'package:digit_ui_components/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitThemeWrapper extends StatelessWidget {
  final Widget child;
  final ThemeMode initialThemeMode;

  const DigitThemeWrapper({
    Key? key,
    required this.child,
    this.initialThemeMode = ThemeMode.system, // Default to system theme mode if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(initialThemeMode),
        ),
        FutureProvider<ThemeData>(
          create: (context) {
            final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
            return Future.microtask(() => themeNotifier.loadThemeData(context));
          },
          initialData: ThemeData.light(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeNotifier = Provider.of<ThemeNotifier>(context);
          return MaterialApp(
            themeMode: themeNotifier.themeMode,
            theme: themeNotifier.loadThemeData(context),
            home: child,
          );
        },
      ),
    );
  }
}
