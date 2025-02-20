import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/localized.dart';
import 'package:flutter/material.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../atoms/timeline.dart';

class TimelineMolecule extends LocalizedStatefulWidget {
  final List<TimelineStep> steps;
  final String? viewDetailText;
  final String? hideDetailText;
  final bool capitalizedLetter;
  final int initialStepCount;
  final bool showAllSteps; // New prop to show all steps initially

  const TimelineMolecule({
    Key? key,
    required this.steps,
    this.viewDetailText,
    this.hideDetailText,
    this.capitalizedLetter = true,
    this.initialStepCount = 3, // Number of steps to show initially
    this.showAllSteps = false,
  }) : super(key: key);

  @override
  _TimelineMoleculeState createState() => _TimelineMoleculeState();
}

class _TimelineMoleculeState extends LocalizedState<TimelineMolecule> {
  bool showMoreFuture = false;
  bool showMorePast = false;

  @override
  Widget build(BuildContext context) {
    List<TimelineStep> sortedSteps = sortSteps(List.from(widget.steps));

    List<TimelineStep> stepsToShow = [];
    int firstFutureIndex = 0;

    if (widget.showAllSteps || (showMoreFuture && showMorePast)) {
      // Show all steps, including future steps in reverse order
      List<TimelineStep> futureSteps = sortedSteps
          .where((step) => step.state == TimelineStepState.future)
          .toList();
      stepsToShow.addAll(futureSteps.reversed);
      stepsToShow.addAll(
          sortedSteps.where((step) => step.state == TimelineStepState.present));
      stepsToShow.addAll(sortedSteps
          .where((step) => step.state == TimelineStepState.completed).toList().reversed);

      firstFutureIndex = sortedSteps
          .lastIndexWhere((step) => step.state == TimelineStepState.future);
    } else {
      // Determine the indices for the last past step, the present step, and the first future step
      int presentIndex = sortedSteps
          .indexWhere((step) => step.state == TimelineStepState.present);
      int firstFutureIndex = sortedSteps
          .indexWhere((step) => step.state == TimelineStepState.future);
      int lastPastIndex = sortedSteps
          .lastIndexWhere((step) => step.state == TimelineStepState.completed);

      if (showMoreFuture) {
        // Rebuild stepsToShow to include all future steps
        firstFutureIndex = stepsToShow
            .indexWhere((step) => step.state == TimelineStepState.future);
        stepsToShow = [
          ...sortedSteps
              .where((step) => step.state == TimelineStepState.future)
              .toList()
              .reversed,
          if (presentIndex >= 0) sortedSteps[presentIndex],
          if (lastPastIndex >= 0) sortedSteps[lastPastIndex],
          if (showMorePast)
            ...sortedSteps
                .where((step) => step.state == TimelineStepState.completed)
                .toList()
                .reversed,
        ];
        firstFutureIndex = stepsToShow
            .indexWhere((step) => step.state == TimelineStepState.future);
      } else if (showMorePast) {
        // Rebuild stepsToShow to include all past steps
        stepsToShow = [
          if (showMoreFuture)
            ...sortedSteps
                .where((step) => step.state == TimelineStepState.future)
                .toList()
                .reversed,
          if (firstFutureIndex >= 0) sortedSteps[firstFutureIndex],
          if (presentIndex >= 0) sortedSteps[presentIndex],
          ...sortedSteps
              .where((step) => step.state == TimelineStepState.completed)
              .toList()
              .reversed,
        ];
        firstFutureIndex = stepsToShow
            .indexWhere((step) => step.state == TimelineStepState.future);
      } else {
        // Show default steps: last past step, present step, and first future step
        if (firstFutureIndex >= 0)
          stepsToShow.add(sortedSteps[firstFutureIndex]);
        if (presentIndex >= 0) stepsToShow.add(sortedSteps[presentIndex]);
        if (lastPastIndex >= 0) stepsToShow.add(sortedSteps[lastPastIndex]);
      }
    }

    firstFutureIndex = stepsToShow
        .lastIndexWhere((step) => step.state == TimelineStepState.future);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.showAllSteps &&
              sortedSteps
                      .where((step) => step.state == TimelineStepState.future)
                      .length >
                  1)
            DigitButton(
              label: showMoreFuture
                  ? localizations.translate(i18.common.viewLessFuture)
                  : localizations.translate(i18.common.viewMoreFuture),
              type: DigitButtonType.link,
              size: DigitButtonSize.medium,
              suffixIcon:
                  showMoreFuture ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              onPressed: () {
                setState(() {
                  showMoreFuture = !showMoreFuture;
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
                    viewDetailText: widget.viewDetailText ??
                        localizations.translate(
                          i18.common.viewDetails,
                        ),
                    hideDetailText: widget.hideDetailText ??
                        localizations.translate(
                          i18.common.hideDetails,
                        ),
                    capitalizedLetter: widget.capitalizedLetter,
                  ),
                ],
              );
            }).toList(),
          ),
          if (!widget.showAllSteps &&
              sortedSteps
                      .where(
                          (step) => step.state == TimelineStepState.completed)
                      .length >
                  1)
            DigitButton(
              label: showMorePast
                  ? localizations.translate(
                      i18.common.viewLessPast,
                    )
                  : localizations.translate(
                      i18.common.viewMorePast,
                    ),
              type: DigitButtonType.link,
              size: DigitButtonSize.medium,
              suffixIcon:
                  showMorePast ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              onPressed: () {
                setState(() {
                  showMorePast = !showMorePast;
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
  // Create lists for each state, but keep failure steps in their original positions
  List<TimelineStep> futureSteps = [];
  List<TimelineStep> presentSteps = [];
  List<TimelineStep> completedSteps = [];
  List<TimelineStep> sortedSteps = [];

  // Iterate through the original list of steps
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
      case TimelineStepState.failed:
        // Keep failure steps in their original position
        sortedSteps.add(step);
        break;
    }
  }

  // Concatenate the sorted groups and add them around the failure steps
  for (var step in steps) {
    if (step.state != TimelineStepState.failed) {
      switch (step.state) {
        case TimelineStepState.future:
          sortedSteps.addAll(futureSteps);
          futureSteps.clear();
          break;
        case TimelineStepState.present:
          sortedSteps.addAll(presentSteps);
          presentSteps.clear();
          break;
        case TimelineStepState.completed:
          sortedSteps.addAll(completedSteps);
          completedSteps.clear();
          break;
        case TimelineStepState.failed:
        // TODO: Handle this case.
      }
    }
  }

  return sortedSteps;
}
