import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import '../atoms/digit_button.dart';

class ButtonListTile extends StatelessWidget {
  final List<Button> buttons;
  final double spacing;
  final MainAxisAlignment alignment;
  final bool sortButtons;
  final bool isVertical;

  const ButtonListTile({
    Key? key,
    required this.buttons,
    this.spacing = 8,
    this.alignment = MainAxisAlignment.center,
    this.sortButtons = true,
    this.isVertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort buttons if the sortButtons property is true
    final sortedButtons = sortButtons ? _sortButtonsByType(buttons) : buttons;
    // Get the width of the parent container
    final double parentWidth = MediaQuery.of(context).size.width;

    if (isVertical) {
      return Column(
        mainAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.min,
        children: _addSpacing(sortedButtons.map((button) {
          return SizedBox(
            width: parentWidth,
            child: button,
          );
        }).toList(), isVertical),
      );
    } else {
      if (alignment == MainAxisAlignment.center) {
        // Create a list of buttons with adjusted widths
        final List<Widget> adjustedButtons = sortedButtons.map((button) {
          return Expanded(
            child: SizedBox(
              child: button,
            ),
          );
        }).toList();

        return Row(
          mainAxisAlignment: alignment,
          children: _addSpacing(adjustedButtons, isVertical),
        );
      } else {
        // Find the maximum total width among all buttons
        final double maxWidth = sortedButtons
            .map<double>((button) => _calculateButtonWidth(button))
            .fold<double>(0, (previousValue, element) => element > previousValue ? element : previousValue)
            .toDouble();

        // Calculate the total width required by all buttons
        final double totalWidthRequired = maxWidth * buttons.length + (buttons.length - 1) * spacing;

        // Calculate the available width for buttons
        final double availableWidth = parentWidth - (buttons.length - 1) * spacing;

        // Determine the width to be assigned to each button
        final double buttonWidth = totalWidthRequired > parentWidth ? availableWidth / buttons.length : maxWidth;

        // Create a list of buttons with adjusted widths
        final List<Widget> adjustedButtons = sortedButtons.map((button) {
          return SizedBox(
            width: buttonWidth,
            child: button,
          );
        }).toList();

        return Row(
          mainAxisAlignment: alignment,
          children: _addSpacing(adjustedButtons, isVertical),
        );
      }
    }
  }

  // Helper method to add spacing between buttons
  List<Widget> _addSpacing(List<Widget> buttons, bool isVertical) {
    final List<Widget> spacedButtons = [];
    for (int i = 0; i < buttons.length; i++) {
      spacedButtons.add(buttons[i]);
      if (i < buttons.length - 1) {
        if (isVertical) {
          spacedButtons.add(SizedBox(height: spacing));
        } else {
          spacedButtons.add(SizedBox(width: spacing));
        }
      }
    }
    return spacedButtons;
  }

  // Calculate the total width of a button including its label and icons
  double _calculateButtonWidth(Button button) {
    final double labelWidth = button.label.length.toDouble() * 16;
    final double prefixIconWidth =
    button.prefixIcon != null ? (button.size == ButtonSize.large ? 24 : button.size == ButtonSize.medium ? 20 : 14) : 0;
    final double suffixIconWidth =
    button.suffixIcon != null ? (button.size == ButtonSize.large ? 24 : button.size == ButtonSize.medium ? 20 : 14) : 0;
    final double totalWidth = labelWidth + prefixIconWidth + suffixIconWidth + button.contentPadding.horizontal;
    return totalWidth;
  }

  // Sort buttons by their type: primary, secondary, tertiary, link
  List<Button> _sortButtonsByType(List<Button> buttons) {
    final List<Button> primaryButtons = buttons.where((button) => button.type == ButtonType.primary).toList();
    final List<Button> secondaryButtons = buttons.where((button) => button.type == ButtonType.secondary).toList();
    final List<Button> tertiaryButtons = buttons.where((button) => button.type == ButtonType.tertiary).toList();
    final List<Button> linkButtons = buttons.where((button) => button.type == ButtonType.link).toList();

    if(isVertical){
      return [
        ...primaryButtons,
        ...secondaryButtons,
        ...tertiaryButtons,
        ...linkButtons,
      ];
    }

    return [
      ...linkButtons,
      ...tertiaryButtons,
      ...secondaryButtons,
      ...primaryButtons,
    ];
  }
}