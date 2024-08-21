import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/digit_chip.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> chipStories() {
  return [
    Story(
      name: 'Atom/Chip/Default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitChip(
  label: Label,
  onItemDelete: () {},
)
          ''');
        });

        return DigitChip(
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
          onItemDelete: () {},
        );
      },
    ),
    Story(
      name: 'Atom/Chip/Error',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitChip(
  label: Label,
  onItemDelete: () {},
  errorMessage: This is error,
)
          ''');
        });

        return DigitChip(
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
          onItemDelete: () {},
          errorMessage: context.knobs
              .text(label: 'Error Message', initial: 'This is error'),
        );
      },
    ),
    Story(
      name: 'Atom/Chip/With OnClick',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitChip(
  label: Chip with click(see the log),
  onItemDelete: () {},
  onClick: () {
    ///
  },
)
          ''');
        });

        return DigitChip(
          label: context.knobs.text(
              label: 'Chip label', initial: 'Chip with click(see the log)'),
          onItemDelete: () {},
          onClick: () {
            context.logger.log('Chip clicked');
          },
        );
      },
    ),
  ];
}
