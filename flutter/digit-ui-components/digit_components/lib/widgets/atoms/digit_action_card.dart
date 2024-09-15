/// A widget that displays a dialog with a list of action DigitButtons.
/// The dialog can be customized with width, height, and spacing between DigitButtons.

///Example usage:
///``` DigitActionCard(
///   width: 300,
///   height: 400,
///   spacing: 16,
///   actions: [
///     DigitButton(
///       label: 'Action 1',
///       onPressed: () {
///         // Handle Action 1
///       },
///     ),
///     DigitButton(
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

class DigitActionCard extends StatelessWidget {
  final DigitDigitActionCardTheme? digitActionCardTheme;

  /// A list of action DigitButtons to be displayed in the dialog.
  final List<DigitButton> actions;

  /// Callback when the user taps outside the container.
  final VoidCallback? onOutsideTap;

  const DigitActionCard({
    super.key,
    this.digitActionCardTheme,
    required this.actions,
    this.onOutsideTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actionTheme = digitActionCardTheme ??
        theme.extension<DigitDigitActionCardTheme>() ??
        DigitDigitActionCardTheme.defaultTheme(context);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return GestureDetector(
      onTap: onOutsideTap,
      child: Dialog.fullscreen(
        backgroundColor: const DigitColors().transparent,
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: isMobile ? MediaQuery.of(context).size.height*.80: isTab ?MediaQuery.of(context).size.height*.82 : MediaQuery.of(context).size.height*.85,
            ),
            margin: actionTheme.width == null ? actionTheme.margin : EdgeInsets.zero,
            width: actionTheme.width,
            height: actionTheme.height,
            decoration: actionTheme.decoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// A scrollable container to accommodate the list of action DigitButtons
                Flexible(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: actionTheme.padding,
                      child: Column(
                        children: [
                          DigitButtonListTile(
                            /// A widget that displays the list of action DigitButtons
                            buttons: actions,
                            isVertical: true,
                            spacing:
                            actionTheme.spacing ?? theme.spacerTheme.spacer6,
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
      ),
    );
  }
}