import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/atoms/digit_timeline.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> timeLineStories() {
  return [
    Story(
      name: 'Timeline/Completed',
      builder: (context) => const Timeline(
        currentStep: TimelineStepState.completed,
        label: 'Completed',
        description: ['18 / 02 / 2023'],
      ),
    ),
    Story(
      name: 'Timeline/Current',
      builder: (context) => const Timeline(
        currentStep: TimelineStepState.present,
        label: 'Completed',
        description: ['18 / 02 / 2023'],
      ),
    ),
    Story(
      name: 'Timeline/Future',
      builder: (context) => const Timeline(
        currentStep: TimelineStepState.future,
        label: 'Completed',
        description: ['18 / 02 / 2023'],
      ),
    ),
  ];
}
