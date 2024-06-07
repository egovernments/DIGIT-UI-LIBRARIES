import 'package:digit_ui_components/blocs/AppLocalization.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_header.dart';
import 'package:digit_ui_components/widgets/atoms/stepper.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/widgets/atoms/action_card_story.dart';
import 'package:storybook/widgets/atoms/button_list_story.dart';
import 'package:storybook/widgets/atoms/buttons_story.dart';
import 'package:storybook/widgets/atoms/checkbox_story.dart';
import 'package:storybook/widgets/atoms/chip_stoty.dart';
import 'package:storybook/widgets/atoms/animated_toast_story.dart';
import 'package:storybook/widgets/atoms/digit_divider_story.dart';
import 'package:storybook/widgets/atoms/dropdown_story.dart';
import 'package:storybook/widgets/atoms/file_uploader_story.dart';
import 'package:storybook/widgets/atoms/footer_story.dart';
import 'package:storybook/widgets/atoms/header_story.dart';
import 'package:storybook/widgets/atoms/info_card_story.dart';
import 'package:storybook/widgets/atoms/input_field_story.dart';
import 'package:storybook/widgets/atoms/list_view_story.dart';
import 'package:storybook/widgets/atoms/panel_story.dart';
import 'package:storybook/widgets/atoms/pop_up_story.dart';
import 'package:storybook/widgets/atoms/radio_list_story.dart';
import 'package:storybook/widgets/atoms/stepper_story.dart';
import 'package:storybook/widgets/atoms/text_block_story.dart';
import 'package:storybook/widgets/atoms/timeline_story.dart';
import 'package:storybook/widgets/atoms/toggle_group_story.dart';
import 'package:storybook/widgets/molecules/digit_card_story.dart';
import 'package:storybook/widgets/molecules/header_molecule_story.dart';
import 'package:storybook/widgets/molecules/panel_card_story.dart';
import 'package:storybook/widgets/molecules/pop_up_story.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: [
      //   AppLocalization(locale, localizedStrings, languages),
      // ],

      theme: DigitTheme.instance.mobileTheme.copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: DigitTheme.instance.colorScheme.secondary,
          )),
      home: Scaffold(
        appBar: CustomHeader(
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Inspector(
          isEnabled: true,
          child: Storybook(

            initialStory: 'Screens/Scaffold',
            stories: [
              ...buttonStories(),
              ...checkboxStories(),
              ...chipStories(),
              ...textBlockStories(),
              ...infoCardStories(),
              ...timeLineStories(),
              ...inputFieldStories(),
              ...radioListStories(),
              ...toggleGroupStories(),
              ...dropdownStories(),
              ...stepperStories(),
              ...fileUploaderStories(),
              ...animatedToastStories(),
              ...cardStories(),
              ...popUpStories(),
              ...showPopUPStories(),
              ...actionStories(),
              ...panelStories(),
              ...panelCardStories(),
              ...buttonListStories(),
              ...headerStories(),
              ...footerStories(),
              ...headerMoleculeStories(),
              ...dividerStories(),
              ...listViewStories(),
            ],
            
          ),
        ),
      ),
    );
  }
}
