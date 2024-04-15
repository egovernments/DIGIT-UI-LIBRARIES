import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';


/// The axis used on the [TimelineTile].
enum TimelineAxis {
  /// Renders the tile in the [vertical] axis.
  vertical,

  /// Renders the tile in the [horizontal] axis.
  horizontal,
}

/// The alignment used on the [TimelineTile].
enum TimelineAlign {
  /// Automatically align the line to the start according to [TimelineAxis],
  /// only the ([TimelineTile.rightChild]) will be available.
  start,

  /// Automatically align the line to the end according to [TimelineAxis],
  /// only the ([TimelineTile.leftChild]) will be available.
  end,

  /// Automatically align the line to the center, both ([TimelineTile.leftChild])
  /// and ([TimelineTile.rightChild]) will be available.
  center,

  /// Indicates that the line will be aligned manually and must be used with ([TimelineTile.lineX]),
  /// both ([TimelineTile.leftChild]) and ([TimelineTile.rightChild]) will be available
  /// depending on the free space.
  manual,
}

/// A tile that renders a timeline format.
class DigitStepper extends StatelessWidget {
  const DigitStepper({
    Key? key,
    this.axis = TimelineAxis.vertical,
    this.alignment = TimelineAlign.start,
    this.startChild,
    this.endChild,
    this.lineXY,
    this.hasIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    this.indicatorStyle = const IndicatorStyle(width: 25),
    this.beforeLineStyle = const LineStyle(),
    LineStyle? afterLineStyle,
  })  : afterLineStyle = afterLineStyle ?? beforeLineStyle,
        assert(alignment != TimelineAlign.start || startChild == null,
        'Cannot provide startChild with automatic alignment to the left'),
        assert(alignment != TimelineAlign.end || endChild == null,
        'Cannot provide endChild with automatic alignment to the right'),
        assert(
        alignment != TimelineAlign.manual ||
            (lineXY != null && lineXY >= 0.0 && lineXY <= 1.0),
        'The lineX must be provided when aligning manually, '
            'and must be a value between 0.0 and 1.0 inclusive'),
        super(key: key);

  /// The axis used on the tile. See [TimelineAxis].
  /// It defaults to [TimelineAxis.vertical]
  final TimelineAxis axis;

  /// The alignment used on the line. See [TimelineAlign].
  /// It defaults to [TimelineAlign.start]
  final TimelineAlign alignment;

  /// The child widget positioned at the start
  final Widget? startChild;

  /// The child widget positioned at the end
  final Widget? endChild;

  /// The X (in case of [TimelineAxis.vertical]) or Y (in case of [TimelineAxis.horizontal])
  /// axis value used to position the line when [TimelineAlign.manual].
  /// Must be a value from 0.0 to 1.0
  final double? lineXY;

  /// Whether it should have an indicator (default or custom).
  /// It defaults to true.
  final bool hasIndicator;

  /// Whether this is the first tile from the timeline.
  /// In this case, it won't be rendered a line before the indicator.
  final bool isFirst;

  /// Whether this is the last tile from the timeline.
  /// In this case, it won't be rendered a line after the indicator.
  final bool isLast;

  /// The style used to customize the indicator.
  final IndicatorStyle indicatorStyle;

  /// The style used to customize the line rendered before the indicator.
  final LineStyle beforeLineStyle;

  /// The style used to customize the line rendered after the indicator.
  /// If null, it defaults to [beforeLineStyle].
  final LineStyle afterLineStyle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double startCrossAxisSpace = 0;
        double endCrossAxisSpace = 0;
        if (axis == TimelineAxis.vertical) {
          startCrossAxisSpace = indicatorStyle.padding.left;
          endCrossAxisSpace = indicatorStyle.padding.right;
        } else {
          startCrossAxisSpace = indicatorStyle.padding.top;
          endCrossAxisSpace = indicatorStyle.padding.bottom;
        }

