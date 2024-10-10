import 'package:digit_ui_components/theme/ComponentTheme/switch_theme.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';


List<Story> switchStories() {
  return [
    Story(
      name: 'Atom/Switch/default(Inactive)',
      builder: (context) {

        bool isSwitched = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/default(Active)',
      builder: (context) {

        bool isSwitched = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/With label(Inactive)',
      builder: (context) {

        bool isSwitched = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              label: context.knobs.text(label: 'Switch label', initial: 'Label'),
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/With label(Active)',
      builder: (context) {

        bool isSwitched = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              label: context.knobs.text(label: 'Switch label', initial: 'Label'),
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/with symbol(Inactive)',
      builder: (context) {

        bool isSwitched = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              showSymbol: true,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/with symbol(Active)',
      builder: (context) {

        bool isSwitched = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              showSymbol: true,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
    Story(
      name: 'Atom/Switch/with custom height width and color',
      builder: (context) {

        bool isSwitched = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              themeData: const DigitSwitchThemeData().copyWith(activeColor: Colors.red, trackWidth: 50, trackHeight: 24, symbolColor: Colors.blue, animationValue: 27),
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            );
          },
        );
      },
    ),
  ];
}