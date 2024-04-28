import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

enum StepperDirection { horizontal, vertical }

//ignore: must_be_immutable
class Steppers extends StatelessWidget {
  const Steppers({
    Key? key,
    required this.labels,
    required this.currentStep,
    this.direction = StepperDirection.horizontal,
  }) : super(key: key);

  final List<StepperDataModel> labels;
  final int currentStep;
  final StepperDirection direction;

  @override
  Widget build(BuildContext context) {

    return HorizontalSteppers(
      labels: labels,
      currentStep: currentStep,
    );
  }
}

class HorizontalSteppers extends StatelessWidget {
  const HorizontalSteppers({
    Key? key,
    required this.labels,
    required this.currentStep,
  }) : super(key: key);

  final List<StepperDataModel> labels;
  final int currentStep;

  get _totalSteps => labels.length;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(children: _buildListDividers()),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildListStepWidgets(),
        ),
      ],
    );
  }

  _buildListDividers() {
    List<Widget> dividers = [];
    labels.asMap().forEach((index, model) {
      dividers.add(ProgressStepHorizontalDivider(
        step: index + 1,
        currentStep: currentStep,
        totalSteps: _totalSteps,
        labels: labels,
      ));
    });
    return dividers;
  }

  _buildListStepWidgets() {
    List<Widget> stepWidgets = [];
    labels.asMap().forEach((index, model) {
      stepWidgets.add(HorizontalStepperItem(
        step: index + 1,
        currentStep: currentStep,
        stepData: model,
        totalSteps: _totalSteps,
      ));
    });
    return stepWidgets;
  }
}

class ProgressStepHorizontalDivider extends StatelessWidget {
  const ProgressStepHorizontalDivider({
    Key? key,
    required this.step,
    required this.currentStep,
    required this.totalSteps,
    required this.labels,
  }) : super(key: key);

  final int step;
  final int currentStep;
  final int totalSteps;
  final List<StepperDataModel> labels;

  bool _isCurrentStep(int step) => currentStep >= step;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          _buildSeparatorLine(step, color: _leftDividerColor),
          const SizedBox(
            width: 32,
          ),
          _buildSeparatorLine(step, color: _rightDividerColor),
        ],
      ),
    );
  }

  Widget _buildSeparatorLine(int step, {required Color color}) => Expanded(
        child: Container(
          color: color,
          height: 1,
        ),
      );

  get _leftDividerColor {
    if (step == 1) return const DigitColors().transparent;
    if (labels[step - 1].state == StepperState.error) {
      return const DigitColors().light.alertError;
    }
    if (_isCurrentStep(step)) return const DigitColors().light.primary1;
    return const DigitColors().light.textDisabled;
  }

  get _rightDividerColor {
    if (step == totalSteps) return const DigitColors().transparent;
    if (labels[step].state == StepperState.error) {
      return const DigitColors().light.alertError;
    }
    if (_isCurrentStep(step + 1)) return const DigitColors().light.primary1;
    return const DigitColors().light.textDisabled;
  }
}

class HorizontalStepperItem extends StatelessWidget {
  const HorizontalStepperItem({
    Key? key,
    required this.step,
    required this.currentStep,
    required this.totalSteps,
    required this.stepData,
    Map<String, Object>? trackingParam,
    String? identity,
    TargetPlatform? platformOverride,
  }) : super(key: key);

  final int step;
  final int currentStep;
  final int totalSteps;
  final StepperDataModel stepData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color:
                  (step == currentStep && stepData.state != StepperState.error)
                      ? const DigitColors().light.primary1
                      : const DigitColors().transparent,
              shape: BoxShape.circle,
            ),
            child: StepperIcon(
              step: step,
              currentStep: currentStep,
              stepData: stepData,
            ),
          ),
          _buildStepDescriptionWidget(step, stepData.label),
        ],
      ),
    );
  }

  Widget _buildStepDescriptionWidget(int step, String label) => Text(
        label,
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
}

class StepperIcon extends StatelessWidget {
  const StepperIcon({
    Key? key,
    required this.step,
    required this.currentStep,
    required this.stepData,
  }) : super(key: key);

  final int currentStep;
  final int step;
  final StepperDataModel stepData;

  bool _isCurrentStep(int step) => currentStep >= step;

  bool _isPassedStep(int step) => currentStep <= step;

  @override
  Widget build(BuildContext context) {
    return stepData.state == StepperState.error
        ? _errorWidget
        : Container(
            alignment: Alignment.center,
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _isCurrentStep(step)
                  ? const DigitColors().light.primary1
                  : const DigitColors().light.textDisabled,
              shape: BoxShape.circle,
            ),
            child: _isPassedStep(step)
                ? Text(
                    '$step',
                    style: TextStyle(
                        color: const DigitColors().light.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                : const Icon(
                    Icons.done_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
          );
  }

  get _errorWidget => Container(
        alignment: Alignment.center,
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: const DigitColors().light.alertError,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.error,
          color: Colors.white,
          size: 16,
        ),
      );
}

class StepperDataModel {
  StepperDataModel({
    this.id = "",
    required this.label,
    this.description,
    this.child,
    this.state = StepperState.normal,
  });

  String id;
  String label;
  String? description;
  StepperState state;
  Widget? child;
}

enum StepperState { normal, loading, error, success }
