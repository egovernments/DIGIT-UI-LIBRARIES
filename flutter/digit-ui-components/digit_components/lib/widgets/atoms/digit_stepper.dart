import 'package:flutter/material.dart';
import 'package:digit_components/theme/colors.dart';
import 'package:digit_components/theme/digit_theme.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';

class DigitStepper extends StatefulWidget {
  final int activeStep;
  final List<StepsModel> steps;
  final int maxStepReached;
  final double lineLength;
  final double lineSpace;
  final void Function(int)? onStepReached;
  final LineType lineType;
  final bool enableStepTapping;
  final Axis direction;
  final Color? unreachedStepBackgroundColor;
  final Color? unreachedStepTextColor;
  final Color? unreachedStepIconColor;
  final Color? unreachedStepBorderColor;
  final Color? activeStepTextColor;
  final Color? activeStepIconColor;
  final Color? activeStepBackgroundColor;
  final Color? activeStepBorderColor;
  final Color? finishedStepTextColor;
  final Color? finishedStepBackgroundColor;
  final Color? finishedStepBorderColor;
  final Color? finishedStepIconColor;
  final Color? defaultLineColor;
  final Color? unreachedLineColor;
  final Color? activeLineColor;
  final Color? finishedLineColor;
  final double stepRadius;
  final bool steppingEnabled;
  final bool disableScroll;
  final bool showTitle;
  final AlignmentGeometry alignment;
  final double? lineDotRadius;
  final double lineThickness;
  final EdgeInsetsDirectional padding;
  final double internalPadding;
  final Curve? stepReachedAnimationEffect;
  final Curve? stepAnimationCurve;
  final Duration stepReachedAnimationDuration;
  final Duration? stepAnimationDuration;
  final double borderThickness;
  final String? loadingAnimation;
  final StepShape stepShape;
  final double? stepBorderRadius;
  final BorderType defaultStepBorderType;
  final BorderType? unreachedStepBorderType;
  final BorderType? activeStepBorderType;
  final BorderType? finishedStepBorderType;
  final List<double> dashPattern;
  final bool showStepBorder;
  final bool showLoadingAnimation;
  final TextDirection textDirection;

