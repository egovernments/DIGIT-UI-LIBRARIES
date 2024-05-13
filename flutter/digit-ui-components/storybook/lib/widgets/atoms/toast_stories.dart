import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_toast.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> ToastStories() {
  return [
    Story(
      name: 'Atom/Animated Toast/Success',
      builder: (context) => ElevatedButton(
        onPressed: () {
          Toast.showToast(
            context,
            message: 'This is a success toast!',
            type: ToastType.success,
          );
        },
        child: const Text("Show Toast"),
      ),
    ),
    Story(
      name: 'Atom/Animated Toast/Error',
      builder: (context) => ElevatedButton(
        onPressed: () {
          Toast.showToast(
            context,
            message: 'This is a Error toast!',
            type: ToastType.error,
          );
        },
        child: const Text("Show Toast"),
      ),
    ),
    Story(
      name: 'Atom/Animated Toast/Warning',
      builder: (context) => ElevatedButton(
        onPressed: () {
          Toast.showToast(
            context,
            message: 'This is a Warning toast!',
            type: ToastType.warning,
          );
        },
        child: const Text("Show Toast"),
      ),
    ),
  ];
}