        final children = <Widget>[
          if (startCrossAxisSpace > 0)
            SizedBox(
              height:
              axis == TimelineAxis.vertical ? null : startCrossAxisSpace,
              width: axis == TimelineAxis.vertical ? startCrossAxisSpace : null,
            ),
          _Indicator(
            axis: axis,
            beforeLineStyle: beforeLineStyle,
            afterLineStyle: afterLineStyle,
            indicatorStyle: indicatorStyle,
            hasIndicator: hasIndicator,
            isLast: isLast,
            isFirst: isFirst,
          ),
          if (endCrossAxisSpace > 0)
            SizedBox(
              height: axis == TimelineAxis.vertical ? null : endCrossAxisSpace,
              width: axis == TimelineAxis.vertical ? endCrossAxisSpace : null,
            ),
        ];

        final defaultChild = axis == TimelineAxis.vertical
            ? Container(height: 100)
            : Container(width: 100);
        if (alignment == TimelineAlign.start) {
          children.add(Expanded(child: endChild ?? defaultChild));
        } else if (alignment == TimelineAlign.end) {
          children.insert(0, Expanded(child: startChild ?? defaultChild));
        } else {
          final indicatorAxisXY =
          alignment == TimelineAlign.center ? 0.5 : lineXY!;
          final indicatorTotalSize = _indicatorTotalSize();

          final positioning = calculateAxisPositioning(
            totalSize: axis == TimelineAxis.vertical
                ? constraints.maxWidth
                : constraints.maxHeight,
            objectSize: indicatorTotalSize,
            axisPosition: indicatorAxisXY,
          );

          if (positioning.firstSpace.size > 0) {
            children.insert(
              0,
              SizedBox(
                height: axis == TimelineAxis.horizontal
                    ? positioning.firstSpace.size
                    : null,
                width: axis == TimelineAxis.vertical
                    ? positioning.firstSpace.size
                    : null,
                child: startChild ?? defaultChild,
              ),
            );
          }

          if (positioning.secondSpace.size > 0) {
            children.add(
              SizedBox(
                height: axis == TimelineAxis.horizontal
                    ? positioning.secondSpace.size
                    : null,
                width: axis == TimelineAxis.vertical
                    ? positioning.secondSpace.size
                    : null,
                child: endChild ?? defaultChild,
              ),
            );
          }
        }

