import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class DigitTooltip extends StatefulWidget {
  final Widget child;
  final Widget tooltipContent;
  final TooltipPosition tooltipPosition;
  final double distance;
  final TooltipTrigger trigger;

  const DigitTooltip({
    Key? key,
    required this.child,
    required this.tooltipContent,
    this.tooltipPosition = TooltipPosition.topCenter,
    this.distance = 8.0,
    this.trigger = TooltipTrigger.onHover,
  }) : super(key: key);

  @override
  _DigitTooltipState createState() => _DigitTooltipState();
}

class _DigitTooltipState extends State<DigitTooltip>
    with WidgetsBindingObserver {
  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayEntryHidden;
  GlobalKey<TooltipOverlayState>? _overlayKey;

  final GlobalKey _widgetKey = GlobalKey();

  final ElementBox _arrowBox = ElementBox(h: 8, w: 8);
  ElementBox _overlayBox = ElementBox(h: 0.0, w: 0.0);

  ElementBox get _screenSize => _getScreenSize();

  ElementBox get _triggerBox => _getTriggerSize();


  /// Automatically hide the overlay when the screen dimension changes
  /// or when the user scrolls. This is done to avoid displacement.
  @override
  void didChangeMetrics() {
    _hideOverlay();
  }

  /// Dispose the observer
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Init state and trigger the hidden overlay to measure its size
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadHiddenOverlay(context));
    WidgetsBinding.instance.addObserver(this);
  }

  /// Measures the hidden tooltip after it's loaded with _loadHiddenOverlay(_)
  void _getHiddenOverlaySize(context) {
    RenderBox box = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    if (mounted) {
      setState(() {
        _overlayBox = ElementBox(
          w: box.size.width,
          h: box.size.height,
        );
        _overlayEntryHidden?.remove();
      });
    }
  }


  /// Loads the tooltip without opacity to measure the rendered size
  void _loadHiddenOverlay(_) {
    OverlayState? overlayStateHidden = Overlay.of(context);
    _overlayEntryHidden = OverlayEntry(
      builder: (context) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _getHiddenOverlaySize(context));
        return Opacity(
          opacity: 0,
          child: Center(
            child: Bubble(
              key: _widgetKey,
              triggerBox: _triggerBox,
              padding: const EdgeInsets.all(10),
              child: widget.tooltipContent,
            ),
          ),
        );
      },
    );

    if (_overlayEntryHidden != null) {
      overlayStateHidden.insert(_overlayEntryHidden!);
    }
  }

  /// Measures the size of the trigger widget
  ElementBox _getTriggerSize() {
    if (mounted) {
      final renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      return ElementBox(
        w: renderBox.size.width,
        h: renderBox.size.height,
        x: offset.dx,
        y: offset.dy,
      );
    }
    _hideOverlay();
    return ElementBox(w: 0, h: 0, x: 0, y: 0);
  }

  /// Measures the size of the screen to calculate possible overflow
  ElementBox _getScreenSize() {
    return ElementBox(
      w: MediaQuery.of(context).size.width,
      h: MediaQuery.of(context).size.height,
    );
  }

  /// Hides or shows the tooltip
  void _toggleOverlay(BuildContext context) =>
      _overlayEntry != null ? _hideOverlay() : _showOverlay(context);

  /// Loads the tooltip into view
  Future<void> _showOverlay([BuildContext? context]) async {
    context ??= this.context;
    final overlayState = Overlay.of(context);

    /// By calling [PositionManager.load()] we get returned the position
    /// of the tooltip, the arrow and the trigger.
    ToolTipElementsDisplay toolTipElementsDisplay = PositionManager(
      arrowBox: _arrowBox,
      overlayBox: _overlayBox,
      triggerBox: _triggerBox,
      screenSize: _screenSize,
      distance: widget.distance,
      radius: const Radius.circular(8),
    ).load(preferredPosition: widget.tooltipPosition);

    _overlayKey = GlobalKey<TooltipOverlayState>();

    _overlayEntry = OverlayEntry(
      builder: (context) => TooltipOverlay(
        key: _overlayKey,
        toolTipElementsDisplay: toolTipElementsDisplay,
        content: widget.tooltipContent,
        triggerBox: _triggerBox,
        arrowBox: _arrowBox,
      ),
    );

    if (_overlayEntry != null) {
      overlayState.insert(_overlayEntry!);
    }
    Future.delayed(const Duration(seconds: 5), () {
      _hideOverlay();
    });
    // Add timeout for the tooltip to disapear after a few seconds
    // if (widget.timeout > Duration.zero) {
    //   await Future.delayed(widget.timeout).whenComplete(_hideOverlay);
    // }
  }

  /// Method to hide the tooltip
  Future<void> _hideOverlay() async {
    final state = _overlayKey?.currentState;
    if (state != null) {
      await state.hide();
      _overlayKey = null;
    }
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: widget.trigger == TooltipTrigger.onHover ? (value) {
        if(value){
          _toggleOverlay(context);
        }
      } : null,
      onTap: widget.trigger == TooltipTrigger.onTap ? () => _toggleOverlay(context) : (){},
      onLongPress: widget.trigger == TooltipTrigger.onLongPress ? () => _toggleOverlay(context) : (){},
      child: widget.child,
    );
  }

}

