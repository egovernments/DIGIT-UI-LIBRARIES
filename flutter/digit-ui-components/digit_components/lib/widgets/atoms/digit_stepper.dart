import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';

class DigitStepper extends StatefulWidget {
  /// Another stepper is a package, which helps build
  /// customizable and easy to manage steppers.
  ///
  /// The package and be used to build horizontal as well
  /// as vertical steppers just by providing [Axis] in the [gap] parameter.
  const DigitStepper({
    Key? key,
    required this.stepperList,
    this.activeIndex = 0,
    this.stepperDirection = Axis.horizontal,
    this.inverted = false,
  }) : super(key: key);

  /// Stepper [List] of type [StepperData] to inflate stepper with data
  final List<StepperData> stepperList;

  /// Active index, till which [index] the stepper will be highlighted
  final int activeIndex;

  /// Stepper direction takes [Axis]
  /// Use [Axis.horizontal] to get horizontal stepper
  /// /// Use [Axis.vertical] to get vertical stepper
  final Axis stepperDirection;

  /// Inverts the stepper with text that is being used
  final bool inverted;

  @override
  _AnotherStepperState createState() => _AnotherStepperState();
}

class _AnotherStepperState extends State<DigitStepper> {
  late ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController(initialScrollOffset: _lastScrollOffset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DigitStepper oldWidget) {
    _scrollToActiveIndex();
  }

  void _scrollToActiveIndex() {
    if (widget.activeIndex >= 0 &&
        widget.activeIndex < widget.stepperList.length) {
      double offset =
          widget.activeIndex * MediaQuery.of(context).size.width /widget.stepperList.length;
      _lastScrollOffset = offset; /// Store the current scroll offset
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    // _scrollController =
    // ScrollController(initialScrollOffset: _lastScrollOffset);

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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        scrollDirection: widget.stepperDirection,
        physics:const AlwaysScrollableScrollPhysics(),
        itemCount: widget.stepperList.length,
        itemBuilder: (context, index) {
          return _getPreferredStepper(context, index);
        },
      ),
    );
  }

  Widget _getPreferredStepper(BuildContext context, int index) {
    if (widget.stepperDirection == Axis.horizontal) {
      return HorizontalStepperItem(
        index: index,
        item: widget.stepperList[index],
        totalLength: widget.stepperList.length,
        activeIndex: widget.activeIndex,
        isInverted: widget.inverted,
      );
    } else {
      return VerticalStepperItem(
        index: index,
        item: widget.stepperList[index],
        totalLength: widget.stepperList.length,
        activeIndex: widget.activeIndex,
        isInverted: widget.inverted,
      );
    }
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
  }) : super(key: key);

  final StepperData item;
  final int index;
  final int totalLength;
  final int activeIndex;
  final bool isInverted;

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          constraints: const BoxConstraints(
            maxWidth: 200,
          ),
          child: Text(
            widget.item.title!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: widget.index == widget.activeIndex || isHover
                ? currentTypography.headingS.copyWith(
                    color: const DigitColors().light.textPrimary,
                  )
                : currentTypography.bodyS.copyWith(
                    color: const DigitColors().light.textPrimary,
                  ),
          ),
        ),
        const SizedBox(height: 8),
      ],
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 40,
            ),
            color: widget.index == 0
                ? Colors.transparent
                : (widget.index <= widget.activeIndex
                    ? const DigitColors().light.primary1
                    : const DigitColors().light.textDisabled),
            height: 4,
          ),
          dot,
          Container(
            constraints: const BoxConstraints(
              minWidth: 40,
            ),
            color: widget.index == widget.totalLength - 1
                ? Colors.transparent
                : (widget.index < widget.activeIndex
                    ? const DigitColors().light.primary1
                    : const DigitColors().light.textDisabled),
            height: 4,
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
    DigitTypography currentTypography = getTypography(context, false);
    bool isHover = false;
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            hoverColor: const DigitColors().transparent,
            splashColor: const DigitColors().transparent,
            highlightColor: const DigitColors().transparent,
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
        ],
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
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    return index == activeIndex
        ? Row(
            children: [
              Container(
                height: isMobile ? 24 : 32,
                width: isMobile ? 24 : 32,
                decoration: BoxDecoration(
                  color: const DigitColors().light.primary1,
                  border: Border.all(
                    color: const DigitColors().light.primary1,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: const DigitColors()
                                .light
                                .primary1
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
                    style: currentTypography.headingS.copyWith(
                        color: const DigitColors().light.paperPrimary),
                  ),
                ),
              ),
            ],
          )
        : index < activeIndex
            ? Container(
                height: isMobile ? 24 : 32,
                width: isMobile ? 24 : 32,
                decoration: BoxDecoration(
                  color: const DigitColors().light.primary1,
                  border: Border.all(
                    color: const DigitColors().light.primary1,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: const DigitColors()
                                .light
                                .primary1
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
                  color: const DigitColors().light.paperPrimary,
                ),
              )
            : Container(
                height: isMobile ? 24 : 32,
                width: isMobile ? 24 : 32,
                decoration: BoxDecoration(
                  color: const DigitColors().light.paperPrimary,
                  border: Border.all(
                    color: const DigitColors().light.textDisabled,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: const DigitColors()
                                .light
                                .primary1
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
                    style: currentTypography.bodyS.copyWith(
                        color: const DigitColors().light.textSecondary),
                  ),
                ),
              );
  }
}