        return axis == TimelineAxis.vertical
            ? IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        )
            : IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        );
      },
    );
  }

  double _indicatorTotalSize() {
    if (axis == TimelineAxis.vertical) {
      return indicatorStyle.padding.left +
          indicatorStyle.padding.right +
          (hasIndicator
              ? indicatorStyle.width
              : max(beforeLineStyle.thickness, afterLineStyle.thickness));
    }

    return indicatorStyle.padding.top +
        indicatorStyle.padding.bottom +
        (hasIndicator
            ? indicatorStyle.height
            : max(beforeLineStyle.thickness, afterLineStyle.thickness));
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.axis,
    required this.beforeLineStyle,
    required this.afterLineStyle,
    required this.indicatorStyle,
    required this.hasIndicator,
    required this.isFirst,
    required this.isLast,
  });

  /// See [TimelineTile.axis]
  final TimelineAxis axis;

  /// See [TimelineTile.beforeLineStyle]
  final LineStyle beforeLineStyle;

  /// See [TimelineTile.afterLineStyle]
  final LineStyle afterLineStyle;

  /// See [TimelineTile.indicatorStyle]
  final IndicatorStyle indicatorStyle;

  /// See [TimelineTile.hasIndicator]
  final bool hasIndicator;

  /// See [TimelineTile.isFirst]
  final bool isFirst;

  /// See [TimelineTile.isLast]
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    double size;
    if (axis == TimelineAxis.vertical) {
      size = hasIndicator
          ? indicatorStyle.width
          : max(beforeLineStyle.thickness, afterLineStyle.thickness);
    } else {
      size = hasIndicator
          ? indicatorStyle.height
          : max(beforeLineStyle.thickness, afterLineStyle.thickness);
    }

    final childrenStack = <Widget>[
      SizedBox(
        height: axis == TimelineAxis.vertical ? double.infinity : size,
        width: axis == TimelineAxis.vertical ? size : double.infinity,
      )
    ];

    final renderDefaultIndicator =
        hasIndicator && indicatorStyle.indicator == null;
    if (!renderDefaultIndicator) {
      childrenStack.add(
        _buildCustomIndicator(),
      );
    }

    final painter = _TimelinePainter(
      axis: axis,
      beforeLineStyle: beforeLineStyle,
      afterLineStyle: afterLineStyle,
      indicatorStyle: indicatorStyle,
      paintIndicator: renderDefaultIndicator,
      isFirst: isFirst,
      isLast: isLast,
    );

    return CustomPaint(
      painter: painter,
      child: Stack(
        children: childrenStack,
      ),
    );
  }

  Widget _buildCustomIndicator() {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          AxisPosition position;
          EdgeInsets spaceChildren;
          EdgeInsets spacePadding;
          if (axis == TimelineAxis.vertical) {
            position = calculateAxisPositioning(
              totalSize: constraints.maxHeight,
              objectSize: indicatorStyle.totalHeight,
              axisPosition: indicatorStyle.indicatorXY,
            );
            spaceChildren = EdgeInsets.only(
              top: position.firstSpace.size,
              bottom: position.secondSpace.size,
            );
            spacePadding = EdgeInsets.only(
              top: indicatorStyle.padding.top,
              bottom: indicatorStyle.padding.bottom,
            );
          } else {
            position = calculateAxisPositioning(
              totalSize: constraints.maxWidth,
              objectSize: indicatorStyle.totalWidth,
              axisPosition: indicatorStyle.indicatorXY,
            );
            spaceChildren = EdgeInsets.only(
              left: position.firstSpace.size,
              right: position.secondSpace.size,
            );
            spacePadding = EdgeInsets.only(
              left: indicatorStyle.padding.left,
              right: indicatorStyle.padding.right,
            );
          }

          return Padding(
            padding: spaceChildren,
            child: Padding(
              padding: spacePadding,
              child: SizedBox(
                height: indicatorStyle.height,
                width: indicatorStyle.width,
                child: indicatorStyle.indicator,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A custom painter that renders a line and an indicator
class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    required this.axis,
    this.paintIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    required IndicatorStyle indicatorStyle,
    required LineStyle beforeLineStyle,
    required LineStyle afterLineStyle,
  })   : beforeLinePaint = Paint()
    ..color = beforeLineStyle.color
    ..strokeWidth = beforeLineStyle.thickness,
        afterLinePaint = Paint()
          ..color = afterLineStyle.color
          ..strokeWidth = afterLineStyle.thickness,
        indicatorPaint =
        !paintIndicator ? null : (Paint()..color = indicatorStyle.color),
        indicatorXY = indicatorStyle.indicatorXY,
        indicatorSize = axis == TimelineAxis.vertical
            ? (paintIndicator
            ? indicatorStyle.width
            : (indicatorStyle.indicator != null
            ? indicatorStyle.height
            : 0))
            : (paintIndicator
            ? indicatorStyle.height
            : (indicatorStyle.indicator != null
            ? indicatorStyle.width
            : 0)),
        indicatorStartGap = axis == TimelineAxis.vertical
            ? indicatorStyle.padding.top
            : indicatorStyle.padding.left,
        indicatorEndGap = axis == TimelineAxis.vertical
            ? indicatorStyle.padding.bottom
            : indicatorStyle.padding.right,
        drawGap = indicatorStyle.drawGap,
        iconData = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle?.iconData
            : null,
        iconColor = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle?.color
            : null,
        iconSize = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle?.fontSize
            : null;

  /// The axis used to render the line at the [TimelineAxis.vertical]
  /// or [TimelineAxis.horizontal].
  final TimelineAxis axis;

  /// Value from 0.0 to 1.0 indicating the percentage in which the indicator
  /// should be positioned on the line, either on Y if [TimelineAxis.vertical]
  /// or X if [TimelineAxis.horizontal].
  /// For example, 0.2 means 20% from start to end. It defaults to 0.5.
  final double indicatorXY;

  /// A gap/space between the line and the indicator
  final double indicatorStartGap;

  /// A gap/space between the line and the indicator
  final double indicatorEndGap;

  /// The size from the indicator. If it is the default indicator, the height
  /// will be equal to the width (when axis vertical), or the width will be
  /// equal to the height (when axis horizontal), which is the equivalent of the
  /// diameter of the circumference.
  final double indicatorSize;

  /// Used to paint the top line
  final Paint beforeLinePaint;

  /// Used to paint the bottom line
  final Paint afterLinePaint;

  /// Used to paint the indicator
  final Paint? indicatorPaint;

  /// Whether it should paint a default indicator. It defaults to true.
  final bool paintIndicator;

  /// Whether this paint should start the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isFirst;

  /// Whether this paint should end the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isLast;

  /// If there must be a gap between the lines. The gap size will always be the
  /// [indicatorSize] + [indicatorStartGap] + [indicatorEndGap].
  final bool drawGap;

  /// The icon rendered with the default indicator.
  final IconData? iconData;

  /// The icon color.
  final Color? iconColor;

  /// The icon size. If not provided, the size will be adjusted according to [indicatorRadius].
  final double? iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final hasGap = indicatorStartGap > 0 || indicatorEndGap > 0 || drawGap;

    final centerAxis =
    axis == TimelineAxis.vertical ? size.width / 2 : size.height / 2;
    final indicatorTotalSize =
        indicatorSize + indicatorEndGap + indicatorStartGap;
    final position = calculateAxisPositioning(
      totalSize: axis == TimelineAxis.vertical ? size.height : size.width,
      objectSize: indicatorTotalSize,
      axisPosition: indicatorXY,
    );

    if (!hasGap) {
      _drawSingleLine(canvas, centerAxis, position);
    } else {
      if (!isFirst) {
        _drawBeforeLine(canvas, centerAxis, position);
      }
      if (!isLast) {
        _drawAfterLine(canvas, centerAxis, position);
      }
    }

    if (paintIndicator) {
      final indicatorRadius =
          (position.objectSpace.size - indicatorStartGap - indicatorEndGap) / 2;
      final indicatorCenterPoint =
          position.objectSpace.start + indicatorStartGap + indicatorRadius;

      final indicatorCenter = axis == TimelineAxis.vertical
          ? Offset(centerAxis, indicatorCenterPoint)
          : Offset(indicatorCenterPoint, centerAxis);
      canvas.drawCircle(indicatorCenter, indicatorRadius, indicatorPaint!);

      if (iconData != null) {
        var fontSize = iconSize;
        fontSize ??= (indicatorRadius * 2) - 10;

        final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          fontFamily: iconData!.fontFamily,
        ));
        builder.pushStyle(ui.TextStyle(
          fontSize: fontSize,
          color: iconColor,
        ));
        builder.addText(String.fromCharCode(iconData!.codePoint));

        final paragraph = builder.build();
        paragraph.layout(const ui.ParagraphConstraints(width: 0.0));

        final halfIconSize = fontSize / 2;
        final offsetIcon = Offset(indicatorCenter.dx - halfIconSize,
            indicatorCenter.dy - halfIconSize);
        canvas.drawParagraph(paragraph, offsetIcon);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawSingleLine(
      Canvas canvas, double centerAxis, AxisPosition position) {
    if (!isFirst) {
      final beginTopLine = axis == TimelineAxis.vertical
          ? Offset(centerAxis, 0)
          : Offset(0, centerAxis);
      final endTopLine = axis == TimelineAxis.vertical
          ? Offset(
        centerAxis,
        paintIndicator || !drawGap
            ? position.objectSpace.center
            : position.firstSpace.end,
      )
          : Offset(
        paintIndicator || !drawGap
            ? position.objectSpace.center
            : position.firstSpace.end,
        centerAxis,
      );
      canvas.drawLine(beginTopLine, endTopLine, beforeLinePaint);
    }

    if (!isLast) {
      final beginBottomLine = axis == TimelineAxis.vertical
          ? Offset(
        centerAxis,
        paintIndicator || !drawGap
            ? position.objectSpace.center
            : position.objectSpace.end,
      )
          : Offset(
        paintIndicator || !drawGap
            ? position.objectSpace.center
            : position.objectSpace.end,
        centerAxis,
      );
      final endBottomLine = axis == TimelineAxis.vertical
          ? Offset(centerAxis, position.secondSpace.end)
          : Offset(position.secondSpace.end, centerAxis);
      canvas.drawLine(beginBottomLine, endBottomLine, afterLinePaint);
    }
  }

  void _drawBeforeLine(
      Canvas canvas, double centerAxis, AxisPosition position) {
    final beginTopLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, 0)
        : Offset(0, centerAxis);
    final endTopLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, position.firstSpace.end)
        : Offset(position.firstSpace.end, centerAxis);

    final lineSize =
    axis == TimelineAxis.vertical ? endTopLine.dy : endTopLine.dx;
    // if the line size is less or equal than 0, the line shouldn't be rendered
    if (lineSize > 0) {
      canvas.drawLine(beginTopLine, endTopLine, beforeLinePaint);
    }
  }

  void _drawAfterLine(Canvas canvas, double centerAxis, AxisPosition position) {
    final beginBottomLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, position.secondSpace.start)
        : Offset(position.secondSpace.start, centerAxis);
    final endBottomLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, position.secondSpace.end)
        : Offset(position.secondSpace.end, centerAxis);

    final lineSize = axis == TimelineAxis.vertical
        ? endBottomLine.dy - beginBottomLine.dy
        : endBottomLine.dx - beginBottomLine.dx;
    // if the line size is less or equal than 0, the line shouldn't be rendered
    if (lineSize > 0) {
      canvas.drawLine(beginBottomLine, endBottomLine, afterLinePaint);
    }
  }
}


