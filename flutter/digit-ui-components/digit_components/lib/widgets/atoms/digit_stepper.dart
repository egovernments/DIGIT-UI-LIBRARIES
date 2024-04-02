import 'package:digit_flutter_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../../constants/AppView.dart';

import 'package:flutter/material.dart';

class AnotherStepper extends StatefulWidget {
  /// Another stepper is a package, which helps build
  /// customizable and easy to manage steppers.
  ///
  /// The package and be used to build horizontal as well
  /// as vertical steppers just by providing [Axis] in the [gap] parameter.
  const AnotherStepper({
    Key? key,
    required this.stepperList,
    this.gap = 40,
    this.activeIndex = 0,
    this.stepperDirection = Axis.horizontal,
    this.inverted = false,
    this.activeBarColor,
    this.inActiveBarColor,
    this.barThickness = 2,
    this.dotWidget,
    this.titleTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.subtitleTextStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
    this.scrollPhysics,
  }) : super(key: key);

  /// Stepper [List] of type [StepperData] to inflate stepper with data
  final List<StepperData> stepperList;

  /// Gap between the items in the vertical stepper, Default = 40
  /// Recommended to keep it greater than 20.
  final double gap;

  /// Active index, till which [index] the stepper will be highlighted
  final int activeIndex;

  /// Stepper direction takes [Axis]
  /// Use [Axis.horizontal] to get horizontal stepper
  /// /// Use [Axis.vertical] to get vertical stepper
  final Axis stepperDirection;

  /// Inverts the stepper with text that is being used
  final bool inverted;

  /// Bar color for active step
  final Color? activeBarColor;

  /// Bar color for inactive step
  final Color? inActiveBarColor;

  /// Bar width/thickness/height
  final double barThickness;

  /// [Widget] for dot/point
  final Widget? dotWidget;

  /// [TextStyle] for title
  final TextStyle titleTextStyle;

  /// [TextStyle] for subtitle
  final TextStyle subtitleTextStyle;

  /// Scroll physics for listview
  final ScrollPhysics? scrollPhysics;

  @override
  _AnotherStepperState createState() => _AnotherStepperState();
}

class _AnotherStepperState extends State<AnotherStepper> {
  late ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController = ScrollController();
  // }

  @override
  void didUpdateWidget(covariant AnotherStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToActiveIndex();
  }

  void _scrollToActiveIndex() {
    if (widget.activeIndex >= 0 &&
        widget.activeIndex < widget.stepperList.length) {
      double offset =
          widget.activeIndex * MediaQuery.of(context).size.width / 16;
      _lastScrollOffset = offset; // Store the current scroll offset
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    _scrollController =
        ScrollController(initialScrollOffset: _lastScrollOffset);

    var caa = widget.stepperDirection == Axis.horizontal
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    if (widget.inverted) {
      // invert Alignment
      caa = caa == CrossAxisAlignment.end
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end;
    }

    return SizedBox(
      // Add a container to provide size constraints
      width: MediaQuery.of(context).size.width, // Set explicit width
      height: MediaQuery.of(context).size.height, // Set explicit height
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: widget.stepperDirection,
        physics: widget.scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
        itemCount: widget.stepperList.length,
        itemBuilder: (context, index) {
          return _getPreferredStepper(context, index);
        },
      ),
    );
  }

  Widget _getPreferredStepper(BuildContext context, int index) {
    return HorizontalStepperItem(
      index: index,
      item: widget.stepperList[index],
      totalLength: widget.stepperList.length,
      activeIndex: widget.activeIndex,
      isInverted: widget.inverted,
      inActiveBarColor:
          widget.inActiveBarColor ?? Theme.of(context).disabledColor,
      activeBarColor:
          widget.inActiveBarColor ?? Theme.of(context).colorScheme.primary,
      barHeight: widget.barThickness,
      dotWidget: widget.dotWidget,
      titleTextStyle: widget.titleTextStyle,
      subtitleTextStyle: widget.subtitleTextStyle,
    );
  }
}

class HorizontalStepperItem extends StatefulWidget {
  const HorizontalStepperItem({
    Key? key,
    required this.item,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    required this.isInverted,
    required this.activeBarColor,
    required this.inActiveBarColor,
    required this.barHeight,
    required this.dotWidget,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
  }) : super(key: key);

