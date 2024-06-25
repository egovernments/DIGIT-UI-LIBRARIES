import 'package:digit_ui_components/widgets/atoms/digit_chip.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> chipStories() {
  return [
    Story(
        name: 'Atom/Chip/Default',
        builder: (context) => DigitChip(
            label: context.knobs.text(label: 'Chip label', initial: 'Label'),
            onItemDelete: () {}
        )
    ),
    Story(
        name: 'Atom/Chip/Error',
        builder: (context) => DigitChip(
          label: context.knobs.text(label: 'Chip label', initial: 'Label'),
          onItemDelete: () {},
          errorMessage: context.knobs.text(label: 'Error Message', initial: 'This is error'),
        )
    ),
    Story(
        name: 'Atom/Chip/With OnClick',
        builder: (context) => DigitChip(
          label: context.knobs.text(label: 'Chip label', initial: 'Chip with click'),
          onItemDelete: () {},
          onClick: (){},
        )
    ),
  ];
}