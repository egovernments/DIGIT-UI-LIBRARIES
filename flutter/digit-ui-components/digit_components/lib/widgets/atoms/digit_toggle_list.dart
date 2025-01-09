/// ToggleList is a row of toggle DigitButtons that allows selecting one item at a time.

///  Example usage:
/// ```dart
/// ToggleList(
///  toggleDigitButtons: [
///    ToggleDigitButtonModel(name: 'Option 1', onSelected: () => print('Option 1 selected')),
///    ToggleDigitButtonModel(name: 'Option 2', onSelected: () => print('Option 2 selected')),
///    // Add more ToggleDigitButtonModel instances as needed
///  ],
///  onChanged: (selectedValues) {
/// Handle the selected values if needed
///    print('Selected values: $selectedValues');
///  },
///  contentPadding: EdgeInsets.symmetric(horizontal: 16), // Optional content padding
///)

import 'dart:math';

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../../models/toggleButtonModel.dart';

class ToggleList extends StatefulWidget {
  final List<ToggleButtonModel> toggleDigitButtons;
  final void Function(ToggleButtonModel) onChanged;
  final EdgeInsets? contentPadding;
  final int selectedIndex;
  final double? toggleWidth;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ToggleList({
    Key? key,
    required this.toggleDigitButtons,
    required this.onChanged,
    this.contentPadding,
    required this.selectedIndex,
    this.toggleWidth,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  _ToggleListState createState() => _ToggleListState();
}

class _ToggleListState extends State<ToggleList> {
  int? selectedIndex;
  late double maxLabelWidth;

  @override
  void initState() {
    super.initState();

    /// select the index of default toggle
    selectedIndex = widget.selectedIndex;
  }

  double _calculateMaxLabelWidth() {
    double maxLabelWidth = (MediaQuery.of(context).size.width) / 3 - 46;
    double maxLabel = 0;
    for (ToggleButtonModel DigitButton in widget.toggleDigitButtons) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: DigitButton.name,
          style: const TextStyle(),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      double labelWidth = textPainter.width;
      maxLabel = max(maxLabel, labelWidth);
    }
    return min(maxLabelWidth, maxLabel);
  }

  @override
  Widget build(BuildContext context) {
    maxLabelWidth = _calculateMaxLabelWidth() + spacer12 +spacer1;
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.toggleDigitButtons.map(
            (DigitButton) {
          final index = widget.toggleDigitButtons.indexOf(DigitButton);
          return Padding(
            padding:
            widget.contentPadding ?? const EdgeInsets.only(bottom: spacer2),
            child: Toggle(
              onChanged: (isSelected) {
                setState(() {
                  if (isSelected) {
                    if (selectedIndex != index) {
                      /// Unselect the previously selected item
                      selectedIndex = index;
                      widget.onChanged(DigitButton);
                    }
                  } else {
                    /// Clicking on the already selected DigitButton, do nothing
                    return;
                  }
                });
              },
              label: DigitButton.name,
              isSelected: selectedIndex == index,
              maxLabelWidth: widget.toggleWidth ?? maxLabelWidth,
            ),
          );
        },
      ).toList(),
    );
  }
}