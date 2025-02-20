import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> menuCardStories() {
  return [
    Story(
      name: 'Molecule/Menu Card/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Molecule/Menu Card/Basic',
      builder: (context) {

        final bool showIcon = context.knobs.boolean(label: 'Show Icon', initial: true);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: spacer6),
          child: MenuCard(
            icon: showIcon ? Icons.home : null,
            heading: context.knobs.text(label: 'Label', initial: 'Heading'),
            description: context.knobs.text(label: 'Description', initial: 'Lorem Ipsum'),
            onTap: () {
              // Handle tap
            },
          ),
        );
      }
    ),
  ];
}