
import 'package:digit_ui_components/widgets/atoms/selection_card.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> selectionCardStories() {
  return [
    Story(
      name: 'Atom/Selection Box/Default (Multiple Selection)',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: ['Option 1', 'Option 2', 'Option 3'],
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Options: $selectedOptions');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Box/Single Selection',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: ['Option A', 'Option B', 'Option C'],
        allowMultipleSelection: false,
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Option: $selectedOptions');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Box/With Initial Selection',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: ['Apple', 'Banana', 'Cherry'],
        initialSelection: ['Apple'],
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Options: $selectedOptions');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Box/With Error Message',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: ['Red', 'Blue', 'Green'],
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Options: $selectedOptions');
        },
        errorMessage: 'Please select at least one option',
      ),
    ),
    Story(
      name: 'Atom/Selection Box/With Custom Width',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: ['Small', 'Medium', 'Large'],
        width: 200.0,
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Options: $selectedOptions');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Box/Equal Width Options',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: const ['Short', 'Longer Option', 'Mid-Length'],
        equalWidthOptions: true,
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Options: $selectedOptions');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Box/With Icon',
      builder: (context) => SelectionCard<String>(
        valueMapper: (item) => item,
        options: const ['Option 1', 'Option 2', 'Option 3'],
        onSelectionChanged: (selectedOptions) {
          debugPrint('Selected Options: $selectedOptions');
        },
        prefixIconBuilder: (value) {
          if (value == 'Option 1') {
            return Icons.star;
          } else if (value == 'Option 2') {
            return Icons.favorite;
          }
          return Icons.thumb_down;
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Box/With Icon After Selection',
      builder: (context) {

        List<String> selectedOptions = [];
        // Define a stateful widget for managing the selected option
        return StatefulBuilder(
          builder: (context, setState) {

            return SelectionCard<String>(
              valueMapper: (item) => item,
              options: const ['Option 1', 'Option 2', 'Option 3'],
              //initialSelection: selectedOptions,
              onSelectionChanged: (newSelectedOptions) {
                setState(() {
                  // Replace the list with the newly selected options
                  selectedOptions = List.from(newSelectedOptions);
                });
                // Optional: print the selected options for debugging
                print('Selected Options: $selectedOptions');
              },
              prefixIconBuilder: (value) {
                // Show icons only if the option is selected
                if (selectedOptions.contains(value)) {
                  if (value == 'Option 1') {
                    return Icons.star;
                  } else if (value == 'Option 2') {
                    return Icons.favorite;
                  }
                  return Icons.thumb_down;
                }
                return null; // Return null if no icon should be shown
              },
            );
          },
        );
      },
    )

  ];
}
