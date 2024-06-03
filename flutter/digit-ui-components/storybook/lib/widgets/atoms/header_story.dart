import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_header.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> headerStories() {
  return [
    Story(
        name: 'Atom/Header/light',
        builder: (context) => CustomHeader(
          type: HeaderType.light,
          actions: [
            IconButton(
              icon:  Icon(Icons.settings, color: const DigitColors().light.textPrimary),
              onPressed: () {
                // Action for settings button
              },
            ),
            IconButton(
              icon: Icon(Icons.logout, color: const DigitColors().light.textPrimary),
              onPressed: () {
                // Action for logout button
              },
            ),
          ],
        ),
    ),
    Story(
        name: 'Atom/Header/dark',
        builder: (context) => CustomHeader(
          type: HeaderType.dark,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Action for settings button
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                // Action for logout button
              },
            ),
          ],
        ),
    ),
  ];
}
