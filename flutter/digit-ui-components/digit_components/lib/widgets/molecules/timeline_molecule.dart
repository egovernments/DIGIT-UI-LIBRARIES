import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../atoms/digit_timeline.dart';

class TimelineMolecule extends StatelessWidget {
  final List<TimelineStep> steps;
  final String viewDetailText;
  final String hideDetailText;
  final bool capitalizedLetter;

  const TimelineMolecule({
    Key? key,
    required this.steps,
    this.viewDetailText = 'View Details',
    this.hideDetailText = 'Hide Details',
    this.capitalizedLetter = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimelineStep> sortedSteps = sortSteps(List.from(steps));

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: sortedSteps.asMap().entries.map((entry) {
          int idx = entry.key;
          TimelineStep step = entry.value;
          return Column(
            children: [
              Timeline(
                currentStep: step.state,
                label: step.label,
                isLastStep: idx == sortedSteps.length - 1,
                description: step.description,
                additionalWidgets: step.additionalWidgets,
                additionalHideWidgets: step.additionalHideWidgets,
                viewDetailText: viewDetailText,
                hideDetailText: hideDetailText,
                capitalizedLetter: capitalizedLetter,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class TimelineStep {
  final String label;
  final List<String> description;
  final TimelineStepState state;
  final List<Widget>? additionalWidgets;
  final List<Widget>? additionalHideWidgets;

  TimelineStep({
    required this.label,
    required this.description,
    required this.state,
    this.additionalWidgets,
    this.additionalHideWidgets,
  });
}

List<TimelineStep> sortSteps(List<TimelineStep> steps) {
  steps.sort((a, b) {
    if (a.state == TimelineStepState.completed &&
        b.state != TimelineStepState.completed) {
      return -1;
    } else if (a.state == TimelineStepState.present &&
        b.state == TimelineStepState.future) {
      return -1;
    } else if (a.state == TimelineStepState.future &&
        b.state != TimelineStepState.future) {
      return 1;
    } else {
      return 0;
    }
  });
  return steps;
}
