import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../atoms/timeline.dart';

class TimelineMolecule extends StatefulWidget {
  final List<TimelineStep> steps;
  final String viewDetailText;
  final String hideDetailText;
  final bool capitalizedLetter;
  final int initialStepCount;

  const TimelineMolecule({
    Key? key,
    required this.steps,
    this.viewDetailText = 'View Details',
    this.hideDetailText = 'Hide Details',
    this.capitalizedLetter = true,
    this.initialStepCount = 3, // Number of steps to show initially
  }) : super(key: key);

  @override
  _TimelineMoleculeState createState() => _TimelineMoleculeState();
}

class _TimelineMoleculeState extends State<TimelineMolecule> {
  bool showMoreFuture = false;
  bool showMorePast = false;

  @override
  Widget build(BuildContext context) {
    List<TimelineStep> sortedSteps = sortSteps(List.from(widget.steps));

    // Determine the indices for the last past step, the present step, and the first future step
    int firstFutureIndex = sortedSteps.indexWhere((step) => step.state == TimelineStepState.future);
    int presentIndex = sortedSteps.indexWhere((step) => step.state == TimelineStepState.present);
    int lastPastIndex = presentIndex - 1;

    // Steps to show by default: last past step, present step, and first future step
    List<TimelineStep> stepsToShow = [];
    if (lastPastIndex >= 0) stepsToShow.add(sortedSteps[lastPastIndex]);
    if (presentIndex >= 0) stepsToShow.add(sortedSteps[presentIndex]);
    if (firstFutureIndex >= 0) stepsToShow.add(sortedSteps[firstFutureIndex]);

    // Additional steps to show if expanded
    List<TimelineStep> futureSteps = sortedSteps.sublist(firstFutureIndex + 1);
    List<TimelineStep> pastSteps = sortedSteps.sublist(0, lastPastIndex);

    if (showMoreFuture) {
      stepsToShow.addAll(futureSteps);
    }
    if (showMorePast) {
      stepsToShow.insertAll(0, pastSteps);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (sortedSteps.length > widget.initialStepCount)
            Button(
              label: showMorePast ? 'View Less Past' : 'View More Past',
              type: ButtonType.tertiary,
              size: ButtonSize.medium,
              suffixIcon: showMorePast ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              onPressed: () {
                setState(() {
                  showMorePast = !showMorePast;
                });
              },
            ),
          Column(
            children: stepsToShow.asMap().entries.map((entry) {
              int idx = entry.key;
              TimelineStep step = entry.value;
              return Column(
                children: [
                  DigitTimeline(
                    currentStep: step.state,
                    label: step.label,
                    isLastStep: idx == stepsToShow.length - 1,
                    isFirstFuture: idx == firstFutureIndex,
                    description: step.description,
                    additionalWidgets: step.additionalWidgets,
                    additionalHideWidgets: step.additionalHideWidgets,
                    viewDetailText: widget.viewDetailText,
                    hideDetailText: widget.hideDetailText,
                    capitalizedLetter: widget.capitalizedLetter,
                  ),
                ],
              );
            }).toList(),
          ),
          if (sortedSteps.length > widget.initialStepCount)
            Button(
              label: showMoreFuture ? 'View Less Future' : 'View More Future',
              type: ButtonType.tertiary,
              size: ButtonSize.medium,
              suffixIcon: showMoreFuture ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              onPressed: () {
                setState(() {
                  showMoreFuture = !showMoreFuture;
                });
              },
            ),
        ],
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
  // Group steps by state
  List<TimelineStep> futureSteps = [];
  List<TimelineStep> presentSteps = [];
  List<TimelineStep> completedSteps = [];

  for (var step in steps) {
    switch (step.state) {
      case TimelineStepState.future:
        futureSteps.add(step);
        break;
      case TimelineStepState.present:
        presentSteps.add(step);
        break;
      case TimelineStepState.completed:
        completedSteps.add(step);
        break;
    }
  }

  // Reverse the order within each group
  futureSteps = futureSteps.reversed.toList();
  presentSteps = presentSteps.reversed.toList();
  completedSteps = completedSteps.reversed.toList();

  // Concatenate the groups
  return [


    ...futureSteps,
    ...presentSteps,
    ...completedSteps,
  ];
}
