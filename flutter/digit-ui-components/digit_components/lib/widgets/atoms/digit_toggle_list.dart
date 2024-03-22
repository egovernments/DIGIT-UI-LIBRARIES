/*
 ToggleList is a row of toggle buttons that allows selecting one item at a time.

  Example usage:
 ```dart
 ToggleList(
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

class ToggleList extends StatefulWidget {
  final List<ToggleButtonModel> toggleButtons;
  final void Function(ToggleButtonModel) onChanged;
  final EdgeInsets? contentPadding;
  final int selectedIndex;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ToggleList({
    Key? key,
    required this.toggleButtons,
    required this.onChanged,
    this.contentPadding,
    required this.selectedIndex,
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
    for (ToggleButtonModel button in widget.toggleButtons) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: button.name.length > 64
              ? "${button.name.substring(0, 64)}..."
              : button.name,
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
    maxLabelWidth = _calculateMaxLabelWidth();
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.toggleButtons.map(
        (button) {
          final index = widget.toggleButtons.indexOf(button);
          return Padding(
            padding: widget.contentPadding ??
                const EdgeInsets.only(bottom: kPadding),
            child: Toggle(
              onChanged: (isSelected) {
                setState(() {
                  if (isSelected) {
                    if (selectedIndex != index) {
                      // Unselect the previously selected item
                      selectedIndex = index;
                      widget.onChanged(button);
                    }
                  } else {
                    /// Clicking on the already selected button, do nothing
                    return;
                  }
                });
              },
              label: button.name.length > 64
                  ? "${button.name.substring(0, 64)}..."
                  : button.name,
              isSelected: selectedIndex == index,
              maxLabelWidth: maxLabelWidth,
            ),
          );
        },
      ).toList(),
    );
  }
}
