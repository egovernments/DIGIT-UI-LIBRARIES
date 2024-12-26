import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/ComponentTheme/info_card_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:digit_ui_components/widgets/atoms/info_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import '../../iframe/iframe_widget.dart';

List<Story> infoCardStories() {
  return [
    Story(
      name: 'Atom/Alert Card/Documentation',
      builder: (context) {
        return IframeWidget(
          url:
              'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Alert Card/Info',
      builder: (context) {
        // First knob for controlling the visibility of the additional widget
        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );

        // Second knob for controlling the visibility of the info button
        bool showInfoButton = context.knobs.boolean(
          label: "Action",
          initial: false,
        );

        // Conditionally define the 'inline' option knob based on the value of 'showAdditionalWidget'
        bool? showInlineWidget;
        if (showAdditionalWidget) {
          showInlineWidget = context.knobs.options(
            label: "Widget Alignment",
            options: const [
              Option(label: "Vertical", value: true),
              Option(label: "Horizontal", value: false),
            ],
            initial: false,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: InfoCard(
            title: context.knobs.text(label: "Title", initial: 'Info'),
            type: InfoType.info,
            description: context.knobs.text(
              label: "Description",
              initial:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.',
            ),
            inline: showInlineWidget ?? false,
            additionalWidgets: showAdditionalWidget || showInfoButton ?[
              if (showAdditionalWidget)
                ...List.generate(
                  5,
                      (_) => Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  ),
                ),
              if (showInfoButton)
                Column(
                  children: [
                    if (showInfoButton && showInlineWidget == true)
                      SizedBox(
                        height: 16,
                      ),
                    InfoButton(
                      size: DigitButtonSize.large,
                      label: 'Action Button',
                      onPressed: () {},
                      type: InfoDigitButtonType.info,
                    ),
                  ],
                ),
            ] : null,
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Alert Card/Error',
      builder: (context) {
        // First knob for controlling the visibility of the additional widget
        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );

        // Second knob for controlling the visibility of the info button
        bool showInfoButton = context.knobs.boolean(
          label: "Action",
          initial: false,
        );

        // Conditionally define the 'inline' option knob based on the value of 'showAdditionalWidget'
        bool? showInlineWidget;
        if (showAdditionalWidget) {
          showInlineWidget = context.knobs.options(
            label: "Widget Alignment",
            options: const [
              Option(label: "Vertical", value: true),
              Option(label: "Horizontal", value: false),
            ],
            initial: false,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: InfoCard(
            title: context.knobs.text(label: "Title", initial: 'Error'),
            type: InfoType.error,
            description: context.knobs.text(
              label: "Description",
              initial:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.',
            ),
            inline: showInlineWidget ?? false,
            additionalWidgets: showAdditionalWidget || showInfoButton ?[
              if (showAdditionalWidget)
                ...List.generate(
                  5,
                      (_) => Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  ),
                ),
              if (showInfoButton)
                Column(
                  children: [
                    if (showInfoButton && showInlineWidget == true)
                      SizedBox(
                        height: 16,
                      ),
                    InfoButton(
                      size: DigitButtonSize.large,
                      label: 'Action Button',
                      onPressed: () {},
                      type: InfoDigitButtonType.error,
                    ),
                  ],
                ),
            ] : null,
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Alert Card/Success',
      builder: (context) {
        // First knob for controlling the visibility of the additional widget
        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );

        // Second knob for controlling the visibility of the info button
        bool showInfoButton = context.knobs.boolean(
          label: "Action",
          initial: false,
        );

        // Conditionally define the 'inline' option knob based on the value of 'showAdditionalWidget'
        bool? showInlineWidget;
        if (showAdditionalWidget) {
          showInlineWidget = context.knobs.options(
            label: "Widget Alignment",
            options: const [
              Option(label: "Vertical", value: true),
              Option(label: "Horizontal", value: false),
            ],
            initial: false,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: InfoCard(
            title: context.knobs.text(label: "Title", initial: 'Success'),
            type: InfoType.success,
            description: context.knobs.text(
              label: "Description",
              initial:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.',
            ),
            inline: showInlineWidget ?? false,
            additionalWidgets: showAdditionalWidget || showInfoButton ? [
              if (showAdditionalWidget)
                ...List.generate(
                  5,
                      (_) => Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  ),
                ),
              if (showInfoButton)
                Column(
                  children: [
                    if (showInfoButton && showInlineWidget == true)
                      SizedBox(
                        height: 16,
                      ),
                    InfoButton(
                      size: DigitButtonSize.large,
                      label: 'Action Button',
                      onPressed: () {},
                      type: InfoDigitButtonType.success,
                    ),
                  ],
                ),
            ] : null,
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Alert Card/Warning',
      builder: (context) {
        // First knob for controlling the visibility of the additional widget
        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );

        // Second knob for controlling the visibility of the info button
        bool showInfoButton = context.knobs.boolean(
          label: "Action",
          initial: false,
        );

        // Conditionally define the 'inline' option knob based on the value of 'showAdditionalWidget'
        bool? showInlineWidget;
        if (showAdditionalWidget) {
          showInlineWidget = context.knobs.options(
            label: "Widget Alignment",
            options: const [
              Option(label: "Vertical", value: true),
              Option(label: "Horizontal", value: false),
            ],
            initial: false,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: InfoCard(
            title: context.knobs.text(label: "Title", initial: 'Warning'),
            type: InfoType.warning,
            description: context.knobs.text(
              label: "Description",
              initial:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.',
            ),
            inline: showInlineWidget ?? false,
            additionalWidgets: showAdditionalWidget || showInfoButton ? [
              if (showAdditionalWidget)
                ...List.generate(
                  5,
                  (_) => Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  ),
                ),
              if (showInfoButton)
                Column(
                  children: [
                    if (showInfoButton && showInlineWidget == true)
                      SizedBox(
                        height: 16,
                      ),
                    InfoButton(
                      size: DigitButtonSize.large,
                      label: 'Action Button',
                      onPressed: () {},
                      type: InfoDigitButtonType.warning,
                    ),
                  ],
                ),
            ] : null,
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Alert Card/Custom',
      builder: (context) {
        // First knob for controlling the visibility of the additional widget
        bool showAdditionalWidget = context.knobs.boolean(
          label: "Show Additional Widget",
          initial: false,
        );

        // Second knob for controlling the visibility of the info button
        bool showInfoButton = context.knobs.boolean(
          label: "Action",
          initial: false,
        );

        // Conditionally define the 'inline' option knob based on the value of 'showAdditionalWidget'
        bool? showInlineWidget;
        if (showAdditionalWidget) {
          showInlineWidget = context.knobs.options(
            label: "Widget Alignment",
            options: const [
              Option(label: "Vertical", value: true),
              Option(label: "Horizontal", value: false),
            ],
            initial: false,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: InfoCard(
            title: context.knobs.text(label: "Title", initial: 'Info'),
            type: InfoType.info,
            description: context.knobs.text(
              label: "Description",
              initial:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus eget ex in congue. Nullam finibus at urna et posuere.',
            ),
            inline: showInlineWidget ?? false,
            additionalWidgets: showAdditionalWidget || showInfoButton ? [
              if (showAdditionalWidget)
                ...List.generate(
                  5,
                      (_) => Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
                  ),
                ),
              if (showInfoButton)
                Column(
                  children: [
                    if (showInfoButton && showInlineWidget == true)
                      SizedBox(
                        height: 16,
                      ),
                    InfoButton(
                      size: DigitButtonSize.large,
                      label: 'Primary DigitButton',
                      onPressed: () {},
                      type: InfoDigitButtonType.info,
                    ),
                  ],
                ),
            ] : null,
          ),
        );
      },
    ),
  ];
}
