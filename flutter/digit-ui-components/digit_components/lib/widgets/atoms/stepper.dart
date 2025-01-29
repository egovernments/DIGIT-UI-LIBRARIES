library easy_stepper;

import 'dart:io' as io;
import 'dart:math';
import 'dart:ui';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
import '../../constants/AppView.dart';
import '../../theme/spacers.dart';
import '../helper_widget/base_stepper.dart';

class EasyStep {

  /// Create your own Widget for step, if this property is set `icon`, `activeIcon` and `finishIcon` will be ignored..
  final Widget? customStep;

  /// The title of the step.
  final String? title;

  /// Create your own title widget of the step, if this property is set `title` will be ignored..
  final Widget? customTitle;

  /// The callback that is called when a step is tapped.
  final Function()? onStepTap;

  const EasyStep({
    this.title,
    this.customStep,
    this.customTitle,
    this.onStepTap,
  });
}

class EasyStepper extends StatefulWidget {
  /// Each Step defines a step icon and title. Hence, total number of icons determines the total number of steps.
  final List<EasyStep> steps;

  /// Whether to allow tapping a step to move to that step or not.
  final bool enableStepTapping;

  /// Whether to show the steps horizontally or vertically. __Note: Ensure horizontal stepper goes inside a column and vertical goes inside a row.__
  final Axis direction;

  /// Whether the scrolling is disabled or not.
  final bool disableScroll;

  /// The index of currently active step.
  final int activeStep;

  final Alignment alignment;

  /// The index of highest reached step
  final int? maxReachedStep;

  final double? lineLength;

  /// The amount of padding around the stepper.
  final EdgeInsetsGeometry? padding;

  ///Set this to true if the titles (of at least the first or last step) are wider
  ///than the step itself. This will allow the stepper to correctly pad them so that
  ///the titles don't get cut off
  final bool titlesAreLargerThanSteps;

  /// The duration of the animation effect to show when a step is reached.
  final Duration stepAnimationDuration;

  /// Text Direction of the app.
  final TextDirection textDirection;

  /// Show `Scrollbar` in Web or Desktop. default `True`.
  final bool showScrollbar;

  /// Whether the stepper take the full width of the screen or not, this property work when `disableScroll = true`. default `True`.
  final bool fitWidth;

  const EasyStepper({
    Key? key,
    required this.activeStep,
    required this.steps,
    this.maxReachedStep,
    this.enableStepTapping = true,
    this.direction = Axis.horizontal,
    this.lineLength,
    this.disableScroll = false,
    this.alignment = Alignment.center,
    this.fitWidth = true,
    this.showScrollbar = true,
    this.padding,
    this.titlesAreLargerThanSteps = false,
    this.stepAnimationDuration = const Duration(seconds: 1),
    this.textDirection = TextDirection.ltr,
  })  : assert(steps.length > 0),
        super(key: key);

  @override
  State<EasyStepper> createState() => _EasyStepperState();
}

class _EasyStepperState extends State<EasyStepper> {
  ScrollController? _scrollController;
  late int _selectedIndex;
  late EdgeInsetsGeometry _padding;
  late double _lineLength;
  late double stepRadius;

