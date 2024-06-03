import 'package:digit_ui_components/widgets/atoms/list_view.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> listViewStories() {
  return [
    Story(
      name: 'Atom/List View',
      builder: (context) =>  LabelValueWidget(items: [
        LabelValuePair(label: context.knobs.text(label: 'Label', initial: 'label'), value:  context.knobs.text(label: 'Label', initial: 'value'), isInline: true),
        LabelValuePair(label: context.knobs.text(label: 'Label', initial: 'label'), value:  context.knobs.text(label: 'Label', initial: 'value'), isInline: true),
        LabelValuePair(label: context.knobs.text(label: 'Label', initial: 'label'), value:  context.knobs.text(label: 'Label', initial: 'value'), isInline: true),
      ]),
    ),
  ];
}
