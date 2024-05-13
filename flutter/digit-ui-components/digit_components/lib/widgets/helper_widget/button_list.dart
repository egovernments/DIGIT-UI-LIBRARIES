import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';

class ButtonListTile extends StatelessWidget {
  final List<Button> buttons;
  final double spacing;

  const ButtonListTile({
    Key? key,
    required this.buttons,
    this.spacing = spacer2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Find the maximum total width among all buttons
    final double maxWidth = buttons
        .map<double>((button) => _calculateButtonWidth(button))
        .fold<double>(
            0,
            (previousValue, element) =>
                element > previousValue ? element : previousValue)
        .toDouble();

    // Calculate the total width required by all buttons
    final double totalWidthRequired =
        maxWidth * buttons.length + (buttons.length - 1) * spacing;

    // Get the width of the parent container
    final double parentWidth = MediaQuery.of(context).size.width;

    // Calculate the available width for buttons
    final double availableWidth = parentWidth - (buttons.length - 1) * spacing;

    // Determine the width to be assigned to each button
    final double buttonWidth = totalWidthRequired > parentWidth
        ? availableWidth / buttons.length
        : maxWidth;

    // Create a list of buttons with adjusted widths
    final List<Widget> adjustedButtons = buttons.map((button) {
      return SizedBox(
        width: buttonWidth,
        child: button,
      );
    }).toList();

    return Wrap(
      spacing: spacing,
      children: adjustedButtons,
    );
  }

  // Calculate the total width of a button including its label and icons
  double _calculateButtonWidth(Button button) {
    final double labelWidth = button.label.length.toDouble() * spacer4;
    final double prefixIconWidth = button.prefixIcon != null
        ? button.size == ButtonSize.large
            ? spacer6
            : button.size == ButtonSize.large
                ? spacer5
                : 14
        : 0;
    final double suffixIconWidth = button.suffixIcon != null
        ? button.size == ButtonSize.large
            ? spacer6
            : button.size == ButtonSize.large
                ? spacer5
                : 14
        : 0;
    final double totalWidth = labelWidth +
        prefixIconWidth +
        suffixIconWidth +
        button.contentPadding.horizontal;
    return totalWidth;
  }

  // Calculate the width of a text based on its content and font size
  double _calculateTextWidth(String text, double fontSize) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}
