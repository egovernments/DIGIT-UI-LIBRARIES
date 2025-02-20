import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';

import '../../iframe/iframe_widget.dart';

List<Story> listViewStories() {
  return [
    Story(
      name: 'Atom/Label Value Item/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Label Value Item/Text',
      builder: (context) {
        final label = context.knobs.text(label: 'Label', initial: 'Text Label');

        // Knob for a list of values
        final values = context.knobs.text(
          label: 'Values (comma-separated)',
          initial: 'Value1, Value2, Value3',
        );

        final valueList =
        values.split(',').map((s) => s.trim()).toList();

        return Center(
          child: LabelValueItem(
            label: label,
            value: valueList,
            isInline: context.knobs.boolean(label: 'Inline', initial: true),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Label Value Item/Image',
      builder: (context) {
        final label = context.knobs.text(label: 'Label', initial: 'Image Label');

        // Knob for a list of values
        final values = context.knobs.text(
          label: 'Values (comma-separated)',
          initial: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s, https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s',
        );

        final valueList =
        values.split(',').map((s) => s.trim()).toList();

        return Center(
          child: LabelValueItem(
            label: label,
            value: [
              for (var i = 0; i < valueList.length; i++)
                Container(
                  height: 50,
                  width: 50,
                  child: Image.network(height: 50, width: 50,fit: BoxFit.fill,valueList[i]),
                ),
            ],
            isInline: context.knobs.boolean(label: 'Inline', initial: true),
          ),
        );
      },
    ),
    Story(
      name: 'Atom/Label Value Item/Custom',
      builder: (context) {
        final label = context.knobs.text(label: 'Label', initial: 'Text Label');


        return Center(
          child: LabelValueItem(
            label: label,
            value: DigitButton(type: DigitButtonType.link,size: DigitButtonSize.small, label: 'Link to profile', onPressed: (){},mainAxisAlignment: MainAxisAlignment.start,),
            isInline: context.knobs.boolean(label: 'Inline', initial: true),
          ),
        );
      },
    ),
  ];
}