  @override
  void initState() {
    _selectedIndex = widget.activeStep;
    _scrollController = ScrollController();
    _lineLength = widget.lineLength ?? 50; // TODO: Remove
    _padding = const EdgeInsetsDirectional.all(10);
    stepRadius = 16; // TODO: Remove
    // Update values dynamically based on screen size after widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStepDimensions();
    });
    if (widget.direction == Axis.horizontal) {
      // if (widget.steps.any((element) => element.topTitle)) {
      //   _padding = _padding.add(const EdgeInsetsDirectional.only(top: 45));
      // }
      // if (widget.titlesAreLargerThanSteps) {
        _padding = _padding.add(EdgeInsetsDirectional.symmetric(
            horizontal: _lineLength / 2));
      // }
      if (!widget.disableScroll && widget.showScrollbar) {
        _padding = _padding.add(const EdgeInsetsDirectional.only(bottom: 15));
      }
    }
    if (widget.padding != null) {
      _padding.add(widget.padding!);
    }

    super.initState();
  }

  /// Dynamically updates `stepRadius` and `_lineLength` based on screen size
  void _updateStepDimensions() {

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    setState(() {
      if(isMobile){
        stepRadius = 12; // TODO: Remove
      }else{
        stepRadius = 16;
      }
      _lineLength = (MediaQuery.of(context).size.width / (stepRadius * widget.steps.length)); // TODO: Remove
    });
  }

  @override
  void didUpdateWidget(EasyStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Verify that the active step falls within a valid range.
    if (widget.activeStep >= 0 && widget.activeStep < widget.steps.length) {
      _selectedIndex = widget.activeStep;
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  /// Controls the step scrolling.
  void _afterLayout(_) {
    for (int i = 0; i < widget.steps.length; i++) {
      _scrollController!.animateTo(
        i *
            ((stepRadius * 2) +
                _lineLength),
        duration: widget.stepAnimationDuration,
        curve: Curves.easeOut,
      );

      if (_selectedIndex == i) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Controls scrolling behavior.
    if (!widget.disableScroll) {
      WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    }

    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: Align(
        alignment: widget.alignment,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: widget.disableScroll
              ? widget.direction == Axis.horizontal
              ? FittedBox(
            fit: widget.fitWidth ? BoxFit.fitWidth : BoxFit.none,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildEasySteps(),
            ),
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildEasySteps(),
          )
              : ((kIsWeb ||
              io.Platform.isWindows ||
              io.Platform.isMacOS ||
              io.Platform.isLinux) &&
              widget.showScrollbar)
              ? Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              scrollDirection: widget.direction,
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              padding: _padding,
              child: widget.direction == Axis.horizontal
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildEasySteps(),
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildEasySteps(),
              ),
            ),
          )
              : SingleChildScrollView(
            scrollDirection: widget.direction,
            physics: const ClampingScrollPhysics(),
            controller: _scrollController,
            padding: _padding,
            child: widget.direction == Axis.horizontal
                ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildEasySteps(),
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildEasySteps(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEasySteps() {
    return List.generate(widget.steps.length, (index) {
      return widget.direction == Axis.horizontal
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildStep(index),
          if (index < widget.steps.length - 1) buildLine(index, Axis.horizontal),
        ],
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildStep(index),
          if (index < widget.steps.length - 1) buildLine(index, Axis.vertical),
        ],
      );
    });
  }

  BaseStep _buildStep(int index) {

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    final step = widget.steps[index];

    return BaseStep(
      totalLength: widget.steps.length,
      stepRadius: isMobile ? spacer3 : spacer4,
      step: step,
      activeIndex: widget.activeStep,
      index: index,
      enabled: true,  // we don't want's to disable the step
      radius: isMobile ? spacer6 : spacer8,
      showScrollBar: widget.showScrollbar,
      isActive: index == widget.activeStep,
      isFinished: index < widget.activeStep,
      isUnreached: index > widget.activeStep,
      textDirection: widget.textDirection,
      lineLength: _lineLength,
      direction: widget.direction,
      onStepSelected: widget.enableStepTapping
          ? () {
        if (index < _selectedIndex) {
          setState(() {
            _selectedIndex = index;
            step.onStepTap?.call();
          });
        }
      }
          : null,
    );
  }

  Color _getLineColor(int index) {

    final theme = Theme.of(context);

    Color? preferredColor;
    if (index == widget.activeStep) {
      //Active Step
      preferredColor = theme.colorTheme.primary.primary1;
    } else if (index > widget.activeStep) {
      //Unreached Step
      preferredColor = theme.colorTheme.text.disabled;
    } else if (index < widget.activeStep) {
      //Finished Step
      preferredColor = theme.colorTheme.primary.primary1;
    }

    return preferredColor ??
        Theme.of(context).colorScheme.primary;
  }

  double _getLineThickness(int index) {

    final theme = Theme.of(context);

    double? thickness;
    if (index == widget.activeStep) {
      //Active Step
      thickness = 4;
    } else if (index > widget.activeStep) {
      //Unreached Step
      thickness =2;
    } else if (index < widget.activeStep) {
      //Finished Step
      thickness = 4;
    }

    return thickness ?? 4;
  }

  Widget buildLine(int index, Axis axis) {
    return index < widget.steps.length - 1
        ? Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: axis == Axis.horizontal
                ? (stepRadius - (index> widget.activeStep ? 0 : 1))
                : 0,
            bottom: axis == Axis.vertical ? 10 : 0,
          ),
          child: index == widget.activeStep
              ? _buildProgressLine(index, axis)
              : _buildBaseLine(index, axis),
        ),
      ],
    )
        : const Offstage();
  }

  Stack _buildProgressLine(int index, Axis axis) {
    return Stack(
      children: [
        _buildBaseLine(index, axis),
        PositionedDirectional(
          start: 0,
          top: 0,
          bottom: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: _getLineThickness(index),
            width: _lineLength,
            child: EasyLine(
              length: _lineLength,
              color: _getLineColor(index),
              thickness: _getLineThickness(index),
              spacing: 0,
              axis: axis,
            ),
          ),
        ),
      ],
    );
  }

  EasyLine _buildBaseLine(int index, Axis axis) {
    return EasyLine(
      length: _lineLength,
      color: _getLineColor(index),
      thickness: _getLineThickness(index),
      spacing: 0,
      width: _getLineThickness(index),
      axis: axis,
    );
  }
}

class EasyLine extends StatelessWidget {
  /// Width of the dotted line.
  final double length;

  /// Width of the dashes.
  final double width;

  /// Color of the dotted line.
  final Color color;

  /// Radius of each dot in the dotted line.
  final double thickness;

  /// Spacing between the dots in the dotted line.
  final double spacing;

  /// Line Axis.
  final Axis axis;

  const EasyLine({
    key,
    this.length = 50.0,
    this.color = Colors.grey,
    this.thickness = 3,
    this.spacing = 3.0,
    this.width = 2.0,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // If this is not applied, top half of the dot gets offscreen, hence, hidden.
      margin: const EdgeInsets.only(
          top: 0),
      width: axis == Axis.horizontal
          ? length
          : thickness,
      height: axis == Axis.vertical
          ? length
          : thickness,
      decoration:BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: List.generate(
          length ~/ ((width + spacing) / 2),
              (index) => Expanded(
            child: index % 2 == 0
                ? Container(
              color: color,
              height: thickness,
              width: width,
            )
                : SizedBox(
              width: spacing,
              height: thickness,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
