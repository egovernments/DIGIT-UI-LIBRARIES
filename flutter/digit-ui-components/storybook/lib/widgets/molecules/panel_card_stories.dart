import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/panel_cards.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import '../../iframe/iframe_widget.dart';


List<Story> panelCardStories() {
  return [
    Story(
      name: 'Molecule/Panel Card/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/Panel Card/Success',
      builder: (context) {
        final showAdditionalWidgets = context.knobs.boolean(
            label: 'Show Additional Widgets', initial: false);
        final showActions = context.knobs.boolean(
            label: 'Show Actions', initial: false);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: PanelCard(type: PanelType.success,
            title: context.knobs.text(label: 'Title', initial: 'Success Message'),
            actions: showActions
                ? [
              DigitButton(
                label: 'Cancel',
                onPressed: () {},
                type: DigitButtonType.secondary,
                size: DigitButtonSize.large,
              ),
              DigitButton(
                label: 'Submit',
                onPressed: () {},
                type: DigitButtonType.primary,
                size: DigitButtonSize.large,
              ),
            ]
                : null,
            additionWidgets: showAdditionalWidgets
                ? const [
              InfoCard(
                title: 'Additional Info',
                type: InfoType.success,
                description: 'This is an example of additional widget content that can be toggled.',
              ),
            ]
                : null,
          ),
        );
      }
    ),
    Story(
      name: 'Molecule/Panel Card/Error',
        builder: (context) {
          final showAdditionalWidgets = context.knobs.boolean(
              label: 'Show Additional Widgets', initial: false);
          final showActions = context.knobs.boolean(
              label: 'Show Actions', initial: false);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PanelCard(type: PanelType.error,
              title: context.knobs.text(label: 'Title', initial: 'Success Message'),
              actions: showActions
                  ? [
                DigitButton(
                  label: 'Cancel',
                  onPressed: () {},
                  type: DigitButtonType.secondary,
                  size: DigitButtonSize.large,
                ),
                DigitButton(
                  label: 'Submit',
                  onPressed: () {},
                  type: DigitButtonType.primary,
                  size: DigitButtonSize.large,
                ),
              ]
                  : null,
              additionWidgets: showAdditionalWidgets
                  ? const [
                InfoCard(
                  title: 'Additional Info',
                  type: InfoType.error,
                  description: 'This is an example of additional widget content that can be toggled.',
                ),
              ]
                  : null,
            ),
          );
        }
    ),
  ];
}