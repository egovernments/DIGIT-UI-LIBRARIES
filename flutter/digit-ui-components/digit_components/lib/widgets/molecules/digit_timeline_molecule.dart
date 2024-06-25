import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  bool isExpanded = false;
  final ScrollController _scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    List<TimelineStep> sortedSteps = sortSteps(List.from(widget.steps));
    int stepsToShow = isExpanded ? sortedSteps.length : widget.initialStepCount;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: sortedSteps.asMap().entries.map((entry) {
              int idx = entry.key;
              int firstFutureIndex = sortedSteps.lastIndexWhere((step) => step.state == TimelineStepState.future);
              if (idx >= stepsToShow && !isExpanded) return Container();
              TimelineStep step = entry.value;
              return Column(
                children: [
                  DigitTimeline(
                    currentStep: step.state,
                    label: step.label,
                    isLastStep: idx == sortedSteps.length - 1,
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
              label: isExpanded ? 'View Less' : 'View More',
              type: ButtonType.tertiary,
              size: ButtonSize.medium,
              suffixIcon: isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
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
  steps.sort((a, b) {
    if (a.state == TimelineStepState.future &&
        b.state != TimelineStepState.future) {
      return -1;
    } else if (a.state != TimelineStepState.future &&
        b.state == TimelineStepState.future) {
      return 1;
    } else if (a.state == TimelineStepState.present &&
        b.state != TimelineStepState.present) {
      return -1;
    } else if (a.state != TimelineStepState.present &&
        b.state == TimelineStepState.present) {
      return 1;
    } else if (a.state == TimelineStepState.completed &&
        b.state != TimelineStepState.completed) {
      return 1;
    } else if (a.state != TimelineStepState.completed &&
        b.state == TimelineStepState.completed) {
      return -1;
    } else {
      return 0;
    }
  });
  return steps;
}