/// This is a port from the original [Divider].
/// Except that this one allows to define the start and end
/// according to the width available, with percentage values
/// from 0.0 to 1.0
class TimelineDivider extends StatelessWidget {
  /// Creates a material design divider that can be used in conjunction to [TimelineTile].
  const TimelineDivider({
    Key? key,
    this.axis = TimelineAxis.horizontal,
    this.thickness = 2,
    this.begin = 0.0,
    this.end = 1.0,
    this.color = Colors.grey,
  })  : assert(thickness >= 0.0, 'The thickness must be a positive value'),
        assert(begin >= 0.0 && begin <= 1.0,
        'The begin value must be between 0.0 and 1.0'),
        assert(end >= 0.0 && end <= 1.0,
        'The end value must be between 0.0 and 1.0'),
        assert(end > begin, 'The end value must be bigger than the begin'),
        super(key: key);

  /// The axis used to render the line at the [TimelineAxis.vertical]
  /// or [TimelineAxis.horizontal]. Usually, the opposite axis from the tiles.
  /// It defaults to [TimelineAxis.horizontal].
  final TimelineAxis axis;

  /// The thickness of the line drawn within the divider.
  ///
  /// It must be a positive value. It defaults to 2.
  final double thickness;

  /// Where the line must start to be drawn.
  /// This represents a percentage from the available width.
  ///
  /// It must be less than [end] and defaults to 0.0.
  final double begin;

