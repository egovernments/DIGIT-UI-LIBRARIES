import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/infinite_date_scroll.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

List<Story> infiniteDateScrollInputStories() {
  return [
    Story(
      name: 'Basic',
      builder: (context) {
        final theme = Theme.of(context);
        final textTheme = theme.digitTextTheme(context);
        final TextEditingController controller = TextEditingController();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: InfiniteDateScrollInput(
            controller: controller,
            innerLabel: 'Select a date',
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year, 1, 1),
            lastDate: DateTime(DateTime.now().year, 12, 31),
            editable: true,
            onChange: (value) {
              debugPrint("Selected date: $value");
            },
            disableScroll: true,
          ),
        );
      },
    ),
  ];
}
