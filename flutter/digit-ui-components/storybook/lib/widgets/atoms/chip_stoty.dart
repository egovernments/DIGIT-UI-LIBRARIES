import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/atoms/digit_info_card.dart';
import 'package:digit_ui_components/widgets/helper_widget/selection_chip.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> chipStories() {
  return [
    Story(
      name: 'Chip/default',
      builder: (context) => SelectionChip(
        label: context.knobs.text(label: 'chip label', initial: 'label'),
        onItemDelete: () {}
      )
    ),
    Story(
      name: 'Chip/error',
      builder: (context) => SelectionChip(
          label: context.knobs.text(label: 'chip label', initial: 'label'),
          onItemDelete: () {},
        errorMessage: context.knobs.text(label: 'Error Message', initial: 'this is error'),
      )
    ),
  ];
}
