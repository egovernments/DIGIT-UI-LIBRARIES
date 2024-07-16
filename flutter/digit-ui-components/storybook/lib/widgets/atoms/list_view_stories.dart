import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> listViewStories() {
  return [
    Story(
      name: 'Atom/List View/1',
      builder: (context) =>  LabelValueList(items: [
        LabelValuePair(label: context.knobs.text(label: 'Label', initial: 'label'), value:  context.knobs.text(label: 'value', initial: 'value'), isInline: true),
        LabelValuePair(label: context.knobs.text(label: 'Label2', initial: 'label'), value:  context.knobs.text(label: 'value2', initial: 'value'), isInline: false),
        LabelValuePair(label: context.knobs.text(label: 'Label3', initial: 'label'), value:  context.knobs.text(label: 'value3', initial: 'value'), isInline: true),
      ]),
    ),
    Story(
      name: 'Atom/List View/2',
      builder: (context) =>  LabelValueList(
        heading: 'Details',
          items: [
        LabelValuePair(label: context.knobs.text(label: 'Label', initial: 'label'), value:  context.knobs.text(label: 'value', initial: 'value'), isInline: true),
        LabelValuePair(label: context.knobs.text(label: 'Label2', initial: 'label'), value:  context.knobs.text(label: 'value2', initial: 'value'), isInline: false),
        LabelValuePair(label: context.knobs.text(label: 'Label3', initial: 'label'), value:  context.knobs.text(label: 'value3', initial: 'value'), isInline: true),
      ]),
    ),
    Story(
      name: 'Atom/List View/3',
      builder: (context) =>  LabelValueList(
        withDivider: true,
          items: [
        LabelValuePair(label: context.knobs.text(label: 'Label', initial: 'label'), value:  context.knobs.text(label: 'value', initial: 'value'), isInline: true),
        LabelValuePair(label: context.knobs.text(label: 'Label2', initial: 'label'), value:  context.knobs.text(label: 'value2', initial: 'value'), isInline: false),
        LabelValuePair(label: context.knobs.text(label: 'Label3', initial: 'label'), value:  context.knobs.text(label: 'value3', initial: 'value'), isInline: true),
      ]),
    ),
  ];
}