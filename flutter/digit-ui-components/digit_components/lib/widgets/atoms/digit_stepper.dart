// ignore_for_file: must_be_immutable

library flutter_stepindicator;

import 'dart:async';

import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';

/// The `FlutterStepIndicator` is a widget that displays a step indicator for visualizing progress through a multi-step process. This class extends `StatefulWidget` and can be used to display and monitor various stages, such as the steps in a registration process or multiple stages in a specific task.

/// Parameters:
/// - `list`: A list of stages or steps to be displayed.
/// - `page`: The current page number or active step.
/// - `positiveCheck`: An optional widget for displaying a positive checkmark.
/// - `disableAutoScroll`: A flag to enable or disable automatic scrolling.
/// - `height`: The height of the step indicator.
/// - `durationScroller`: The duration for scrolling animations.
/// - `durationCheckBulb`: The duration for checkmark bulb animations.
/// - `division`: The number of divisions for rendering steps.
/// - `positiveColor`: The color for positive steps.
/// - `negativeColor`: The color for negative (disabled) steps.
/// - `progressColor`: The color for the progress indicator.
/// - `onChange`: A callback function that triggers when the active step changes.

/// The `FlutterStepIndicator` class provides a flexible way to create step indicators and customize their appearance for various use cases.

class DigitStepper extends StatefulWidget {
  final List list;
  final int page;
  final Widget? positiveCheck;
  final double height;
  final Duration? durationScroller;
  final Duration? durationCheckBulb;
  final EdgeInsetsGeometry? padding;
  final Function(int)? onClickItem;
  final EdgeInsetsGeometry? paddingLine;
  final int? division;
  Color? positiveColor;
  Color? negativeColor;
  Color? progressColor;
  final Function(int) onChange;

  DigitStepper({
    super.key,
    required this.onChange,
    required this.list,
    this.durationScroller,
    this.durationCheckBulb,
    this.division,
    this.onClickItem,
    this.paddingLine,
    this.padding,
    this.positiveCheck,
    this.negativeColor,
    this.positiveColor,
    this.progressColor,
    required this.page,
    required this.height,
  });

  @override
  State<DigitStepper> createState() => _DigitStepperState();
}

class _DigitStepperState extends State<DigitStepper> {
  ScrollController controller = ScrollController();
  double maxWidths = 0.0;

  EdgeInsetsGeometry get paddingBulb =>
      (widget.padding != null) ? widget.padding! : EdgeInsets.zero;