  /// Where the drawn from the line must end.
  /// This represents a percentage from the available width.
  ///
  /// It must be bigger than [begin] and defaults to 1.0.
  final double end;

  /// The color to use when painting the line.
  ///
  /// It defaults to [Colors.grey].
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double halfThickness = thickness / 2;

        EdgeInsetsDirectional margin;
        if (axis == TimelineAxis.horizontal) {
          final double width = constraints.maxWidth;
          final double beginX = width * begin;
          final double endX = width * end;

          margin = EdgeInsetsDirectional.only(
            start: beginX - halfThickness,
            end: width - endX - halfThickness,
          );
        } else {
          final double height = constraints.maxHeight;
          final double beginY = height * begin;
          final double endY = height * end;

          margin = EdgeInsetsDirectional.only(
            top: beginY - halfThickness,
            bottom: height - endY - halfThickness,
          );
        }

        return Container(
          height: thickness,
          margin: margin,
          decoration: BoxDecoration(
            border: Border(
              left: axis == TimelineAxis.vertical
                  ? BorderSide(
                color: color,
                width: thickness,
              )
                  : BorderSide.none,
              bottom: axis == TimelineAxis.horizontal
                  ? BorderSide(
                color: color,
                width: thickness,
              )
                  : BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}


/// Used to customize the indicator from the line.
class IndicatorStyle {
  const IndicatorStyle({
    this.width = 20,
    this.height = 20,
    this.indicator,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.grey,
    this.iconStyle,
    this.indicatorXY = 0.5,
    this.drawGap = false,
  })  : assert(width >= 0,
  'The width must be provided and bigger than 0.0'),
        assert(height >= 0,
        'The height must be provided and bigger than 0.0');

  /// The width from the indicator.
  /// It defaults to 20.
  /// Ignored in case the default indicator is rendered and the tile axis
  /// is [TimelineAxis.horizontal].
  final double width;

  /// The height from the indicator.
  /// It defaults to 20.
  /// Ignored in case the default indicator is rendered and the tile axis
  /// is [TimelineAxis.vertical].
  final double height;

  /// A custom widget to use as indicator. if not provided it will be rendered a
  /// default circle as indicator.
  final Widget? indicator;

  /// The padding used with the indicator. It defaults to 0.
  final EdgeInsets padding;

  /// The color used to paint the default indicator. It defaults to ([Colors.grey]).
  final Color color;

  /// The style of the icon used inside the default indicator, if any.
  /// It will only be used with the default indicator, and ignored in case there
  /// is a custom indicator provided.
  final IconStyle? iconStyle;

  /// Value from 0.0 to 1.0 indicating the percentage in which the indicator
  /// should be positioned on the line, either on Y if [TimelineAxis.vertical]
  /// or X if [TimelineAxis.horizontal].
  /// For example, 0.2 means 20% from start to end. It defaults to 0.5.
  final double indicatorXY;

  /// If the line must not be drawn behind the icon. If true, there will be a gap
  /// even if the vertical/horizontal padding is 0. It defaults to false.
  final bool drawGap;

  /// The total indicator height, including padding.
  double get totalHeight => height + padding.top + padding.bottom;

  /// The total indicator width, including padding.
  double get totalWidth => width + padding.left + padding.right;
}

/// Used to customize the icon used with the default indicator.
class IconStyle {
  IconStyle({
    required this.iconData,
    this.color = Colors.black,
    this.fontSize,
  });

  /// The icon to render.
  final IconData iconData;

  /// The color used to paint the icon. It defaults to ([Colors.black]).
  final Color color;

  /// The fontSize from the line. If not provided, it will try to adjust the
  /// icon size based on the default indicator size. According to ([IndicatorStyle.width]).
  final double? fontSize;
}

/// Used to customize the line
class LineStyle {
  const LineStyle({
    this.color = Colors.grey,
    this.thickness = 4,
  });

  /// The color used to paint the line. It defaults to ([Colors.grey]).
  final Color color;

  /// The thickness from the line. It can't be bigger than ([IndicatorStyle.width])
  /// and defaults to 4.
  final double thickness;
}


/// Given an axis that has an object positioned somewhere between the start and
/// end point, this represents the different sizes and coordinates of this axis.
@immutable
class AxisPosition {
  const AxisPosition({
    required this.firstSpace,
    required this.objectSpace,
    required this.secondSpace,
  });

  final AxisCoordinates firstSpace;
  final AxisCoordinates objectSpace;
  final AxisCoordinates secondSpace;

  double get totalSize => firstSpace.size + objectSpace.size + secondSpace.size;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AxisPosition &&
              runtimeType == other.runtimeType &&
              firstSpace == other.firstSpace &&
              objectSpace == other.objectSpace &&
              secondSpace == other.secondSpace;

  @override
  int get hashCode =>
      firstSpace.hashCode ^ objectSpace.hashCode ^ secondSpace.hashCode;

  @override
  String toString() {
    return 'AxisPosition{'
        'firstSpace: $firstSpace, '
        'objectSpace: $objectSpace, '
        'secondSpace: $secondSpace}';
  }
}

/// The coordinates to position an object into an axis.
@immutable
class AxisCoordinates {
  const AxisCoordinates({
    required this.start,
    required this.end,
  })  : size = end - start,
        assert(
        end >= start,
        'The end coordinate must be bigger or equals than the start coordinate',
        );

  factory AxisCoordinates.zero() {
    return const AxisCoordinates(start: 0, end: 0);
  }

  /// The position it starts
  final double start;

  /// The position it ends
  final double end;

  /// The sum of space between [start] and [end]
  final double size;

  double get center => start + (size / 2);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AxisCoordinates &&
              runtimeType == other.runtimeType &&
              start == other.start &&
              end == other.end &&
              size == other.size;

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ size.hashCode;

  @override
  String toString() {
    return 'AxisCoordinates{start: $start, end: $end, size: $size}';
  }
}

/// Given an axis (x or y) of [totalSize], this will calculate how to position
/// an object in the axis based on its [objectSize] and the [axisPosition].
/// If the object exceed the [totalSize] at the top or the bottom, it will
/// be aligned at the start or at the end with [_alignObject].
AxisPosition calculateAxisPositioning({
  required double totalSize,
  required double objectSize,
  required double axisPosition,
}) {
  if (axisPosition < 0.0 || axisPosition > 1.0) {
    throw AssertionError('The axisPosition must be provided and must be a value'
        ' between 0.0 and 1.0 inclusive');
  }

  if (objectSize >= totalSize)
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignEnd: true,
      alignStart: true,
    );

  final objectCenter = totalSize * axisPosition;
  final objectHalfSize = objectSize / 2;

  final firstSize = objectCenter - objectHalfSize;
  if (firstSize < 0)
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignStart: true,
    );

  final secondSize = totalSize - objectCenter - objectHalfSize;
  if (secondSize < 0)
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignEnd: true,
    );

