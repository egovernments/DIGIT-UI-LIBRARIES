import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_chip.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> chipStories() {
  return [
    Story(
      name: 'Atom/Chip/Basic',
      builder: (context) {
        final withOnClick = context.knobs.boolean(label: 'Enable onClick', initial: false);
        return DigitChip(
          onClick: withOnClick ? () {} : null,
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
        );
      },
    ),
    Story(
      name: 'Atom/Chip/With Icon',
      builder: (context) {
        final withOnClick = context.knobs.boolean(label: 'Enable onClick', initial: false);
        return DigitChip(
          icon: Icons.check,
          onClick: withOnClick ? () {} : null,
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
        );
      },
    ),
    Story(
      name: 'Atom/Chip/With close',
      builder: (context) {
        final withOnClick = context.knobs.boolean(label: 'Enable onClick', initial: false);
        return DigitChip(
          onClick: withOnClick ? () {} : null,
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
          onItemDelete: (){},
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
