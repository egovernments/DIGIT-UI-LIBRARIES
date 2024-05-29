import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/panels.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> panelStories() {
  return [
    Story(
      name: 'Atom/Panel/Success',
      builder: (context) =>  const Panel(type: PanelType.success, title: 'Success Message'),
    ),
    Story(
      name: 'Atom/Panel/Success1',
      builder: (context) =>   Panel(type: PanelType.success, title: 'Success Message', description: [Text('Ref ID', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: const DigitColors().light.paperPrimary), ), Text('949749795479', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: const DigitColors().light.paperPrimary),)],),
    ),
    Story(
      name: 'Atom/Panel/Error',
      builder: (context) =>  const Panel(type: PanelType.error, title: 'Error Message'),
    ),
    Story(
      name: 'Atom/Panel/Error1',
      builder: (context) =>   Panel(type: PanelType.error, title: 'Error Message', description: [Text('Ref ID', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: const DigitColors().light.paperPrimary),), Text('949749795479', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: const DigitColors().light.paperPrimary),)],),
    ),
  ];
}
