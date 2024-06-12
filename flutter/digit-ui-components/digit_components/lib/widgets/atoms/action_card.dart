/// A widget that displays a dialog with a list of action buttons.
/// The dialog can be customized with width, height, and spacing between buttons.

///Example usage:
///``` ActionCard(
///   width: 300,
///   height: 400,
///   spacing: 16,
///   actions: [
///     Button(
///       label: 'Action 1',
///       onPressed: () {
///         // Handle Action 1
///       },
///     ),
///     Button(
///       label: 'Action 2',
///       onPressed: () {
///         // Handle Action 2
///       },
///     ),
///   ],
/// )```

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../theme/action_card_theme.dart';
import '../../theme/digit_extended_theme.dart';
import '../helper_widget/button_list.dart';

class ActionCard extends StatelessWidget {

  final DigitActionCardTheme? extendedTheme;

  /// A list of action buttons to be displayed in the dialog.
  final List<Button> actions;

  const ActionCard({
    super.key,
    this.extendedTheme,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final actionTheme = extendedTheme ?? theme.extension<DigitActionCardTheme>() ?? DigitActionCardTheme.defaultTheme(context);

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          width: actionTheme.width,
          height: actionTheme.height,
          padding: actionTheme.padding,
          decoration: actionTheme.decoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// A scrollable container to accommodate the list of action buttons
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ButtonListTile(
                        /// A widget that displays the list of action buttons
                        buttons: actions,
                        isVertical: true,
                        spacing: actionTheme.spacing ?? 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
