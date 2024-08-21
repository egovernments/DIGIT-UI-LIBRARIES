import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> listViewStories() {
  return [
    Story(
      name: 'Atom/List View/1',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
LabelValueList(
  items: [
    LabelValuePair(
      label: label,
      value: value,
      isInline: true,
    ),
    LabelValuePair(
      label: label2,
      value: value2,
      isInline: false,
    ),
    LabelValuePair(
      label: label3,
      value: value3,
      isInline: true,
    ),
  ],
)
          ''');
        });

        return LabelValueList(
          items: [
            LabelValuePair(
              label: context.knobs.text(label: 'Label', initial: 'label'),
              value: context.knobs.text(label: 'value', initial: 'value'),
              isInline: true,
            ),
            LabelValuePair(
              label: context.knobs.text(label: 'Label2', initial: 'label'),
              value: context.knobs.text(label: 'value2', initial: 'value'),
              isInline: false,
            ),
            LabelValuePair(
              label: context.knobs.text(label: 'Label3', initial: 'label'),
              value: context.knobs.text(label: 'value3', initial: 'value'),
              isInline: true,
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/List View/2',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
LabelValueList(
  heading: 'Details',
  items: [
    LabelValuePair(
      label: label,
      value: value,
      isInline: true,
    ),
    LabelValuePair(
      label: label2,
      value: value2,
      isInline: false,
    ),
    LabelValuePair(
      label: label3,
      value: value3,
      isInline: true,
    ),
  ],
)
          ''');
        });

        return LabelValueList(
          heading: 'Details',
          items: [
            LabelValuePair(
              label: context.knobs.text(label: 'Label', initial: 'label'),
              value: context.knobs.text(label: 'value', initial: 'value'),
              isInline: true,
            ),
            LabelValuePair(
              label: context.knobs.text(label: 'Label2', initial: 'label'),
              value: context.knobs.text(label: 'value2', initial: 'value'),
              isInline: false,
            ),
            LabelValuePair(
              label: context.knobs.text(label: 'Label3', initial: 'label'),
              value: context.knobs.text(label: 'value3', initial: 'value'),
              isInline: true,
            ),
          ],
        );
      },
    ),
    Story(
      name: 'Atom/List View/3',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
LabelValueList(
  withDivider: true,
  items: [
    LabelValuePair(
      label: label,
      value: value,
      isInline: true,
    ),
    LabelValuePair(
      label: label2,
      value: value2,
      isInline: false,
    ),
    LabelValuePair(
      label: label3,
      value: value3,
      isInline: true,
    ),
  ],
)
          ''');
        });

        return LabelValueList(
          withDivider: true,
          items: [
            LabelValuePair(
              label: context.knobs.text(label: 'Label', initial: 'label'),
              value: context.knobs.text(label: 'value', initial: 'value'),
              isInline: true,
            ),
            LabelValuePair(
              label: context.knobs.text(label: 'Label2', initial: 'label'),
              value: context.knobs.text(label: 'value2', initial: 'value'),
              isInline: false,
            ),
            LabelValuePair(
              label: context.knobs.text(label: 'Label3', initial: 'label'),
              value: context.knobs.text(label: 'value3', initial: 'value'),
              isInline: true,
            ),
          ],
        );
      },
    ),
  ];
}
