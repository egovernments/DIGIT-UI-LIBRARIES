import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/panel.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> panelStories() {
  return [
    Story(
      name: 'Atom/Panel/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Success/Basic',
      builder: (context) {
        final animateKnob = context.knobs.boolean(label: 'Animation', initial: true);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Panel(
                type: PanelType.success,
                title: context.knobs.text(label: 'Title', initial: 'Success Message'),
                animate: animateKnob,
              ),
        );
      },
    ),
    Story(
      name: 'Atom/Panel/Success/With description',
      builder: (context) {
        final animateKnob = context.knobs.boolean(label: 'Animation', initial: true);

        final descriptionString = context.knobs.text(
          label: 'Description (comma-separated)',
          initial: 'Description1, Description2, Description3',
        );

        final descriptionList =
        descriptionString.split(',').map((s) => s.trim()).toList();

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Panel(
                type: PanelType.success,
                title: context.knobs.text(label: 'Title', initial: 'Success Message'),
                description: descriptionList.map((text) {
                  return Text(
                    text,
                    style: Theme.of(context)
                        .digitTextTheme(context)
                        .bodyS
                        .copyWith(
                      color: Theme.of(context).colorTheme.paper.primary,
                    ),
                  );
                }).toList(),
                animate: animateKnob,
              ),
        );

      },
    ),
    Story(
      name: 'Atom/Panel/Error/Basic',
      builder: (context) {
        final animateKnob = context.knobs.boolean(label: 'Animation', initial: true);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Panel(
                type: PanelType.error,
                title: context.knobs.text(label: 'Title', initial: 'Error Message'),
                animate: animateKnob,
              ),
        );

      },
    ),
    Story(
      name: 'Atom/Panel/Error/With description',
      builder: (context) {
        final animateKnob = context.knobs.boolean(label: 'Animation', initial: true);

        final descriptionString = context.knobs.text(
          label: 'Description (comma-separated)',
          initial: 'Description1, Description2, Description3',
        );

        final descriptionList =
        descriptionString.split(',').map((s) => s.trim()).toList();

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Panel(
                type: PanelType.error,
                title: context.knobs.text(label: 'Title', initial: 'Error Message'),
                description: descriptionList.map((text) {
                  return Text(
                    text,
                    style: Theme.of(context)
                        .digitTextTheme(context)
                        .bodyS
                        .copyWith(
                      color: Theme.of(context).colorTheme.paper.primary,
                    ),
                  );
                }).toList(),
                animate: animateKnob,
              ),
        );
      },
    ),
  ];
}
