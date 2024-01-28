/*
 DigitToggleList is a row of toggle buttons that allows selecting one item at a time.

  Example usage:
 ```dart
 DigitToggleList(
  toggleButtons: [
    ToggleButtonModel(name: 'Option 1', onSelected: () => print('Option 1 selected')),
    ToggleButtonModel(name: 'Option 2', onSelected: () => print('Option 2 selected')),
    // Add more ToggleButtonModel instances as needed
  ],
  onChanged: (selectedValues) {
    // Handle the selected values if needed
    print('Selected values: $selectedValues');
  },
  contentPadding: EdgeInsets.symmetric(horizontal: 16), // Optional content padding
)
 ....*/

import 'dart:math';

import 'package:flutter/material.dart';
import '../../models/toggleButtonModel.dart';
import '../../theme/digit_theme.dart';
import 'digit_toggle.dart';

class DigitToggleList extends StatefulWidget {
  final List<ToggleButtonModel> toggleButtons;
  final void Function(List<bool> selectedValues) onChanged;
  final EdgeInsets? contentPadding;
  final int selectedIndex;

  const DigitToggleList({
    Key? key,
    required this.toggleButtons,
    required this.onChanged,
    this.contentPadding,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _DigitToggleListState createState() => _DigitToggleListState();
}

class _DigitToggleListState extends State<DigitToggleList> {
  int? selectedIndex;
  late double maxLabelWidth;

  @override
  void initState() {
    super.initState();
    /// select the index of default toggle
    selectedIndex = widget.selectedIndex;
    /// call the onSelect for default selected toggle
    widget.toggleButtons[selectedIndex!].onSelected?.call(true);
    maxLabelWidth = _calculateMaxLabelWidth();
  }

  double _calculateMaxLabelWidth() {
    double maxLabelWidth = 0;
    for (ToggleButtonModel button in widget.toggleButtons) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: button.name.length > 64 ? "${button.name.substring(0, 64)}..." : button.name,
          style: const TextStyle(),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      double labelWidth = textPainter.width;
      maxLabelWidth = max(maxLabelWidth, labelWidth);
    }
    return maxLabelWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.toggleButtons.map(
            (button) {
          final index = widget.toggleButtons.indexOf(button);
          return Padding(
            padding: widget.contentPadding ?? const EdgeInsets.only(bottom: kPadding),
            child: DigitToggle(
              onChanged: (isSelected) {
                setState(() {
                  if (isSelected) {
                    if (selectedIndex != index) {
                      // Unselect the previously selected item
                      widget.toggleButtons[selectedIndex!].onSelected?.call(false);
                      selectedIndex = index;
                    }
                  } else {
                    // Clicking on the already selected button, do nothing
                    return;
                  }
                });

                // /// Check if the button is selected and has a callback
                if (selectedIndex==index && button.onSelected != null) {
                  button.onSelected!(true);
                }
              },
              label: button.name.length > 64 ? "${button.name.substring(0, 64)}..." : button.name,
              isSelected: selectedIndex == index,
              maxLabelWidth: maxLabelWidth,
            ),
          );
        },
      ).toList(),
    );
  }
}

