import 'package:flutter/material.dart';
import 'package:digit_ui_components/theme/ComponentTheme/digit_tag_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_tag.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> digitTagStories() {
  return [
    Story(
      name: 'Atom/Tags/Default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Tag label,
  type: TagType.monochrome,
  isStroke: false,
)
          ''');
        });

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Default'),
          type: TagType.monochrome,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Error',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Error Tag,
  type: TagType.error,
  isStroke: false,
  isIcon: false,
)
          ''');
        });

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Error'),
          type: TagType.error,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: context.knobs.boolean(label: 'Icon', initial: false),
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Warning',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Warning Tag,
  type: TagType.warning,
  isStroke: false,
  isIcon: false,
)
          ''');
        });

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Warning'),
          type: TagType.warning,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: context.knobs.boolean(label: 'Icon', initial: false),
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Success',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Success Tag,
  type: TagType.success,
  isStroke: false,
  isIcon: false,
)
          ''');
        });

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Success'),
          type: TagType.success,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
          isIcon: context.knobs.boolean(label: 'Icon', initial: false),
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Onclick',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Tag with click,
  type: TagType.monochrome,
  isStroke:false,
)
          ''');
        });

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Tag with Click'),
          type: TagType.monochrome,
          isStroke: context.knobs.boolean(label: 'Stroke', initial: false),
        );
      },
    ),
    Story(
      name: 'Atom/Tags/CustomIcon and TextStyle',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Custom background color and label style,
  customIcon: Icon(Icons.add),
  customTextStyle: TextStyle(color: Colors.red),
)
          ''');
        });

        return Tag(
          label: context.knobs.text(
              label: 'Label',
              initial: 'Custom background color and label style'),
          customIcon: Icon(Icons.add),
          customTextStyle: TextStyle(color: Colors.red),
        );
      },
    ),
    Story(
      name: 'Atom/Tags/Custom width',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Tag(
  label: Tag with Custom Width,
  themeData: TagThemeData().copyWith(tagWidth: 300),
)
          ''');
        });

        return Tag(
          label: context.knobs.text(label: 'Label', initial: 'Custom Width'),
          themeData: TagThemeData().copyWith(tagWidth: 300),
        );
      },
    ),
  ];
}