  EdgeInsetsGeometry get paddingLine =>
      (widget.paddingLine != null) ? widget.paddingLine! : EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      // height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            shrinkWrap: true,
            controller: controller,
            physics: const NeverScrollableScrollPhysics(
                parent: NeverScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: widget.list.length,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (index == 0)
                    ? ItemStepIndicatorZero(
                        onClickItem: widget.onClickItem,
                        duration: _currentDurationBulb(),
                        childCheck: _checkEnable(index),
                        padding: paddingBulb,
                        disableColor: (widget.negativeColor == null)
                            ? Colors.grey
                            : widget.negativeColor!,
                        enableColor: (widget.positiveColor == null)
                            ? Colors.green
                            : widget.positiveColor!,
                        progressColor: (widget.progressColor == null)
                            ? Colors.orange
                            : widget.progressColor!,
                        index: index,
                        currentPage: widget.page,
                        height: widget.height,
                        width: widget.height)
                    : ItemStepIndicator(
                        onClickItem: widget.onClickItem,
                        duration: _currentDurationBulb(),
                        childCheck: _checkEnable(index),
                        height: widget.height,
                        paddingLine: paddingLine,
                        padding: paddingBulb,
                        currentPage: widget.page,
                        disableColor: (widget.negativeColor == null)
                            ? Colors.grey
                            : widget.negativeColor!,
                        enableColor: (widget.positiveColor == null)
                            ? Colors.green
                            : widget.positiveColor!,
                        progressColor: (widget.progressColor == null)
                            ? Colors.orange
                            : widget.progressColor!,
                        index: index,
                        width: widthIndicator(constraints.maxWidth),
                      ),
                const SizedBox(
                  height: 8,
                ),
                (index == 0)
                    ? ItemStepIndicatorZero1(
                        onClickItem: widget.onClickItem,
                        duration: _currentDurationBulb(),
                        childCheck: _checkEnable(index),
                        padding: paddingBulb,
                        item: widget.list[index],
                        disableColor: (widget.negativeColor == null)
                            ? Colors.grey
                            : widget.negativeColor!,
                        enableColor: (widget.positiveColor == null)
                            ? Colors.green
                            : widget.positiveColor!,
                        progressColor: (widget.progressColor == null)
                            ? Colors.orange
                            : widget.progressColor!,
                        index: index,
                        currentPage: widget.page,
                        height: widget.height,
                        width: widget.height)
                    : ItemStepIndicator1(
                        onClickItem: widget.onClickItem,
                        duration: _currentDurationBulb(),
                        childCheck: _checkEnable(index),
                        height: widget.height,
                        paddingLine: paddingLine,
                        padding: paddingBulb,
                        item: widget.list[index],
                        currentPage: widget.page,
                        disableColor: (widget.negativeColor == null)
                            ? Colors.grey
                            : widget.negativeColor!,
                        enableColor: (widget.positiveColor == null)
                            ? Colors.green
                            : widget.positiveColor!,
                        progressColor: (widget.progressColor == null)
                            ? Colors.orange
                            : widget.progressColor!,
                        index: index,
                        width: widthIndicator(constraints.maxWidth),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Duration _currentDuration() {
    return (widget.durationScroller == null)
        ? const Duration(milliseconds: 250)
        : widget.durationScroller!;
  }

  Duration _currentDurationBulb() {
    return (widget.durationCheckBulb == null)
        ? const Duration(milliseconds: 250)
        : widget.durationCheckBulb!;
  }

  Widget _checkEnable(int currentIndex) {
    return currentIndex == widget.page
        ? Text(currentIndex.toString())
        : currentIndex > widget.page
            ? Text(currentIndex.toString())
            : const Icon(
                Icons.check,
                size: 24,
                color: Colors.white,
              );
  }

  @override
  void didUpdateWidget(covariant DigitStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (((widget.list.length * widget.height) > (maxWidths / 2))) {
      if ((widget.page - 2) >= 0 &&
          (widget.page - 2) <= (widget.list.length - 5)) {
        controller.animateTo((widget.page - 2) * widthIndicator(maxWidths),
            duration: _currentDuration(), curve: Curves.decelerate);
      }
    } else {
      // ignore: curly_braces_in_flow_control_structures
      if (((((maxWidths - widget.height) / (widget.list.length - 1)) <
          // ignore: curly_braces_in_flow_control_structures
          (widget.height + 5)))) if ((widget.page - 2) >=
              0 &&
          (widget.page - 2) <= (widget.list.length - 5)) {
        controller.animateTo((widget.page - 2) * widthIndicator(maxWidths),
            duration: _currentDuration(), curve: Curves.decelerate);
      }
    }
    widget.onChange.call(widget.page);
  }

  double widthIndicator(double maxWidth) {
    maxWidths = maxWidth;
    return (((widget.list.length * widget.height) > (maxWidth / 2)))
        ? widthScroller(maxWidth)
        : ((((maxWidth - widget.height) / (widget.list.length - 1)) >
                (widget.height + 5)))
            ? ((maxWidth - widget.height) / (widget.list.length - 1))
            : widthScroller(maxWidth);
  }

  double widthScroller(double maxWidth) {
    return ((maxWidth - widget.height) /
        (((widget.list.length - 1) <= 2)
            ? (widget.list.length - 1)
            : (widget.division == null ||
                    (widget.division! <= 0) ||
                    (widget.division! >= widget.list.length))
                ? 4
                : widget.division!));
  }
}

class ItemStepIndicatorZero extends StatelessWidget {
  final double width;
  final double height;
  final int currentPage;
  final EdgeInsetsGeometry padding;
  final Duration duration;
  final int index;
  final Function(int)? onClickItem;
  final Color disableColor;
  final Color progressColor;
  final Color enableColor;
  final Widget childCheck;

  const ItemStepIndicatorZero({
    super.key,
    required this.height,
    required this.duration,
    required this.padding,
    this.onClickItem,
    required this.width,
    required this.currentPage,
    required this.index,
    required this.disableColor,
    required this.progressColor,
    required this.enableColor,
    required this.childCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: (onClickItem == null)
            ? null
            : () {
                onClickItem!.call(index);
              },
        child: Container(
          height: 32,
          width: 32,
          margin: const EdgeInsets.only(
            left: 8,
          ),
          padding: padding,
          child: AnimatedContainer(
            curve: Curves.easeOutQuint,
            duration: duration,
            decoration: BoxDecoration(
              color: index <= currentPage
                  ? const DigitColors().lightPrimaryOrange
                  : const DigitColors().lightTextDisabled,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: index <= currentPage
                      ? const DigitColors().lightPrimaryOrange
                      : const DigitColors().lightTextDisabled,
                  width: (index == currentPage) ? 2 : 0),
            ),
            // padding: EdgeInsets.all((index == currentPage) ? 2.5 : 0),
            alignment: Alignment.centerRight,
            child: Center(
                child: (index == currentPage)
                    ? Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                            color: index <= currentPage
                                ? const DigitColors().lightPrimaryOrange
                                : const DigitColors().lightTextDisabled,
                            borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: const DigitColors().lightPaperPrimary)),
                  ))
                    : index + 1 == currentPage
                        ? ShowUpAnimationPage(
                            duration: duration, delay: 0, child: childCheck)
                        : childCheck),
          ),
        ),
      ),
    );
  }
}