class VerticalStepperItem extends StatefulWidget {
  /// Stepper Item to show vertical stepper
  const VerticalStepperItem({
    Key? key,
    required this.item,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    required this.isInverted,
  }) : super(key: key);

  /// Stepper item of type [StepperData] to inflate stepper with data
  final StepperData item;

  /// Index at which the item is present
  final int index;

  /// Total length of the list provided
  final int totalLength;

  /// Active index which needs to be highlighted and before that
  final int activeIndex;

  /// Inverts the stepper with text that is being used
  final bool isInverted;

  @override
  _VerticalStepperItemState createState() => _VerticalStepperItemState();
}

class _VerticalStepperItemState extends State<VerticalStepperItem> {
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
          child: Text(
            widget.item.title!,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: widget.index == widget.activeIndex || isHover
                ? currentTypography.headingS.copyWith(
                    height: 1.37,
                    color: const DigitColors().light.textPrimary,
                  )
                : currentTypography.bodyS.copyWith(
                    color: widget.index < widget.activeIndex
                        ? const DigitColors().light.textPrimary
                        : const DigitColors().light.textSecondary,
                  ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            color: widget.index == 0
                ? Colors.transparent
                : (widget.index <= widget.activeIndex
                    ? const DigitColors().light.primary1
                    : const DigitColors().light.textDisabled),
            width: widget.index <= widget.activeIndex ? 4 : 2,
          ),
          dot,
          Container(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            color: widget.index == widget.totalLength - 1
                ? Colors.transparent
                : (widget.index < widget.activeIndex
                    ? const DigitColors().light.primary1
                    : const DigitColors().light.textDisabled),
            width: widget.index < widget.activeIndex ? 4 : 2,
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
    DigitTypography currentTypography = getTypography(context, false);
    bool isHover = false;
    return StatefulBuilder(builder: (context, setState) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            hoverColor: const DigitColors().transparent,
            splashColor: const DigitColors().transparent,
            highlightColor: const DigitColors().transparent,
            onHover: (hover) {
              setState(() {
                isHover = hover;
              });
            },
            onTap: widget.item.onStepTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.isInverted
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: widget.isInverted
                  ? getInvertedChildren(currentTypography, isHover)
                  : getChildren(currentTypography, isHover),
            ),
          ),
        ],
      );
    });
  }
}
