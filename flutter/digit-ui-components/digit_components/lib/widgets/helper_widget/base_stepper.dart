import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../theme/spacers.dart';
import '../atoms/stepper.dart';
import 'base_stepper_delegate.dart';

/// Callback is fired when a step is reached.
typedef OnStepReached = void Function(int index);

enum StepShape { circle, rRectangle }

enum BorderType { normal, dotted }

enum LineType { normal, dotted, dashed }

class BaseStep extends StatelessWidget {
  const BaseStep({
    Key? key,
    required this.step,
    required this.isActive,
    required this.isFinished,
    required this.isUnreached,
    required this.onStepSelected,
    required this.radius,
    required this.stepRadius,
    required this.textDirection,
    required this.lineLength,
    required this.enabled,
    required this.direction,
    required this.showScrollBar,
    required this.index,
    required this.activeIndex,
    required this.totalLength,
  }) : super(key: key);
  final EasyStep step;
  final bool isActive;
  final bool isFinished;
  final bool isUnreached;
  final VoidCallback? onStepSelected;
  final double radius;
  final double? stepRadius;
  final TextDirection textDirection;
  final double lineLength;
  final bool enabled;
  final bool showScrollBar;
  final Axis direction;
  final int index;
  final int activeIndex;
  final int totalLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (radius * 2),
      height: showScrollBar ? 10 + (radius * 2 + spacer2) : (radius * 2 + spacer2),
      child: InkWell(
        onTap: enabled ? onStepSelected : null,
        canRequestFocus: false,
        child: CustomMultiChildLayout(
          delegate: BaseStepDelegate(
              stepRadius: radius, topTitle: false, direction: direction),
          children: [
            LayoutId(
              id: BaseStepElem.step,
              child:
                  StepperItemWidget(
                isHover: false,
                index: index,
                isActive: isActive,
                isFinished: isFinished,
                isUnreached: isUnreached,
                activeIndex: activeIndex,
                totalLength: totalLength,
                // currentProgressedIndex: widget.currentProgressedIndex,
              ),
            ),
            LayoutId(id: BaseStepElem.title, child: _buildStepTitle(context))
          ],
        ),
      ),
    );
  }

  Widget _buildStepTitle(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    return SizedBox(
      width: (radius * 2) + (direction == Axis.horizontal ? lineLength : 0),
      child: step.customTitle ??
          Text(
            step.title ?? '',
            maxLines: 3,
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.visible,
            style: isActive
                ? textTheme.headingS
                    .copyWith(color: theme.colorTheme.text.primary)
                : textTheme.bodyS.copyWith(
                    color: isActive || isFinished
                        ? theme.colorTheme.text.primary
                        : theme.colorTheme.text.secondary),
          ),
    );
  }
}

class StepperItemWidget extends StatelessWidget {
  /// Default stepper dot
  const StepperItemWidget({
    Key? key,
    required this.isActive,
    required this.isFinished,
    required this.isUnreached,
    this.isHover = false,
    required this.index,
    this.currentProgressedIndex,
    this.activeIndex,
    required this.totalLength,
  }) : super(key: key);

