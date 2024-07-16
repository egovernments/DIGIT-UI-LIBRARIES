import 'package:flutter/material.dart';

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

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final TooltipPosition position;

  CustomTooltip({
    required this.message,
    required this.child,
    this.position = TooltipPosition.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final overlay = Overlay.of(context)!.context.findRenderObject()!;
        final box = context.findRenderObject() as RenderBox;
        final target = box.localToGlobal(Offset.zero) & box.size;
        showOverlayTooltip(
          context: context,
          overlay: overlay,
          target: target,
          message: message,
          position: position,
        );
      },
      child: child,
    );
  }

  void showOverlayTooltip({
    required BuildContext context,
    required RenderObject overlay,
    required Rect target,
    required String message,
    required TooltipPosition position,
  }) {
    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: _getPosition(position, target, context).dy,
          left: _getPosition(position, target, context).dx,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildTooltipContainer(message),
                _buildArrow(position),
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context)!.insert(entry);

    Future.delayed(Duration(seconds: 3), () {
      entry.remove();
    });
  }

  Offset _getPosition(TooltipPosition position, Rect target, BuildContext context) {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    switch (position) {
      case TooltipPosition.topStart:
        return Offset(target.left, target.top - 60);
      case TooltipPosition.topCenter:
        return Offset(target.left + (target.width - 100) / 2, target.top - 60);
      case TooltipPosition.topEnd:
        return Offset(target.right - 100, target.top - 60);
      case TooltipPosition.bottomStart:
        return Offset(target.left, target.bottom);
      case TooltipPosition.bottomCenter:
        return Offset(target.left + (target.width - 100) / 2, target.bottom);
      case TooltipPosition.bottomEnd:
        return Offset(target.right - 100, target.bottom);
      case TooltipPosition.leftStart:
        return Offset(target.left - 110, target.top);
      case TooltipPosition.leftCenter:
        return Offset(target.left - 110, target.top + (target.height - 50) / 2);
      case TooltipPosition.leftEnd:
        return Offset(target.left - 110, target.bottom - 50);
      case TooltipPosition.rightStart:
        return Offset(target.right, target.top);
      case TooltipPosition.rightCenter:
        return Offset(target.right, target.top + (target.height - 50) / 2);
      case TooltipPosition.rightEnd:
        return Offset(target.right, target.bottom - 50);
      default:
        return Offset.zero;
    }
  }

  Widget _buildTooltipContainer(String message) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildArrow(TooltipPosition position) {
    double top = 0;
    double left = 0;
    switch (position) {
      case TooltipPosition.topStart:
        left = 8;
        top = -10;
        break;
      case TooltipPosition.topCenter:
        left = 40;
        top = -10;
        break;
      case TooltipPosition.topEnd:
        left = 72;
        top = -10;
        break;
      case TooltipPosition.bottomStart:
        left = 8;
        top = 40;
        break;
      case TooltipPosition.bottomCenter:
        left = 40;
        top = 40;
        break;
      case TooltipPosition.bottomEnd:
        left = 72;
        top = 40;
        break;
      case TooltipPosition.leftStart:
        left = -10;
        top = 8;
        break;
      case TooltipPosition.leftCenter:
        left = -10;
        top = 24;
        break;
      case TooltipPosition.leftEnd:
        left = -10;
        top = 40;
        break;
      case TooltipPosition.rightStart:
        left = 100;
        top = 8;
        break;
      case TooltipPosition.rightCenter:
        left = 100;
        top = 24;
        break;
      case TooltipPosition.rightEnd:
        left = 100;
        top = 40;
        break;
    }

    return Positioned(
      left: left,
      top: top,
      child: CustomPaint(
        size: Size(20, 20),
        painter: _ArrowPainter(color: Colors.black, position: position),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final TooltipPosition position;

  _ArrowPainter({required this.color, required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    switch (position) {
      case TooltipPosition.topStart:
      case TooltipPosition.topCenter:
      case TooltipPosition.topEnd:
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        break;
      case TooltipPosition.bottomStart:
      case TooltipPosition.bottomCenter:
      case TooltipPosition.bottomEnd:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;
      case TooltipPosition.leftStart:
      case TooltipPosition.leftCenter:
      case TooltipPosition.leftEnd:
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case TooltipPosition.rightStart:
      case TooltipPosition.rightCenter:
      case TooltipPosition.rightEnd:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

