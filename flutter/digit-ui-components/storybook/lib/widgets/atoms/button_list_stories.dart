import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_ui_components/widgets/helper_widget/button_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> buttonListStories() {
  return [
    Story(
      name: 'Atom/Button List/default',
      builder: (context) => ButtonListTile(
        buttons: [
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Atom/Button List/start',
      builder: (context) => ButtonListTile(
        alignment: MainAxisAlignment.start,
        buttons: [
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Atom/Button List/end',
      builder: (context) => ButtonListTile(
        alignment: MainAxisAlignment.end,
        buttons: [
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large)
        ],
      ),
    ),
    Story(
      name: 'Atom/Button List/space between',
      builder: (context) => ButtonListTile(
        alignment: MainAxisAlignment.spaceBetween,
        sortButtons: context.knobs.boolean(label: 'Sorted', initial: false),
        isVertical: context.knobs.boolean(label: 'Vertical', initial: false),
        buttons: [
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Secondary', onPressed: (){}, type: ButtonType.secondary, size: ButtonSize.large),
          Button(label: 'Tertiary', onPressed: (){}, type: ButtonType.tertiary, size: ButtonSize.large),
          Button(label: 'Link', onPressed: (){}, type: ButtonType.link, size: ButtonSize.large),
          Button(label: 'Primary', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Secondary', onPressed: (){}, type: ButtonType.secondary, size: ButtonSize.large),
        ],
      ),
    ),
  ];
}