import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> panelStories() {
  return [
    Story(
      name: 'Atom/Panel/Success/default',
      builder: (context) =>  const Panel(type: PanelType.success, title: 'Success Message'),
    ),
    Story(
      name: 'Atom/Panel/Success/without animation',
      builder: (context) =>   Panel(type: PanelType.success, animate: false, title: 'Success Message', description: [Text('Ref ID', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: const DigitColors().light.paperPrimary), ), Text('949749795479', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: const DigitColors().light.paperPrimary),)],),
    ),
    Story(
      name: 'Atom/Panel/Success/animation repeat',
      builder: (context) =>   Panel(type: PanelType.success, repeat: true, title: 'Success Message', description: [Text('Ref ID', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: const DigitColors().light.paperPrimary), ), Text('949749795479', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: const DigitColors().light.paperPrimary),)],),
    ),



    Story(
      name: 'Atom/Panel/Error/default',
      builder: (context) =>  const Panel(type: PanelType.error, title: 'Error Message'),
    ),
    Story(
      name: 'Atom/Panel/Error/without animation',
      builder: (context) =>   Panel(type: PanelType.error, animate: false, title: 'Error Message', description: [Text('Ref ID', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: const DigitColors().light.paperPrimary),), Text('949749795479', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: const DigitColors().light.paperPrimary),)],),
    ),
    Story(
      name: 'Atom/Panel/Error/animation repeat',
      builder: (context) =>   Panel(type: PanelType.error, repeat: true, title: 'Error Message', description: [Text('Ref ID', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: const DigitColors().light.paperPrimary),), Text('949749795479', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: const DigitColors().light.paperPrimary),)],),
    ),
  ];
}