class ItemStepIndicatorZero1 extends StatelessWidget {
  final double width;
  final double height;
  final int currentPage;
  final EdgeInsetsGeometry padding;
  final Duration duration;
  final int index;
  final Function(int)? onClickItem;
  final Color disableColor;
  final Color progressColor;
  final String item;
  final Color enableColor;
  final Widget childCheck;

  const ItemStepIndicatorZero1({
    super.key,
    required this.height,
    required this.duration,
    required this.padding,
    this.onClickItem,
    required this.item,
    required this.width,
    required this.currentPage,
    required this.index,
    required this.disableColor,
    required this.progressColor,
    required this.enableColor,
    required this.childCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(item),
      ),
    );
  }
}

class ItemStepIndicator extends StatefulWidget {
  final double width;
  final double height;
  final int currentPage;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry paddingLine;
  final Function(int)? onClickItem;
  final Duration duration;
  final int index;
  final Color disableColor;
  final Color progressColor;
  final Color enableColor;
  final Widget childCheck;

  const ItemStepIndicator({
    Key? key,
    required this.height,
    required this.duration,
    required this.width,
    required this.currentPage,
    required this.paddingLine,
    this.onClickItem,
    required this.padding,
    required this.index,
    required this.disableColor,
    required this.progressColor,
    required this.enableColor,
    required this.childCheck,
  }) : super(key: key);

  @override
  _ItemStepIndicatorState createState() => _ItemStepIndicatorState();
}

class _ItemStepIndicatorState extends State<ItemStepIndicator> {
  late AnimationController _animationController;
  bool _isdone = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: (widget.onClickItem == null)
                ? null
                : () {
              widget.onClickItem!.call(widget.index);
            },
            child: Container(
              padding: widget.padding,
              height: 32,
              width: 32,
              child: SizedBox(
                child: (widget.index == widget.currentPage)
                    ? _isdone ? _enable(widget.index):_disable(widget.index)
                    : (widget.index < widget.currentPage)
                    ? _done(widget.index)
                    : _disable(widget.index),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: widget.paddingLine,
              height: 4,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0,
                    end: (widget.index == widget.currentPage) ? 1.0 : 0.0),
                curve: Curves.decelerate,
                onEnd: () {
                  setState(() {
                    _isdone = true;
                  });
                },
                duration: Duration(
                    milliseconds: widget.duration.inMilliseconds ~/ 1.6),
                builder: (context, value, _) =>
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Stack(
                            children: [
                              Visibility(
                                visible: true,
                                child: Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  color: widget.index < widget.currentPage
                                      ? const DigitColors().lightPrimaryOrange
                                      : const DigitColors().lightTextDisabled,
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(
                                  milliseconds: widget.duration
                                      .inMilliseconds ~/ 1.6,
                                ),
                                width: (constraints.maxWidth * value),
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                  gradient: (widget.index == widget.currentPage)
                                      ? LinearGradient(
                                      colors: [
                                        const DigitColors().lightPrimaryOrange,
                                        const DigitColors().lightPrimaryOrange
                                      ],
                                      end: Alignment.centerRight,
                                      begin: Alignment.centerLeft)
                                      : (widget.index < widget.currentPage
                                      ? LinearGradient(
                                      colors: [
                                        const DigitColors().lightPrimaryOrange,
                                        const DigitColors().lightPrimaryOrange
                                      ],
                                      end: Alignment.centerRight,
                                      begin: Alignment.centerLeft)
                                      : LinearGradient(
                                      colors: [
                                        const DigitColors().lightPrimaryOrange,
                                        const DigitColors().lightTextDisabled
                                      ],
                                      end: Alignment.centerRight,
                                      begin: Alignment.centerLeft)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _done(int currIndex) {
    return Container(
      decoration: BoxDecoration(
        color: const DigitColors().lightPrimaryOrange,
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.centerRight,
      child: Center(
        child: (currIndex + 1 == widget.currentPage)
            ? AnimatedContainer(
          curve: Curves.easeOutQuint,
          duration: Duration(milliseconds: widget.duration.inMilliseconds),
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: const DigitColors().lightPrimaryOrange,
            borderRadius: BorderRadius.circular(50),
          ),
          child: ShowUpAnimationPage(
            duration: widget.duration,
            delay: 0,
            child: widget.childCheck,
          ),
        )
            : Container(
            decoration: BoxDecoration(
              color: const DigitColors().lightPrimaryOrange,
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.centerRight,
            child: Center(child: widget.childCheck)),
      ),
    );
  }

  Widget _disable(int currentIndex) {
    return AnimatedContainer(
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: widget.duration.inMilliseconds),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.transparent, width: 0.0),
      ),
      alignment: Alignment.centerRight,
      child: Center(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: const DigitColors().lightTextDisabled,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
                (currentIndex + 1).toString(),
                style: TextStyle(color: const DigitColors().lightPaperPrimary),
              )),
        ),
      ),
    );
  }