  return AxisPosition(
    firstSpace: AxisCoordinates(start: 0, end: firstSize),
    objectSpace: AxisCoordinates(start: firstSize, end: firstSize + objectSize),
    secondSpace: AxisCoordinates(start: firstSize + objectSize, end: totalSize),
  );
}

AxisPosition _alignObject({
  required double totalSize,
  required double objectSize,
  bool alignStart = false,
  bool alignEnd = false,
}) {
  if (alignStart == false && alignEnd == false)
    throw AssertionError('Either alignTop or alignBottom must be true');

  if (alignStart && alignEnd)
    return AxisPosition(
      firstSpace: AxisCoordinates.zero(),
      objectSpace: AxisCoordinates(start: 0, end: totalSize),
      secondSpace: AxisCoordinates.zero(),
    );

  return AxisPosition(
    firstSpace: alignStart
        ? AxisCoordinates.zero()
        : AxisCoordinates(start: 0, end: totalSize - objectSize),
    objectSpace: alignStart
        ? AxisCoordinates(start: 0, end: objectSize)
        : AxisCoordinates(start: totalSize - objectSize, end: totalSize),
    secondSpace: alignEnd
        ? AxisCoordinates(start: totalSize, end: totalSize)
        : AxisCoordinates(start: objectSize, end: totalSize),
  );
}