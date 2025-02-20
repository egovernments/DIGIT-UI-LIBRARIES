import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import '../atoms/digit_button.dart';

class DigitButtonListTile extends StatelessWidget {
  final List<DigitButton> buttons;
  final double spacing;
  final MainAxisAlignment alignment;
  final bool sortDigitButtons;
  final bool isVertical;

  const DigitButtonListTile({
    Key? key,
    required this.buttons,
    this.spacing = 8,
    this.alignment = MainAxisAlignment.center,
    this.sortDigitButtons = true,
    this.isVertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort DigitButtons if the sortDigitButtons property is true
    final sortedDigitButtons = sortDigitButtons ? _sortDigitButtonsByType(buttons) : buttons;
    // Get the width of the parent container
    final double parentWidth = MediaQuery.of(context).size.width;

    if (isVertical) {
      return Column(
        mainAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.min,
        children: _addSpacing(sortedDigitButtons.map((buttons) {
          return SizedBox(
            width: parentWidth,
            child: buttons,
          );
        }).toList(), isVertical),
      );
    } else {
      if (alignment == MainAxisAlignment.center) {
        // Create a list of DigitButtons with adjusted widths
        final List<Widget> adjustedDigitButtons = sortedDigitButtons.map((buttons) {
          return Expanded(
            child: SizedBox(
              child: buttons,
            ),
          );
        }).toList();

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment,
          children: _addSpacing(adjustedDigitButtons, isVertical),
        );
      } else {
        // Find the maximum total width among all DigitButtons
        final double maxWidth = sortedDigitButtons
            .map<double>((buttons) => _calculateDigitButtonWidth(buttons))
            .fold<double>(0, (previousValue, element) => element > previousValue ? element : previousValue)
            .toDouble();

        // Calculate the total width required by all DigitButtons
        final double totalWidthRequired = maxWidth * buttons.length + (buttons.length - 1) * spacing;

        // Calculate the available width for DigitButtons
        final double availableWidth = parentWidth - (buttons.length - 1) * spacing;

        // Determine the width to be assigned to each DigitButton
        final double DigitButtonWidth = totalWidthRequired > parentWidth ? availableWidth / buttons.length : maxWidth;

        // Create a list of DigitButtons with adjusted widths
        final List<Widget> adjustedDigitButtons = sortedDigitButtons.map((buttons) {
          return SizedBox(
            width: DigitButtonWidth,
            child: buttons,
          );
        }).toList();

        return Row(
          mainAxisAlignment: alignment,
          children: _addSpacing(adjustedDigitButtons, isVertical),
        );
      }
    }
  }

  // Helper method to add spacing between DigitButtons
  List<Widget> _addSpacing(List<Widget> buttons, bool isVertical) {
    final List<Widget> spacedDigitButtons = [];
    for (int i = 0; i < buttons.length; i++) {
      spacedDigitButtons.add(buttons[i]);
      if (i < buttons.length - 1) {
        if (isVertical) {
          spacedDigitButtons.add(SizedBox(height: spacing));
        } else {
          spacedDigitButtons.add(SizedBox(width: spacing));
        }
      }
    }
    return spacedDigitButtons;
  }

  // Calculate the total width of a DigitButton including its label and icons
  double _calculateDigitButtonWidth(DigitButton buttons) {
    final double labelWidth = buttons.label.length.toDouble() * 16;
    final double prefixIconWidth =
    buttons.prefixIcon != null ? (buttons.size == DigitButtonSize.large ? 24 : buttons.size == DigitButtonSize.medium ? 20 : 14) : 0;
    final double suffixIconWidth =
    buttons.suffixIcon != null ? (buttons.size == DigitButtonSize.large ? 24 : buttons.size == DigitButtonSize.medium ? 20 : 14) : 0;
    final double totalWidth = labelWidth + prefixIconWidth + suffixIconWidth +48;

    return totalWidth;
  }

  // Sort DigitButtons by their type: primary, secondary, tertiary, link
  List<DigitButton> _sortDigitButtonsByType(List<DigitButton> buttons) {
    final List<DigitButton> primaryDigitButtons = buttons.where((buttons) => buttons.type == DigitButtonType.primary).toList();
    final List<DigitButton> secondaryDigitButtons = buttons.where((buttons) => buttons.type == DigitButtonType.secondary).toList();
    final List<DigitButton> tertiaryDigitButtons = buttons.where((buttons) => buttons.type == DigitButtonType.tertiary).toList();
    final List<DigitButton> linkDigitButtons = buttons.where((buttons) => buttons.type == DigitButtonType.link).toList();

    if(isVertical){
      return [
        ...primaryDigitButtons,
        ...secondaryDigitButtons,
        ...tertiaryDigitButtons,
        ...linkDigitButtons,
      ];
    }

    return [
      ...linkDigitButtons,
      ...tertiaryDigitButtons,
      ...secondaryDigitButtons,
      ...primaryDigitButtons,
    ];
  }
}