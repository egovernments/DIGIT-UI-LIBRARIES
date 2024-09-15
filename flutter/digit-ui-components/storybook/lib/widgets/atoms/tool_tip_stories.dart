import 'package:digit_ui_components/widgets/atoms/tool_tip.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> toolTipStories() {
  return [
    Story(
      name: 'Atom/Tool Tip/top start',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.topStart,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/top center',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.topCenter,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(0),
          child: const Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/top end',
      builder: (context) => CustomTooltip(
        message: 'This is a custom tooltip',
        position: TooltipPosition.topEnd,
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ), // Change to onTap or onLongPress as needed
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
    // Story(
    //   name: 'Atom/Tool Tip/4',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('top start tooltip!'),
    //     position: TooltipPosition.,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/5',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.bottom,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/6',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.bottomRight,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/7',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.leftTop,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/8',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.left,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/9',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.leftBottom,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/10',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.rightTop,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/11',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.right,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
    // Story(
    //   name: 'Atom/Tool Tip/12',
    //   builder: (context) => CustomTooltip(
    //     tooltipContent: Text('This is a custom tooltip!'),
    //     position: TooltipPosition.rightBottom,
    //     trigger: TooltipTrigger.onHover,
    //     child: ElevatedDigitButton(
    //       onPressed: () {},
    //       child: Text('Hover me'),
    //     ), // Change to onTap or onLongPress as needed
    //   ),
    // ),
  ];
}