class TooltipOverlay extends StatefulWidget {
  final Widget content;
  /// [triggerBox] Box that contains the trigger
  final ElementBox triggerBox;

  /// [arrowBox] Box that contains the arrow
  final ElementBox arrowBox;
  /// [toolTipElementsDisplay] Contains the position of the tooltip, the arrow and the trigger
  final ToolTipElementsDisplay toolTipElementsDisplay;

  const TooltipOverlay({
    super.key,
    required this.content,
    required this.triggerBox,
    required this.arrowBox,
    required this.toolTipElementsDisplay,
  });

  @override
  TooltipOverlayState createState() => TooltipOverlayState();
}

class TooltipOverlayState extends State<TooltipOverlay> {
  bool closing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => show());
  }

  Future<void> show() async {
    setState(() {
      closing = false;
    });
  }

  Future<void> hide() async {
    setState(() {
      closing = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: widget.toolTipElementsDisplay.bubble.y,
          left: widget.toolTipElementsDisplay.bubble.x,
          child: Bubble(
            triggerBox: widget.triggerBox,
            radius: widget.toolTipElementsDisplay.radius,
            child: widget.content,
          ),
        ),
        Positioned(
          top: widget.toolTipElementsDisplay.arrow.y,
          left: widget.toolTipElementsDisplay.arrow.x,
          child: Arrow(
            position: widget.toolTipElementsDisplay.position,
            width: widget.arrowBox.w,
            height: widget.arrowBox.h,
          ),
        ),
        // if (widget.showChildAboveOverlay)
        //   Positioned(
        //     top: widget.triggerBox.y,
        //     left: widget.triggerBox.x,
        //     child: GestureDetector(
        //       onTap: widget.hideOverlay,
        //       child: widget.child,
        //     ),
        //   ),
      ],
    );
  }
}


enum TooltipTrigger { onTap, onHover, onLongPress }

enum TooltipPosition {
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
    this.x = 0,
    this.y = 0,
  });
}

class ToolTipElementsDisplay {
  final ElementBox arrow;
  final ElementBox bubble;
  final TooltipPosition position;
  final BorderRadius radius;

  ToolTipElementsDisplay({
    required this.arrow,
    required this.bubble,
    required this.position,
    required this.radius,
  });
}

/// Bubble serves as the tooltip container
class Bubble extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final double maxWidth;
  final ElementBox triggerBox;
  final BorderRadiusGeometry? radius;
  final Widget child;

  const Bubble({
    this.padding = const EdgeInsets.all(10.0),
    this.radius = const BorderRadius.all(Radius.circular(8)),
    required this.child,
    required this.triggerBox,
    this.maxWidth = 300.0,
    super.key,
  });

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 1.0,
        child: Container(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          decoration: BoxDecoration(
            borderRadius: widget.radius,
            color: const DigitColors().light.genericInputBorder,
          ),
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}


