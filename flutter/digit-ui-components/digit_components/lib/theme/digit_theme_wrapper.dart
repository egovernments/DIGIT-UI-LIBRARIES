import 'package:digit_ui_components/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitThemeWrapper extends StatelessWidget {
  final Widget? child;  // Made optional
  final ThemeMode initialThemeMode;
  final Widget Function(BuildContext, ThemeData, ThemeMode)? materialAppBuilder;

  const DigitThemeWrapper({
    Key? key,
    this.child,  // No longer required
    this.initialThemeMode = ThemeMode.system,
    this.materialAppBuilder,
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
          final themeData = themeNotifier.loadThemeData(context);

          if (materialAppBuilder != null) {
            return materialAppBuilder!(context, themeData, themeNotifier.themeMode);
          }

          // If materialAppBuilder is not provided, ensure child is not null
          assert(child != null, 'Either child or materialAppBuilder must be provided.');

          return MaterialApp(
            themeMode: themeNotifier.themeMode,
            theme: themeData,
            home: child,
          );
        },
      ),
    );
  }
}
