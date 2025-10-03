import 'package:digit_ui_components/widgets/atoms/selection_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> selectionCardStories() {
  return [
    Story(
      name: 'Atom/Selection Tags/Documentation',
      builder: (context) {
        return IframeWidget(
          url:
              'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
        name: 'Atom/Selection Tags/Single Select',
        builder: (context) {
          final bool withParentContainer = context.knobs
              .boolean(label: 'With Parent Container', initial: false);

          // Create an option knob for icons
          final iconState = context.knobs.nullable.options<String>(
            label: 'Icon',
            initial: 'icon', // Ensure an initial value is set
            options: [
              Option(label: 'Icon', value: 'icon'),
              Option(
                  label: 'Icon After Selection', value: 'iconAfterSelection'),
            ],
            enabled: false,
          );

          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          List<String> selectedOptions = [];

          return Align(
            alignment: Alignment.centerLeft,
            child: StatefulBuilder(builder: (context, setState) {
              return SelectionCard<String>(
                showParentContainer: withParentContainer,
                valueMapper: (item) => item,
                options: [
                  'Start',
                  'Middle',
                  'End',
                ],
                initialSelection: ['Start'],
                readOnly: true,
                onSelectionChanged: (newSelectedOptions) {
                  setState(() {
                    selectedOptions = List.from(newSelectedOptions);
                  });
                },
                equalWidthOptions: context.knobs
                    .boolean(label: 'Equal Width Options', initial: false),
                prefixIconBuilder: iconState != null
                    ? (value) {
                        if (iconState == 'iconAfterSelection') {
                          // Show icons only after selection
                          if (selectedOptions.contains(value)) {
                            if (value == 'Start') {
                              return Icons.star;
                            } else if (value == 'Middle') {
                              return Icons.favorite;
                            }
                            return Icons.thumb_down;
                          }
                          return null; // No icon if not selected
                        } else {
                          // Always show icons for each option
                          if (value == 'Start') {
                            return Icons.star;
                          } else if (value == 'Middle') {
                            return Icons.favorite;
                          }
                          return Icons.thumb_down;
                        }
                      }
                    : null,
                errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
              );
            }),
          );
        }),
    Story(
        name: 'Atom/Selection Tags/Multiselect',
        builder: (context) {
          final bool withParentContainer = context.knobs
              .boolean(label: 'With Parent Container', initial: false);

          // Create an option knob for icons
          final iconState = context.knobs.nullable.options<String>(
            label: 'Icon',
            initial: 'icon', // Ensure an initial value is set
            options: [
              Option(label: 'Icon', value: 'icon'),
              Option(
                  label: 'Icon After Selection', value: 'iconAfterSelection'),
            ],
            enabled: false,
          );
          final errorMessage = context.knobs.text(
            label: 'Error Message',
            initial: '',
          );

          List<String> selectedOptions = [];

          return Align(
            alignment: Alignment.centerLeft,
            child: StatefulBuilder(builder: (context, setState) {
              return SelectionCard<String>(
                showParentContainer: withParentContainer,
                valueMapper: (item) => item,
                options: [
                  'Start',
                  'Middle',
                  'End',
                ],
                initialSelection: [],
                equalWidthOptions: context.knobs
                    .boolean(label: 'Equal Width Options', initial: false),
                onSelectionChanged: (newSelectedOptions) {
                  setState(() {
                    selectedOptions = List.from(newSelectedOptions);
                  });
                },
                allowMultipleSelection: true,
                prefixIconBuilder: iconState != null
                    ? (value) {
                        if (iconState == 'iconAfterSelection') {
                          // Show icons only after selection
                          if (selectedOptions.contains(value)) {
                            if (value == 'Start') {
                              return Icons.star;
                            } else if (value == 'Middle') {
                              return Icons.favorite;
                            }
                            return Icons.thumb_down;
                          }
                          return null; // No icon if not selected
                        } else {
                          // Always show icons for each option
                          if (value == 'Start') {
                            return Icons.star;
                          } else if (value == 'Middle') {
                            return Icons.favorite;
                          }
                          return Icons.thumb_down;
                        }
                      }
                    : null,
                errorMessage: errorMessage.isNotEmpty ? errorMessage : null,
              );
            }),
          );
        }),
  ];
}