  final bool isActive;
  final bool isFinished;
  final bool isUnreached;
  final int index;
  final bool isHover;
  final int? currentProgressedIndex;
  final int? activeIndex;
  final int totalLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    return isActive
        ? Row(
            children: [
              buildLine(index - 1 == activeIndex ? true : isActive, isFinished,
                  isUnreached, context,
                  firstOrLast: index == 0 ? true : false),
              Container(
                height: isMobile ? spacer6 : spacer8,
                width: isMobile ? spacer6 : spacer8,
                decoration: BoxDecoration(
                  color: theme.colorTheme.primary.primary1,
                  border: Border.all(
                    color: theme.colorTheme.primary.primary1,
                    width: Base.defaultBorderWidth,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Base.defaultCircularRadius),
                  ),
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: theme.colorTheme.primary.primary1
                                .withOpacity(.12),
                            offset: const Offset(0, 0),
                            spreadRadius: 4,
                            blurRadius: 0,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: textTheme.headingS
                        .copyWith(color: theme.colorTheme.paper.primary),
                  ),
                ),
              ),
              buildLine(isActive, isFinished, isUnreached, context,
                  firstOrLast: index == totalLength - 1 ? true : false),
            ],
          )
        : isFinished
            ? Row(
                children: [
                  buildLine(index - 1 == activeIndex ? true : isActive,
                      isFinished, isUnreached, context,
                      firstOrLast: index == 0 ? true : false),
                  Container(
                    height: isMobile ? spacer6 : spacer8,
                    width: isMobile ? spacer6 : spacer8,
                    decoration: BoxDecoration(
                      color: theme.colorTheme.primary.primary1,
                      border: Border.all(
                        color: theme.colorTheme.primary.primary1,
                        width: Base.defaultBorderWidth,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Base.defaultCircularRadius),
                      ),
                      boxShadow: isHover
                          ? [
                              BoxShadow(
                                color: theme.colorTheme.primary.primary1
                                    .withOpacity(.12),
                                offset: const Offset(0, 0),
                                spreadRadius: 4,
                                blurRadius: 0,
                              ),
                            ]
                          : [],
                    ),
                    child: Icon(
                      Icons.check,
                      size: isMobile ? spacer9 / 2 : spacer6,
                      color: theme.colorTheme.paper.primary,
                    ),
                  ),
                  buildLine(isActive, isFinished, isUnreached, context,
                      firstOrLast: index == totalLength - 1 ? true : false),
                ],
              )
            : Row(
                children: [
                  buildLine(index - 1 == activeIndex ? true : isActive,
                      isFinished, isUnreached, context,
                      firstOrLast: index == 0 ? true : false),
                  Container(
                    height: isMobile ? spacer6 : spacer8,
                    width: isMobile ? spacer6 : spacer8,
                    decoration: BoxDecoration(
                      color: theme.colorTheme.paper.primary,
                      border: Border.all(
                        color: theme.colorTheme.text.disabled,
                        width: Base.selectedBorderWidth,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Base.defaultCircularRadius),
                      ),
                      boxShadow: isHover
                          ? [
                              BoxShadow(
                                color: theme.colorTheme.primary.primary1
                                    .withOpacity(.12),
                                offset: const Offset(0, 0),
                                spreadRadius: 4,
                                blurRadius: 0,
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: textTheme.bodyS
                            .copyWith(color: theme.colorTheme.text.secondary),
                      ),
                    ),
                  ),
                  buildLine(isActive, isFinished, isUnreached, context,
                      firstOrLast: index == totalLength - 1 ? true : false),
                ],
              );
  }

  Color _getLineColor(
      bool isActive, bool isFinished, bool isUnreached, BuildContext context,
      {bool firstOrLast = false}) {
    final theme = Theme.of(context);

    Color? preferredColor;
    if (firstOrLast) {
      preferredColor = theme.colorTheme.generic.transparent;
    } else if (isActive) {
      //Active Step
      preferredColor = theme.colorTheme.primary.primary1;
    } else if (isUnreached) {
      //Unreached Step
      preferredColor = theme.colorTheme.text.disabled;
    } else if (isFinished) {
      //Finished Step
      preferredColor = theme.colorTheme.primary.primary1;
    }

    return preferredColor ?? Theme.of(context).colorScheme.primary;
  }

  double _getLineThickness(
      bool isActive, bool isFinished, bool isUnreached, BuildContext context) {
    final theme = Theme.of(context);

    double? thickness;

    if (isActive) {
      //Active Step
      thickness = 4;
    } else if (isUnreached) {
      //Unreached Step
      thickness = 2;
    } else if (isFinished) {
      //Finished Step
      thickness = 4;
    }

    return thickness ?? 4;
  }

  Widget buildLine(
      bool isActive, bool isFinished, bool isUnreached, BuildContext context,
      {bool firstOrLast = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 2
          // bottom: axis == Axis.vertical ? 10 : 0,
          ),
      child: EasyLine(
        length: 16,
        color: _getLineColor(isActive, isFinished, isUnreached, context,
            firstOrLast: firstOrLast),
        thickness:
            _getLineThickness(isActive, isFinished, isUnreached, context),
        spacing: 0,
        width: _getLineThickness(isActive, isFinished, isUnreached, context),
        axis: Axis.horizontal,
      ),
    );
  }
}
