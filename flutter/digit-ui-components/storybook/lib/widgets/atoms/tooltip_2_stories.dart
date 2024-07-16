import 'package:digit_ui_components/widgets/atoms/tool_tip.dart';
import 'package:digit_ui_components/widgets/atoms/tooltip_2.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> toolTip2Stories() {
  return [
    Story(
      name: 'Atom/Tool Tip2/top start',
      builder: (context) => const DigitTooltip(
        tooltipContent: Text('Hello, Tooltip!'),
        tooltipPosition: ElTooltipPosition.topStart,
        child: Icon(Icons.info),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip2/top center',
      builder: (context) => const DigitTooltip(
        tooltipContent: Text('Hello, Tooltip!'),
        tooltipPosition: ElTooltipPosition.topCenter,
        child: Icon(Icons.info),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip2/top end',
      builder: (context) => const DigitTooltip(
        tooltipContent: Text('Hello, Tooltip!'),
        tooltipPosition: ElTooltipPosition.topEnd,
        child: Icon(Icons.info),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/bottom start',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.bottomStart,
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/bottom center',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.bottomCenter,
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/bottom end',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.bottomEnd,
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/left start',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.leftStart,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/left center',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.leftCenter,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/left end',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.leftEnd,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ), // Change to onTap or onLongPress as needed
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/right start',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.rightStart,
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/right center',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.rightCenter,
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/right end',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.rightEnd,
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Text('Tap me'),
        ),
      ),
    ),
  ];
}
