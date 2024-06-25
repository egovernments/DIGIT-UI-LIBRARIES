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
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../theme/ComponentTheme/action_card_theme.dart';
import '../helper_widget/button_list.dart';

class ActionCard extends StatelessWidget {
  final DigitActionCardTheme? actionCardTheme;

  /// A list of action buttons to be displayed in the dialog.
  final List<Button> actions;

  const ActionCard({
    super.key,
    this.actionCardTheme,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actionTheme = actionCardTheme ??
        theme.extension<DigitActionCardTheme>() ??
        DigitActionCardTheme.defaultTheme(context);

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          width: actionTheme.width,
          height: actionTheme.height,
          decoration: actionTheme.decoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// A scrollable container to accommodate the list of action buttons
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: actionTheme.padding,
                    child: Column(
                      children: [
                        ButtonListTile(
                          /// A widget that displays the list of action buttons
                          buttons: actions,
                          isVertical: true,
                          spacing:
                              actionTheme.spacing ?? theme.spacerTheme.spacer2 ??0,
                        ),
                      ],
                    ),
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