  final StepperData item;
  final int index;
  final int totalLength;
  final int activeIndex;
  final bool isInverted;
  final Color activeBarColor;
  final Color inActiveBarColor;
  final double barHeight;
  final Widget? dotWidget;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  @override
  _HorizontalStepperItemState createState() => _HorizontalStepperItemState();
}

class _HorizontalStepperItemState extends State<HorizontalStepperItem> {
  bool isHovered = false;

  List<Widget> getChildren(DigitTypography currentTypography, bool isHover) {
    final Widget dot = StepperDot(
      isHover: isHover,
      index: widget.index,
      totalLength: widget.totalLength,
      activeIndex: widget.activeIndex,
    );
    return [
      if (widget.item.title != null) ...[
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.item.title!,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: widget.index == widget.activeIndex || isHover
                ? currentTypography.headingS.copyWith(
                    color: const DigitColors().lightTextPrimary, height: 1.172)
                : currentTypography.bodyS.copyWith(
                    color: const DigitColors().lightTextPrimary, height: 1.5),
          ),
        )),
        const SizedBox(height: 8),
      ],
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 20,
              ),
              color: widget.index == 0
                  ? Colors.transparent
                  : (widget.index <= widget.activeIndex
                      ? const DigitColors().lightPrimaryOrange
                      : const DigitColors().lightTextDisabled),
              height: 4,
            ),
          ),
          widget.index <= widget.activeIndex
              ? dot
              : ColorFiltered(
                  colorFilter: getGreyScaleColorFilter(),
                  child: dot,
                ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 20,
              ),
              color: widget.index == widget.totalLength - 1
                  ? Colors.transparent
                  : (widget.index < widget.activeIndex
                      ? const DigitColors().lightPrimaryOrange
                      : const DigitColors().lightTextDisabled),
              height: 4,
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> getInvertedChildren(
      DigitTypography currentTypography, bool isHover) {
    return getChildren(currentTypography, isHover).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context);
    bool isHover = false;
    return StatefulBuilder(builder: (context, setState) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 100,
        ),
        child: InkWell(
          onHover: (hover) {
            setState(() {
              isHover = hover;
            });
          },
          onTap: widget.item.onStepTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: widget.isInverted
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: widget.isInverted
                ? getInvertedChildren(currentTypography, isHover)
                : getChildren(currentTypography, isHover),
          ),
        ),
      );
    });
  }
}

class StepperData {
  final String? title;
  final Function()? onStepTap;

  const StepperData({
    this.title,
    this.onStepTap,
  });
}

ColorFilter getGreyScaleColorFilter() {
  ColorFilter greyscale = const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  return greyscale;
}

class StepperDot extends StatelessWidget {
  /// Default stepper dot
  const StepperDot({
    Key? key,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    this.isHover = false,
  }) : super(key: key);

  /// Index at which the item is present
  final int index;

  /// Total length of the list provided
  final int totalLength;

  /// Active index which needs to be highlighted and before that
  final int activeIndex;

  final bool isHover;

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);
    return index == activeIndex
        ? Container(
            height: isMobile ? 24 : 32,
            width: isMobile ? 24 : 32,
            decoration: BoxDecoration(
              color: const DigitColors().lightPrimaryOrange,
              border: Border.all(
                color: const DigitColors().lightPrimaryOrange,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: isHover
                  ? [
                      BoxShadow(
                        color: const DigitColors()
                            .lightPrimaryOrange
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
                style: currentTypography.headingS
                    .copyWith(color: const DigitColors().lightPaperPrimary),
              ),
            ),
          )
        : index < activeIndex
            ? Container(
                height: isMobile ? 24 : 32,
                width: isMobile ? 24 : 32,
                decoration: BoxDecoration(
                  color: const DigitColors().lightPrimaryOrange,
                  border: Border.all(
                    color: const DigitColors().lightPrimaryOrange,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: const DigitColors()
                                .lightPrimaryOrange
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
                  size: isMobile ? 18 : 24,
                  color: const DigitColors().lightPaperPrimary,
                ),
              )
            : Container(
                height: isMobile ? 24 : 32,
                width: isMobile ? 24 : 32,
                decoration: BoxDecoration(
                  color: const DigitColors().lightTextDisabled,
                  border: Border.all(
                    color: const DigitColors().lightTextDisabled,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: const DigitColors()
                                .lightPrimaryOrange
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
                    style: currentTypography.bodyS
                        .copyWith(color: const DigitColors().lightPaperPrimary),
                  ),
                ),
              );
  }
}
