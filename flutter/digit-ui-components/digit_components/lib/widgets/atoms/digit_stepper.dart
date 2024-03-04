import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final int currentStep;
  final List<StepData> steps;

  CustomStepper({required this.currentStep, required this.steps});

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late List<bool> _isHovered;

  @override
  void initState() {
    super.initState();
    _isHovered = List<bool>.filled(widget.steps.length, false);
  }

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context);

    return Stack(
      children: [
        _buildLine(),
        _buildSteps(currentTypography),
      ],
    );
  }

  Widget _buildSteps(DigitTypography currentTypography) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.steps.length,
          (i) => _buildStep(widget.steps[i], i, currentTypography),
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      width: double.infinity,
      height: 4.0,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        children: List.generate(
          widget.steps.length - 1,
          (i) => _buildLineSegment(i),
        ),
      ),
    );
  }

  Widget _buildLineSegment(int index) {
    final isCompleted = index < widget.currentStep;
    final isCurrent = index == widget.currentStep;

    return Expanded(
      child: Container(
        height: 4.0,
        color: isCompleted
            ? const DigitColors().lightPrimaryOrange
            : const DigitColors().lightTextDisabled,
      ),
    );
  }

  Widget _buildStep(
      StepData step, int index, DigitTypography currentTypography) {
    final isCompleted = index < widget.currentStep;
    final isCurrent = index == widget.currentStep;

    Widget stepWidget = Container(
      // margin: _isHovered[index] ? EdgeInsets.zero: const EdgeInsets.only(bottom: 2) ,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isCompleted || isCurrent
                        ? const DigitColors().lightPrimaryOrange
                        : const DigitColors().lightTextDisabled,
                  ),
                  child: isCompleted
                      ? Icon(
                          Icons.check,
                          size: 24,
                          color: const DigitColors().lightPaperPrimary,
                        )
                      : Center(
                          child: Text(
                            (index + 1).toString(),
                            style: isCurrent
                                ? currentTypography.headingS.copyWith(
                                    fontFamily: 'Roboto',
                                    color: const DigitColors().lightPaperPrimary,
                                    height: 1.172,
                                  )
                                : currentTypography.bodyL.copyWith(
                                    color: const DigitColors().lightPaperPrimary,
                                    height: 1.5,
                                  ),
                          ),
                        ),
                ),
          const SizedBox(height: kPadding),
          Text(
            step.stepName,
            style: isCurrent || _isHovered[index]
                ? currentTypography.headingS.copyWith(
                    fontFamily: 'Roboto',
                    color: const DigitColors().lightTextPrimary,
                    height: 1.172,
                  )
                : currentTypography.bodyL.copyWith(
                    color: const DigitColors().lightTextPrimary,
                    height: 1.5,
                  ),
          ),
        ],
      ),
    );

    if (step.onClick != null) {
      stepWidget = InkWell(
        onHover: (hover) {
          setState(() {
            _isHovered[index] = hover;
          });
        },
        onTap: () {
          step.onClick!();
        },
        child: stepWidget,
      );
    }

    return stepWidget;
  }
}

class StepData {
  final String stepName;
  final Function()? onClick;

  StepData({required this.stepName, this.onClick});
}
