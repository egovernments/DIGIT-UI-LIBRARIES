import 'package:flutter/material.dart';

class DigitTooltip extends StatelessWidget {
  final Widget child;
  final Widget tooltipContent;
  final ElTooltipPosition tooltipPosition;
  final double distance;
  final Radius radius;

  const DigitTooltip({super.key,
    required this.child,
    required this.tooltipContent,
    this.tooltipPosition = ElTooltipPosition.topCenter,
    this.distance = 8.0,
    this.radius = Radius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = ElementBox(
          w: constraints.maxWidth,
          h: constraints.maxHeight,
          x: 0,
          y: 0,
        );

        return Stack(
          children: [
            Positioned(
              child: child,
            ),
            Positioned(
              child: TooltipOverlay(
                content: tooltipContent,
                position: tooltipPosition,
                screenSize: screenSize,
                distance: distance,
                radius: radius,
              ),
            ),
          ],
        );
      },
    );
  }
}

class TooltipOverlay extends StatefulWidget {
  final Widget content;
  final ElTooltipPosition position;
  final ElementBox screenSize;
  final double distance;
  final Radius radius;

  TooltipOverlay({
    required this.content,
    required this.position,
    required this.screenSize,
    required this.distance,
    required this.radius,
  });

  @override
  _TooltipOverlayState createState() => _TooltipOverlayState();
}