  Widget _enable(int currentIndex) {
    return AnimatedContainer(
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: widget.duration.inMilliseconds),
      decoration: BoxDecoration(
        color: const DigitColors().lightPrimaryOrange,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const DigitColors().lightPrimaryOrange, width: 2.0),
      ),
      alignment: Alignment.centerRight,
      child: Center(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: const DigitColors().lightPrimaryOrange,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              (currentIndex + 1).toString(),
              style: TextStyle(color: const DigitColors().lightPaperPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemStepIndicator1 extends StatelessWidget {
  final double width;
  final double height;
  final int currentPage;
  final String item;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry paddingLine;
  final Function(int)? onClickItem;
  final Duration duration;
  final int index;
  final Color disableColor;
  final Color progressColor;
  final Color enableColor;
  final Widget childCheck;

  const ItemStepIndicator1({
    super.key,
    required this.height,
    required this.duration,
    required this.width,
    required this.currentPage,
    required this.paddingLine,
    required this.item,
    this.onClickItem,
    required this.padding,
    required this.index,
    required this.disableColor,
    required this.progressColor,
    required this.enableColor,
    required this.childCheck,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            // width: height,
            child: Text(item),
          ),
          Expanded(
            child: Container(
              padding: paddingLine,
              height: 4,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: (index == currentPage) ? 0.0 : 0.0),
                curve: Curves.decelerate,
                duration:
                    Duration(milliseconds: duration.inMilliseconds ~/ 1.6),
                builder: (context, value, _) => LayoutBuilder(
                  builder: (context, constraints) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(
                        children: [
                          Visibility(
                            visible: false,
                            child: Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              color: index < currentPage
                                  ? enableColor
                                  : disableColor.withOpacity(0.5),
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(
                                milliseconds: duration.inMilliseconds ~/ 1.6),
                            width: (constraints.maxWidth * value),
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              gradient: (index == currentPage)
                                  ? LinearGradient(
                                      colors: [enableColor, enableColor],
                                      end: Alignment.centerRight,
                                      begin: Alignment.centerLeft)
                                  : (index < currentPage
                                      ? LinearGradient(
                                          colors: [enableColor, enableColor],
                                          end: Alignment.centerRight,
                                          begin: Alignment.centerLeft)
                                      : LinearGradient(
                                          colors: [
                                              enableColor.withOpacity(0.5),
                                              disableColor.withOpacity(0.5)
                                            ],
                                          end: Alignment.centerRight,
                                          begin: Alignment.centerLeft)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _done(int currIndex) {
    return Container(
      decoration: BoxDecoration(
        color: enableColor,
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.centerRight,
      child: Center(
        child: (currIndex + 1 == currentPage)
            ? AnimatedContainer(
                curve: Curves.easeOutQuint,
                duration: Duration(milliseconds: duration.inMilliseconds),
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: enableColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ShowUpAnimationPage(
                  duration: duration,
                  delay: 0,
                  child: childCheck,
                ),
              )
            : childCheck,
      ),
    );
  }

  Widget _disable() {
    return AnimatedContainer(
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: duration.inMilliseconds),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.transparent, width: 0.0),
      ),
      alignment: Alignment.centerRight,
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: duration.inMilliseconds ~/ 1),
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: disableColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }

  Widget _enable() {
    return AnimatedContainer(
      curve: Curves.easeOutQuint,
      duration: Duration(milliseconds: duration.inMilliseconds),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: progressColor, width: 2.0),
      ),
      alignment: Alignment.centerRight,
      child: Center(
          child: AnimatedContainer(
        duration: Duration(milliseconds: duration.inMilliseconds ~/ 1),
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: progressColor, borderRadius: BorderRadius.circular(50)),
      )),
    );
  }
}

class ShowUpAnimationPage extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final int delay;

  const ShowUpAnimationPage(
      {super.key,
      required this.duration,
      required this.child,
      required this.delay});

  @override
  createState() => _ShowUpAnimationPage();
}

class _ShowUpAnimationPage extends State<ShowUpAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: widget.duration);
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, -0.05), end: Offset.zero)
            .animate(curve);
// ignore: unnecessary_null_comparison
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
