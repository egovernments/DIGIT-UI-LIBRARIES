import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/theme/ComponentTheme/digit_tag_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_tag.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> digitTagStories() {
  return [
    Story(
      name: 'Atom/Tags/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components-v0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Basic',
      builder: (context) {
        final theme = Theme.of(context);

        final showIcon = context.knobs.boolean(label: 'Show Icon', initial: false);
        final enableOnClick = context.knobs.boolean(label: 'Enable OnClick', initial: false);

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Tag'),
          type: TagType.monochrome,
          onClick: enableOnClick
              ? () {}
              : null,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: showIcon,
          customIcon: showIcon ?  Icon(Icons.tag,color: theme.colorTheme.primary.primary2,
            size: 16,) : null, // Add icon if `showIcon` is true
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Success',
      builder: (context) {
        final showIcon = context.knobs.boolean(label: 'Show Icon', initial: false);
        final enableOnClick = context.knobs.boolean(label: 'Enable OnClick', initial: false);

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Success'),
          type: TagType.success,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: showIcon,
          onClick: enableOnClick
              ? () {}
              : null,
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Error',
      builder: (context) {
        final showIcon = context.knobs.boolean(label: 'Show Icon', initial: false);
        final enableOnClick = context.knobs.boolean(label: 'Enable OnClick', initial: false);

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Error'),
          type: TagType.error,
          onClick: enableOnClick
              ? () {}
              : null,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: showIcon,
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Warning',
      builder: (context) {

        final showIcon = context.knobs.boolean(label: 'Show Icon', initial: false);
        final enableOnClick = context.knobs.boolean(label: 'Enable OnClick', initial: false);

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Warning'),
          type: TagType.warning,
          onClick: enableOnClick
              ? () {}
              : null,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: showIcon,
        );
      },
    ),

    Story(
      name: 'Atom/Tags/Custom',
      builder: (context) {
        return Tag(
          customIcon: Icon(Icons.add),
          customTextStyle: TextStyle(color: Colors.red),
          label: context.knobs.text(label: 'Label', initial: 'Custom Width'),
          themeData: TagThemeData().copyWith(tagWidth: 300),
        );
      },
    ),
  ];
}
