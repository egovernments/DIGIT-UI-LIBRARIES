import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';


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
                  isSwitched = value; // Update the state when the switch is toggled
                });
              },
              width: 80.0,
              height: 40.0,
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
                  isSwitched = value; // Update the state when the switch is toggled
                });
              },
              width: 80.0,
              height: 40.0,
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
                  isSwitched = value; // Update the state when the switch is toggled
                });
              },
              width: 80.0,
              height: 40.0,
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
                  isSwitched = value; // Update the state when the switch is toggled
                });
              },
              width: 80.0,
              height: 40.0,
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
                  isSwitched = value; // Update the state when the switch is toggled
                });
              },
              width: 80.0,
              height: 40.0,
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
                  isSwitched = value; // Update the state when the switch is toggled
                });
              },
              width: 80.0,
              height: 40.0,
            );
          },
        );
      },
    ),
  ];
}
