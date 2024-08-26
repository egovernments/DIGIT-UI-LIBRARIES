import 'package:digit_ui_components/theme/ComponentTheme/switch_theme.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> switchStories() {
  return [
    Story(
      name: 'Atom/Switch/default(Inactive)',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: false,
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: true,
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: false,
  label: 'Label',
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: true,
  label: 'Label',
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: false,
  showSymbol: true,
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: true,
  showSymbol: true,
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
CustomSwitch(
  value: false,
  themeData: const CustomSwitchThemeData().copyWith(activeColor: Colors.red, trackWidth: 50, trackHeight: 24, symbolColor: Colors.blue, animationValue: 27),
  onChanged: (value) {
    // Update the state when the switch is toggled
  },
)
          ''');
        });

        bool isSwitched = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomSwitch(
              value: isSwitched,
              themeData: const CustomSwitchThemeData().copyWith(activeColor: Colors.red, trackWidth: 50, trackHeight: 24, symbolColor: Colors.blue, animationValue: 27),
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