class _TooltipOverlayState extends State<TooltipOverlay> {
  @override
  Widget build(BuildContext context) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return Container();
    }

    ElementBox triggerBox = ElementBox(
      w: renderBox.size.width,
      h: renderBox.size.height,
      x: renderBox.localToGlobal(Offset.zero).dx,
      y: renderBox.localToGlobal(Offset.zero).dy,
    );

    ElementBox arrowBox = ElementBox(
      w: 10.0,
      h: 5.0,
      x: 0,
      y: 0,
    );

    ElementBox overlayBox = ElementBox(
      w: widget.screenSize.w / 2,
      h: widget.screenSize.h / 3,
      x: 0,
      y: 0,
    );

    PositionManager positionManager = PositionManager(
      arrowBox: arrowBox,
      triggerBox: triggerBox,
      overlayBox: overlayBox,
      screenSize: widget.screenSize,
      distance: widget.distance,
      radius: widget.radius,
    );

    ToolTipElementsDisplay elementsDisplay =
    positionManager.display(widget.position);

    return Stack(
      children: [
        Positioned(
          left: elementsDisplay.bubble.x,
          top: elementsDisplay.bubble.y,
          child: Container(
            width: elementsDisplay.bubble.w,
            height: elementsDisplay.bubble.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: elementsDisplay.radius,
            ),
            child: widget.content,
          ),
        ),
        Positioned(
          left: elementsDisplay.arrow.x,
          top: elementsDisplay.arrow.y,
          child: CustomPaint(
            size: Size(arrowBox.w, arrowBox.h),
            painter: ArrowPainter(),
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

enum ElTooltipPosition {
  topStart,
  topCenter,
  topEnd,
  bottomStart,
  bottomCenter,
  bottomEnd,
  leftStart,
  leftCenter,
  leftEnd,
  rightStart,
  rightCenter,
  rightEnd,
}


class ElementBox {
  final double w;
  final double h;
  final double x;
  final double y;

  ElementBox({
    required this.w,
    required this.h,
    required this.x,
    required this.y,
  });
}

class ToolTipElementsDisplay {
  final ElementBox arrow;
  final ElementBox bubble;
  final ElTooltipPosition position;
  final BorderRadius radius;

  ToolTipElementsDisplay({
    required this.arrow,
    required this.bubble,
    required this.position,
    required this.radius,
  });
}


/// Calculates the position of the tooltip and the arrow on the screen
/// Verifies if the desired position fits the screen.
/// If it doesn't the position changes automatically.
class PositionManager {
  /// [arrowBox] width, height, position x and y of the arrow.
  final ElementBox arrowBox;

  /// [triggerBox] width, height, position x and y of the trigger.
  final ElementBox triggerBox;

  /// [overlayBox] width, height, position x and y of the overlay.
  final ElementBox overlayBox;

  /// [screenSize] width and height of the current screen.
  final ElementBox screenSize;

  /// [distance] between the tooltip and the trigger button.
  final double distance;

  /// [radius] border radius amount of the tooltip.
  final Radius radius;

  PositionManager({
    required this.arrowBox,
    required this.triggerBox,
    required this.overlayBox,
    required this.screenSize,
    this.distance = 0.0,
    this.radius = Radius.zero,
  });

  ToolTipElementsDisplay _topStart() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: (triggerBox.x + _half(triggerBox.w)).floorToDouble(),
        y: (triggerBox.y - distance - arrowBox.h).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x + _half(triggerBox.w),
        y: triggerBox.y - overlayBox.h - distance - arrowBox.h,
      ),
      position: ElTooltipPosition.topStart,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: Radius.zero,
        bottomRight: radius,
      ),
    );
  }

  ToolTipElementsDisplay _topCenter() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: (triggerBox.x + _half(triggerBox.w) - _half(arrowBox.w))
            .floorToDouble(),
        y: (triggerBox.y - distance - arrowBox.h).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x + _half(triggerBox.w) - _half(overlayBox.w),
        y: triggerBox.y - overlayBox.h - distance - arrowBox.h,
      ),
      position: ElTooltipPosition.topCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _topEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: (triggerBox.x + _half(triggerBox.w) - arrowBox.w).floorToDouble(),
        y: (triggerBox.y - distance - arrowBox.h).floorToDouble(),
      ),
      bubble: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: triggerBox.x - overlayBox.w + _half(triggerBox.w),
        y: triggerBox.y - overlayBox.h - distance - arrowBox.h,
      ),
      position: ElTooltipPosition.topEnd,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: Radius.zero,
      ),
    );
  }

  ToolTipElementsDisplay _bottomStart() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + _half(triggerBox.w)).ceilToDouble(),
        y: (triggerBox.y + triggerBox.h + distance).ceilToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x + _half(triggerBox.w),
        y: triggerBox.y + triggerBox.h + distance + arrowBox.h,
      ),
      position: ElTooltipPosition.bottomStart,
      radius: BorderRadius.only(
        topLeft: Radius.zero,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
    );
  }

  ToolTipElementsDisplay _bottomCenter() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: (triggerBox.x + _half(triggerBox.w) - _half(arrowBox.w))
            .ceilToDouble(),
        y: (triggerBox.y + triggerBox.h + distance).ceilToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x + _half(triggerBox.w) - _half(overlayBox.w),
        y: triggerBox.y + triggerBox.h + distance + arrowBox.h,
      ),
      position: ElTooltipPosition.bottomCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _bottomEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + _half(triggerBox.w) - arrowBox.w),
        y: (triggerBox.y + triggerBox.h + distance).ceilToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x + _half(triggerBox.w) - overlayBox.w,
        y: triggerBox.y + triggerBox.h + distance + arrowBox.h,
      ),
      position: ElTooltipPosition.bottomEnd,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: Radius.zero,
        bottomLeft: radius,
        bottomRight: radius,
      ),
    );
  }

  ToolTipElementsDisplay _leftStart() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x - overlayBox.x - distance - arrowBox.h)
            .floorToDouble(),
        y: triggerBox.y + _half(triggerBox.h),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x - overlayBox.x - overlayBox.w - distance - arrowBox.h,
        y: triggerBox.y + _half(triggerBox.h),
      ),
      position: ElTooltipPosition.leftStart,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: Radius.zero,
        bottomLeft: radius,
        bottomRight: radius,
      ),
    );
  }

  ToolTipElementsDisplay _leftCenter() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x - overlayBox.x - distance - arrowBox.h)
            .floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h) - _half(arrowBox.w))
            .floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x - overlayBox.x - overlayBox.w - distance - arrowBox.h,
        y: triggerBox.y + _half(triggerBox.h) - _half(overlayBox.h),
      ),
      position: ElTooltipPosition.leftCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _leftEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x - overlayBox.x - distance - arrowBox.h)
            .floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h) - arrowBox.w).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x - overlayBox.x - overlayBox.w - distance - arrowBox.h,
        y: triggerBox.y + _half(triggerBox.h) - overlayBox.h,
      ),
      position: ElTooltipPosition.leftEnd,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: Radius.zero,
      ),
    );
  }

  ToolTipElementsDisplay _rightStart() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance).floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h)).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance + arrowBox.h)
            .floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h)).floorToDouble(),
      ),
      position: ElTooltipPosition.rightStart,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: Radius.zero,
        bottomRight: radius,
      ),
    );
  }

  ToolTipElementsDisplay _rightCenter() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance).floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h) - _half(arrowBox.w))
            .floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance + arrowBox.h)
            .floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h) - _half(overlayBox.h))
            .floorToDouble(),
      ),
      position: ElTooltipPosition.rightCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _rightEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance).floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h) - arrowBox.w).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance + arrowBox.h)
            .floorToDouble(),
        y: (triggerBox.y + _half(triggerBox.h) - overlayBox.h).floorToDouble(),
      ),
      position: ElTooltipPosition.rightEnd,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: Radius.zero,
      ),
    );
  }

  ToolTipElementsDisplay display(ElTooltipPosition position) {
    switch (position) {
      case ElTooltipPosition.topStart:
        return _topStart();
      case ElTooltipPosition.topCenter:
        return _topCenter();
      case ElTooltipPosition.topEnd:
        return _topEnd();
      case ElTooltipPosition.bottomStart:
        return _bottomStart();
      case ElTooltipPosition.bottomCenter:
        return _bottomCenter();
      case ElTooltipPosition.bottomEnd:
        return _bottomEnd();
      case ElTooltipPosition.leftStart:
        return _leftStart();
      case ElTooltipPosition.leftCenter:
        return _leftCenter();
      case ElTooltipPosition.leftEnd:
        return _leftEnd();
      case ElTooltipPosition.rightStart:
        return _rightStart();
      case ElTooltipPosition.rightCenter:
        return _rightCenter();
      case ElTooltipPosition.rightEnd:
        return _rightEnd();
    }
  }

  double _half(double value) => value / 2;
}