  const DigitStepper({
    Key? key,
    required this.activeStep,
    required this.steps,
    required this.maxStepReached,
    this.lineLength = 200,
    this.lineSpace = 0,
    this.lineType = LineType.normal,
    this.onStepReached,
    this.enableStepTapping = true,
    this.direction = Axis.horizontal,
    this.unreachedStepBackgroundColor,
    this.unreachedStepTextColor,
    this.unreachedStepIconColor,
    this.unreachedStepBorderColor,
    this.activeStepTextColor,
    this.activeStepIconColor,
    this.activeStepBackgroundColor,
    this.activeStepBorderColor,
    this.finishedStepTextColor,
    this.finishedStepBackgroundColor,
    this.finishedStepBorderColor,
    this.finishedStepIconColor,
    this.defaultLineColor,
    this.unreachedLineColor,
    this.activeLineColor,
    this.finishedLineColor,
    this.stepRadius = 12,
    this.steppingEnabled = true,
    this.disableScroll = false,
    this.showTitle = true,
    this.alignment = Alignment.center,
    this.lineDotRadius,
    this.lineThickness = 4,
    this.padding = const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
    this.internalPadding = 0,
    this.stepReachedAnimationEffect,
    this.stepAnimationCurve,
    this.stepReachedAnimationDuration = const Duration(milliseconds: 10),
    this.stepAnimationDuration,
    this.borderThickness = 0.8,
    this.loadingAnimation,
    this.stepShape = StepShape.circle,
    this.stepBorderRadius,
    this.defaultStepBorderType = BorderType.normal,
    this.unreachedStepBorderType,
    this.activeStepBorderType,
    this.finishedStepBorderType,
    this.dashPattern = const [3, 1],
    this.showStepBorder = false,
    this.showLoadingAnimation = false,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  @override
  _DigitStepperState createState() => _DigitStepperState();
}

class _DigitStepperState extends State<DigitStepper> {
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: widget.activeStep,
      lineLength: widget.lineLength,
      lineSpace: widget.lineSpace,
      lineType: widget.lineType,
      maxReachedStep: widget.maxStepReached,
      defaultLineColor: widget.defaultLineColor ?? const DigitColors().lightTextDisabled,
      activeStepBackgroundColor: widget.activeStepBackgroundColor ?? const DigitColors().lightPrimaryOrange,
      activeStepBorderColor: widget.activeStepBorderColor,
      activeStepTextColor: widget.activeStepTextColor ?? DigitTheme.instance.colorScheme.onSurface,
      activeLineColor: widget.activeLineColor,
      activeStepBorderType: widget.activeStepBorderType ?? widget.defaultStepBorderType,
      activeStepIconColor: widget.activeStepIconColor,
      alignment: widget.alignment,
      unreachedLineColor: widget.unreachedLineColor ?? const DigitColors().lightTextDisabled,
      unreachedStepBorderColor: widget.unreachedStepBorderColor ?? const DigitColors().lightTextDisabled,
      unreachedStepBorderType: widget.unreachedStepBorderType ?? widget.defaultStepBorderType,
      unreachedStepIconColor: widget.unreachedStepIconColor ?? const DigitColors().lightTextDisabled,
      unreachedStepBackgroundColor: widget.unreachedStepBackgroundColor ?? const DigitColors().lightTextDisabled,
      unreachedStepTextColor: widget.unreachedStepTextColor ?? DigitTheme.instance.colorScheme.onSurface,
      finishedLineColor: widget.finishedLineColor ?? const DigitColors().lightPrimaryOrange,
      finishedStepBackgroundColor: widget.finishedStepBackgroundColor ?? const DigitColors().lightPrimaryOrange,
      finishedStepTextColor: widget.finishedStepTextColor ?? DigitTheme.instance.colorScheme.onSurface,
      finishedStepBorderColor: widget.finishedStepBorderColor ?? const DigitColors().lightPrimaryOrange,
      finishedStepBorderType: widget.finishedStepBorderType ?? widget.defaultStepBorderType,
      finishedStepIconColor: widget.finishedStepIconColor ?? const DigitColors().lightPrimaryOrange,
      internalPadding: widget.internalPadding,
      showLoadingAnimation: widget.showLoadingAnimation,
      stepRadius: widget.stepRadius,
      showStepBorder: widget.showStepBorder,
      lineThickness: 2,
      onStepReached: widget.onStepReached,
      disableScroll: widget.disableScroll,
      enableStepTapping: widget.enableStepTapping,
      borderThickness: 0,
      direction: widget.direction,
      dashPattern: widget.dashPattern,
      defaultStepBorderType: widget.defaultStepBorderType,
      loadingAnimation: widget.loadingAnimation,
      padding: widget.padding,
      showTitle: widget.showTitle,
      stepAnimationCurve: widget.stepAnimationCurve ?? widget.stepReachedAnimationEffect,
      stepAnimationDuration: widget.stepAnimationDuration ?? widget.stepReachedAnimationDuration,
      stepBorderRadius: widget.stepBorderRadius,
      steppingEnabled: widget.steppingEnabled,
      stepShape: widget.stepShape,
      textDirection: widget.textDirection,
      steps: List.generate(
        widget.steps.length,
            (index) => EasyStep(
          customTitle: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                margin: widget.steps[index].titleMargin ?? const EdgeInsets.all(0.0),
                padding: widget.steps[index].titlePadding ?? const EdgeInsets.all(0.0),
                width: widget.steps[index].titleWidth ?? 5,
                child: Text(
                  widget.steps[index].title,
                  style: DigitTheme.instance.mobileTheme.textTheme.bodySmall?.apply(
                    color: DigitTheme.instance.colorScheme.onSurface,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                ),
              );
            },
          ),
          enabled: widget.onStepReached != null && index < widget.activeStep,
          customStep: Container(
            height: widget.stepRadius * 2,
            width: widget.stepRadius * 2,
            padding: widget.steps[index].padding,
            decoration: BoxDecoration(
              color: index <= widget.activeStep
                  ? widget.activeStepBackgroundColor ?? const DigitColors().lightPrimaryOrange
                  : widget.unreachedStepBackgroundColor ?? const DigitColors().lightTextDisabled,
              shape: widget.steps[index].shape,
            ),
            child: Center(
              child: index >= widget.activeStep
                  ? FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.steps[index].number,
                  style: DigitTheme.instance.mobileTheme.textTheme.bodySmall?.apply(
                    color: const DigitColors().lightPaperPrimary,
                  ),
                ),
              )
                  : Icon(
                widget.steps[index].completedIcon ?? Icons.check,
                color: widget.steps[index].iconColor ?? const DigitColors().lightPaperPrimary,
                size: widget.stepRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StepsModel {
  final String title;
  final double? titleWidth;
  final EdgeInsets? titleMargin;
  final EdgeInsets? titlePadding;
  final String number;
  final EdgeInsets padding;
  final BoxShape shape;
  final Color? textColor;
  final Color? iconColor;
  final IconData? completedIcon;

  const StepsModel({
    required this.title,
    required this.number,
    this.titleMargin,
    this.titlePadding,
    this.titleWidth,
    this.padding = EdgeInsets.zero,
    this.shape = BoxShape.circle,
    this.textColor,
    this.iconColor,
    this.completedIcon,
  });
}
