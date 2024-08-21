import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/panel.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> panelStories() {
  return [
    Story(
      name: 'Atom/Panel/Success/Default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.success,
  title: 'Success Message',
)
          ''');
        });

        return Panel(
          type: PanelType.success,
          title: context.knobs.text(label: 'Title', initial: 'Success Message'),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Success/With description',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.success,
  title: 'Success Message',
  description: 'description',
)
          ''');
        });

        final descriptionString = context.knobs.text(
          label: 'Description (comma-separated)',
          initial: 'Ref ID, 949749795479',
        );

        final descriptionList =
            descriptionString.split(',').map((s) => s.trim()).toList();

        return Panel(
          type: PanelType.success,
          title: context.knobs.text(label: 'Title', initial: 'Success Message'),
          description: descriptionList.map((text) {
            final isTitle = text == 'Ref ID';
            return Text(
              text,
              style: isTitle
                  ? Theme.of(context)
                      .digitTextTheme(context)
                      .bodyS
                      .copyWith(color: const DigitColors().light.paperPrimary)
                  : Theme.of(context)
                      .digitTextTheme(context)
                      .headingS
                      .copyWith(color: const DigitColors().light.paperPrimary),
            );
          }).toList(),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Success/Without animation',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.success,
  animate: false,
  title: 'Success Message',
)
          ''');
        });

        return Panel(
          type: PanelType.success,
          animate: false,
          title: context.knobs.text(label: 'Title', initial: 'Success Message'),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Success/Animation repeat',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.success,
  repeat: true,
  title: 'Success Message',
)
          ''');
        });

        return Panel(
          type: PanelType.success,
          repeat: true,
          title: context.knobs.text(label: 'Title', initial: 'Success Message'),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Error/Default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.error,
  title: 'Error Message',
)
          ''');
        });

        return Panel(
          type: PanelType.error,
          title: context.knobs.text(label: 'Title', initial: 'Error Message'),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Error/With description',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.error,
  title: 'Error Message',
  description: 'description',
)
          ''');
        });

        final descriptionString = context.knobs.text(
          label: 'Description (comma-separated)',
          initial: 'Ref ID, 949749795479',
        );

        final descriptionList =
            descriptionString.split(',').map((s) => s.trim()).toList();

        return Panel(
          type: PanelType.error,
          title: context.knobs.text(label: 'Title', initial: 'Error Message'),
          description: descriptionList.map((text) {
            final isTitle = text == 'Ref ID';
            return Text(
              text,
              style: isTitle
                  ? Theme.of(context)
                      .digitTextTheme(context)
                      .bodyS
                      .copyWith(color: const DigitColors().light.paperPrimary)
                  : Theme.of(context)
                      .digitTextTheme(context)
                      .headingS
                      .copyWith(color: const DigitColors().light.paperPrimary),
            );
          }).toList(),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Error/Without animation',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.error,
  animate: false,
  title: 'Error Message',
)
          ''');
        });

        return Panel(
          type: PanelType.error,
          animate: false,
          title: context.knobs.text(label: 'Title', initial: 'Error Message'),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Error/Animation repeat',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Panel(
  type: PanelType.error,
  repeat: true,
  title: 'Error Message',
)
          ''');
        });

        return Panel(
          type: PanelType.error,
          repeat: true,
          title: context.knobs.text(label: 'Title', initial: 'Error Message'),
        );
      },
    ),
  ];
}
