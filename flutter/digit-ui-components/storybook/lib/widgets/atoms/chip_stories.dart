import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_chip.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import '../../iframe/iframe_widget.dart';

List<Story> chipStories() {
  return [
    Story(
      name: 'Atom/Chip/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Chip/Basic',
      builder: (context) {
        final bool withIcon = context.knobs.boolean(label: 'With Icon', initial: false);
        final bool withCloseIcon = context.knobs.boolean(label: 'With Close Icon', initial: false);
        final withOnClick = context.knobs.boolean(label: 'Enable onClick', initial: false);
        return DigitChip(
          icon: withIcon ? Icons.check : null,
          onClick: withOnClick ? () {} : null,
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
          onItemDelete: withCloseIcon ?(){} : null,
        );
      },
    ),
    Story(
      name: 'Atom/Chip/Error',
      builder: (context) {
        return DigitChip(
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
          onItemDelete: () {},
          errorMessage: context.knobs
              .text(label: 'Error Message', initial: 'This is error'),
        );
      },
    ),
  ];
}