/// Loads the arrow from the paint code and applies the correct transformations
/// color, rotation and mirroring
class Arrow extends StatelessWidget {
  final TooltipPosition position;
  final double width;
  final double height;
  const Arrow({
    required this.position,
    this.width = 8,
    this.height = 8,
    super.key,
  });


  /// Applies the transformation to the triangle
  Widget _getTriangle() {
    double scaleX = 1;
    double scaleY = 1;
    bool isArrow = false;
    int quarterTurns = 0;

    switch (position) {
      case TooltipPosition.topStart:
        break;
      case TooltipPosition.topCenter:
        quarterTurns = 0;
        isArrow = true;
        break;
      case TooltipPosition.topEnd:
        scaleX = -1;
        break;
      case TooltipPosition.bottomStart:
        scaleY = -1;
        break;
      case TooltipPosition.bottomCenter:
        quarterTurns = 2;
        isArrow = true;
        break;
      case TooltipPosition.bottomEnd:
        scaleX = -1;
        scaleY = -1;
        break;
      case TooltipPosition.leftStart:
        scaleY = -1;
        quarterTurns = 3;
        break;
      case TooltipPosition.leftCenter:
        quarterTurns = 3;
        isArrow = true;
        break;
      case TooltipPosition.leftEnd:
        quarterTurns = 3;
        break;
      case TooltipPosition.rightStart:
        quarterTurns = 1;
        break;
      case TooltipPosition.rightCenter:
        quarterTurns = 1;
        isArrow = true;
        break;
      case TooltipPosition.rightEnd:
        quarterTurns = 1;
        scaleY = -1;
        break;
    }

    return Transform.scale(
      scaleX: scaleX,
      scaleY: scaleY,
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: CustomPaint(
          size: const Size(8, 8),
          painter: isArrow ? Triangle(color: const DigitColors().light.genericInputBorder) : Corner(color: const DigitColors().light.genericInputBorder),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getTriangle();
  }
}

/// Design of the corner triangle that appears attached to the tooltip
class Corner extends CustomPainter {
  /// [color] of the arrow.
  final Color color;

  Corner({this.color = const Color(0xff000000)});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = color;

    path.moveTo(0, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// Design of the triangle that appears attached to the tooltip
/// Design of the triangle that appears attached to the tooltip
class Triangle extends CustomPainter {
  /// [color] of the arrow.
  final Color color;

  Triangle({this.color = const Color(0xff000000)});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.isAntiAlias = true;
    paint.color = color;
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
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

  /// [distance] between the tooltip and the trigger DigitButton.
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
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x).ceilToDouble(),
        y: (triggerBox.y - distance - arrowBox.h).ceilToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x.ceilToDouble(),
        y: (triggerBox.y - overlayBox.h - distance - arrowBox.h).ceilToDouble(),
      ),
      position: TooltipPosition.topStart,
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
        x: (triggerBox.x + _half(triggerBox.w) - _half(overlayBox.w)).floorToDouble(),
        y: (triggerBox.y - overlayBox.h - distance - arrowBox.h).floorToDouble(),
      ),
      position: TooltipPosition.topCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _topEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: (triggerBox.x + triggerBox.w - arrowBox.h),
        y: (triggerBox.y - distance - arrowBox.h ),
      ),
      bubble: ElementBox(
        w: arrowBox.w,
        h: arrowBox.h,
        x: (triggerBox.x - overlayBox.w +triggerBox.w),
        y: (triggerBox.y - overlayBox.h - distance - arrowBox.h),
      ),
      position: TooltipPosition.topEnd,
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
        x: (triggerBox.x),
        y: (triggerBox.y + triggerBox.h + distance),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x,
        y: (triggerBox.y + triggerBox.h + distance +arrowBox.w),
      ),
      position: TooltipPosition.bottomStart,
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
        y: triggerBox.y + triggerBox.h + distance + arrowBox.w,
      ),
      position: TooltipPosition.bottomCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _bottomEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x +triggerBox.w- arrowBox.h),
        y: (triggerBox.y + triggerBox.h + distance).ceilToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x + triggerBox.w - overlayBox.w,
        y: triggerBox.y + triggerBox.h + distance + arrowBox.w,
      ),
      position: TooltipPosition.bottomEnd,
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
        y: triggerBox.y,
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x - overlayBox.x - overlayBox.w - distance - arrowBox.h,
        y: triggerBox.y,
      ),
      position: TooltipPosition.leftStart,
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
      position: TooltipPosition.leftCenter,
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
        y: (triggerBox.y +triggerBox.h - arrowBox.h).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: triggerBox.x - overlayBox.x - overlayBox.w - distance - arrowBox.w,
        y: triggerBox.y +triggerBox.h - overlayBox.h,
      ),
      position: TooltipPosition.leftEnd,
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
        y: (triggerBox.y ).floorToDouble(),
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance + arrowBox.w)
            .floorToDouble(),
        y: (triggerBox.y).floorToDouble(),
      ),
      position: TooltipPosition.rightStart,
      radius: BorderRadius.only(
        topLeft: Radius.zero,
        topRight: radius,
        bottomLeft: radius,
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
        x: (triggerBox.x + triggerBox.w + distance + arrowBox.w).floorToDouble(),
        y: triggerBox.y + _half(triggerBox.h) - _half(overlayBox.h),
      ),
      position: TooltipPosition.rightCenter,
      radius: BorderRadius.all(radius),
    );
  }

  ToolTipElementsDisplay _rightEnd() {
    return ToolTipElementsDisplay(
      arrow: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance).floorToDouble(),
        y: triggerBox.y + triggerBox.h - arrowBox.h,
      ),
      bubble: ElementBox(
        w: overlayBox.w,
        h: overlayBox.h,
        x: (triggerBox.x + triggerBox.w + distance + arrowBox.w).floorToDouble(),
        y: triggerBox.y +triggerBox.h - overlayBox.h,
      ),
      position: TooltipPosition.rightEnd,
      radius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: Radius.zero,
        bottomRight: radius,
      ),
    );
  }

  double _half(double size) {
    return size * 0.5;
  }

  bool _fitsScreen(ToolTipElementsDisplay el) {
    if (el.bubble.x > 0 &&
        el.bubble.x + el.bubble.w < screenSize.w &&
        el.bubble.y > 0 &&
        el.bubble.y + el.bubble.h < screenSize.h) {
      return true;
    }
    return false;
  }

  /// Tests each possible position until it finds one that fits.
  ToolTipElementsDisplay _firstAvailablePosition() {
    List<ToolTipElementsDisplay Function()> positions = [
      _topCenter,
      _bottomCenter,
      _leftCenter,
      _rightCenter,
      _topStart,
      _topEnd,
      _leftStart,
      _rightStart,
      _leftEnd,
      _rightEnd,
      _bottomStart,
      _bottomEnd,
    ];
    for (var position in positions) {
      if (_fitsScreen(position())) return position();
    }
    return _topCenter();
  }

  /// Load the calculated tooltip position
  ToolTipElementsDisplay load({TooltipPosition? preferredPosition}) {
    ToolTipElementsDisplay elementPosition;

    switch (preferredPosition) {
      case TooltipPosition.topStart:
        elementPosition = _topStart();
        break;
      case TooltipPosition.topCenter:
        elementPosition = _topCenter();
        break;
      case TooltipPosition.topEnd:
        elementPosition = _topEnd();
        break;
      case TooltipPosition.bottomStart:
        elementPosition = _bottomStart();
        break;
      case TooltipPosition.bottomCenter:
        elementPosition = _bottomCenter();
        break;
      case TooltipPosition.bottomEnd:
        elementPosition = _bottomEnd();
        break;
      case TooltipPosition.leftStart:
        elementPosition = _leftStart();
        break;
      case TooltipPosition.leftCenter:
        elementPosition = _leftCenter();
        break;
      case TooltipPosition.leftEnd:
        elementPosition = _leftEnd();
        break;
      case TooltipPosition.rightStart:
        elementPosition = _rightStart();
        break;
      case TooltipPosition.rightCenter:
        elementPosition = _rightCenter();
        break;
      case TooltipPosition.rightEnd:
        elementPosition = _rightEnd();
        break;
      default:
        elementPosition = _topCenter();
        break;
    }

    return _fitsScreen(elementPosition)
        ? elementPosition
        : _firstAvailablePosition();
  }
}