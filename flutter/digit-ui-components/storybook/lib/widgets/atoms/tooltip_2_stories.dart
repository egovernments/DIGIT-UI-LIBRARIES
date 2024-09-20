import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/tooltip_2.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> toolTip2Stories() {
  return [
    Story(
      name: 'Atom/Tool Tip/Simple',
      builder: (context) => Bubble(description:  'Hello Tooltip', triggerBox: ElementBox(w: 0, h: 0, x: 0, y: 0)),
    ),
    Story(
      name: 'Atom/Tool Tip/With Arrow',
      builder: (context) => DigitTooltip(
        tooltipContent: Text(
          'Hello, Tooltip!',
          style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: Theme.of(context).colorTheme.paper.primary),
        ),
        trigger: context.knobs.options(label: 'Trigger Mode', initial: TooltipTrigger.onHover, options: [
          const Option(label: 'On Hover', value: TooltipTrigger.onHover),
          const Option(label: 'On Tap', value: TooltipTrigger.onTap),
          const Option(label: 'On Long Press', value: TooltipTrigger.onLongPress),
        ]),
        tooltipPosition: context.knobs.options(
            label: 'Tooltip Position',
            initial: TooltipPosition.topStart,
            options: [
              const Option(
                  label: 'Top Start', value: TooltipPosition.topStart),
              const Option(
                  label: 'Top Center', value: TooltipPosition.topCenter),
              const Option(label: 'Top End', value: TooltipPosition.topEnd),
              const Option(
                  label: 'Bottom Start', value: TooltipPosition.bottomStart),
              const Option(
                  label: 'Bottom Center',
                  value: TooltipPosition.bottomCenter),
              const Option(
                  label: 'Bottom End', value: TooltipPosition.bottomEnd),
              const Option(
                  label: 'Left Start', value: TooltipPosition.leftStart),
              const Option(
                  label: 'Left Center', value: TooltipPosition.leftCenter),
              const Option(label: 'Left End', value: TooltipPosition.leftEnd),
              const Option(
                  label: 'Right Start', value: TooltipPosition.rightStart),
              const Option(
                  label: 'Right Center', value: TooltipPosition.rightCenter),
              const Option(
                  label: 'Right End', value: TooltipPosition.rightEnd),
            ]),
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/long text',
      builder: (context) => DigitTooltip(
        tooltipContent:  Text(
          'Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!Hello, Tooltip!',
          style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: Theme.of(context).colorTheme.paper.primary),
        ),
        trigger: context.knobs.options(label: 'Trigger Mode', initial: TooltipTrigger.onHover, options: [
          const Option(label: 'On Hover', value: TooltipTrigger.onHover),
          const Option(label: 'On Tap', value: TooltipTrigger.onTap),
          const Option(label: 'On Long Press', value: TooltipTrigger.onLongPress),
        ]),
        tooltipPosition: context.knobs.options(
            label: 'Tooltip Position',
            initial: TooltipPosition.topStart,
            options: [
              const Option(
                  label: 'Top Start', value: TooltipPosition.topStart),
              const Option(
                  label: 'Top Center', value: TooltipPosition.topCenter),
              const Option(label: 'Top End', value: TooltipPosition.topEnd),
              const Option(
                  label: 'Bottom Start', value: TooltipPosition.bottomStart),
              const Option(
                  label: 'Bottom Center',
                  value: TooltipPosition.bottomCenter),
              const Option(
                  label: 'Bottom End', value: TooltipPosition.bottomEnd),
              const Option(
                  label: 'Left Start', value: TooltipPosition.leftStart),
              const Option(
                  label: 'Left Center', value: TooltipPosition.leftCenter),
              const Option(label: 'Left End', value: TooltipPosition.leftEnd),
              const Option(
                  label: 'Right Start', value: TooltipPosition.rightStart),
              const Option(
                  label: 'Right Center', value: TooltipPosition.rightCenter),
              const Option(
                  label: 'Right End', value: TooltipPosition.rightEnd),
            ]),
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ),
      ),
    ),
    Story(
      name: 'Atom/Tool Tip/widget',
      builder: (context) => DigitTooltip(
        tooltipContent: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Tooltip!',
              style:Theme.of(context).digitTextTheme(context).headingS.copyWith(color: Theme.of(context).colorTheme.paper.primary),
            ),
            const SizedBox(height: 8,),
            const InfoCard(title: 'Info', type: InfoType.info, description: 'Hello, Tooltip!'),
            const SizedBox(height: 8,),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ',
              style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(color: Theme.of(context).colorTheme.paper.primary),
            ),
          ],
        ),
        trigger: context.knobs.options(label: 'Trigger Mode', initial: TooltipTrigger.onHover, options: [
          const Option(label: 'On Hover', value: TooltipTrigger.onHover),
          const Option(label: 'On Tap', value: TooltipTrigger.onTap),
          const Option(label: 'On Long Press', value: TooltipTrigger.onLongPress),
        ]),
        tooltipPosition: context.knobs.options(
            label: 'Tooltip Position',
            initial: TooltipPosition.topStart,
            options: [
              const Option(
                  label: 'Top Start', value: TooltipPosition.topStart),
              const Option(
                  label: 'Top Center', value: TooltipPosition.topCenter),
              const Option(label: 'Top End', value: TooltipPosition.topEnd),
              const Option(
                  label: 'Bottom Start', value: TooltipPosition.bottomStart),
              const Option(
                  label: 'Bottom Center',
                  value: TooltipPosition.bottomCenter),
              const Option(
                  label: 'Bottom End', value: TooltipPosition.bottomEnd),
              const Option(
                  label: 'Left Start', value: TooltipPosition.leftStart),
              const Option(
                  label: 'Left Center', value: TooltipPosition.leftCenter),
              const Option(label: 'Left End', value: TooltipPosition.leftEnd),
              const Option(
                  label: 'Right Start', value: TooltipPosition.rightStart),
              const Option(
                  label: 'Right Center', value: TooltipPosition.rightCenter),
              const Option(
                  label: 'Right End', value: TooltipPosition.rightEnd),
            ]),
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: const Text('Tap me'),
        ),
      ),
    ),
  ];
}
