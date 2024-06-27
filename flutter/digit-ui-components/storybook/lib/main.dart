import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/widgets/atoms/Info_card_stories.dart';
import 'package:storybook/widgets/atoms/action_card_stories.dart';
import 'package:storybook/widgets/atoms/back_button_stories.dart';
import 'package:storybook/widgets/atoms/bread_crumbs_stories.dart';
import 'package:storybook/widgets/atoms/button_list_stories.dart';
import 'package:storybook/widgets/atoms/button_stories.dart';
import 'package:storybook/widgets/atoms/checkbox_stories.dart';
import 'package:storybook/widgets/atoms/chip_stories.dart';
import 'package:storybook/widgets/atoms/divider_stories.dart';
import 'package:storybook/widgets/atoms/dropdown_stories.dart';
import 'package:storybook/widgets/atoms/flie_upload_stories.dart';
import 'package:storybook/widgets/atoms/input_field_stories.dart';
import 'package:storybook/widgets/atoms/panel_stories.dart';
import 'package:storybook/widgets/atoms/pop_up_card_stories.dart';
import 'package:storybook/widgets/atoms/radio_list_stories.dart';
import 'package:storybook/widgets/atoms/stepper_stories.dart';
import 'package:storybook/widgets/atoms/timeline_stories.dart';
import 'package:storybook/widgets/atoms/toast_stories.dart';
import 'package:storybook/widgets/atoms/toggle_stories.dart';
import 'package:storybook/widgets/molecules/card_stories.dart';
import 'package:storybook/widgets/molecules/footer_stories.dart';
import 'package:storybook/widgets/molecules/header_stories.dart';
import 'package:storybook/widgets/molecules/panel_card_stories.dart';
import 'package:storybook/widgets/molecules/show_pop_up_stories.dart';
import 'package:storybook/widgets/molecules/timeline_molecule_stories.dart';
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
      theme: DigitExtendedTheme.instance.getTheme(context).copyWith(

      ),
      home: Scaffold(
        body: Inspector(
          isEnabled: true,
          child: Storybook(

            initialStory: 'Screens/Scaffold',
            stories: [
              ...buttonStories(),
              ...checkboxStories(),
              ...chipStories(),
              ...infoCardStories(),
              ...panelStories(),
              ...timeLineStories(),
              ...inputFieldStories(),
              ...radioListStories(),
              ...toastStories(),
              ...toggleGroupStories(),
              ...dropdownStories(),
              ...stepperStories(),
              ...fileUploaderStories(),
              ...actionStories(),
              ...popUpStories(),
              ...panelCardStories(),
              ...cardStories(),
              ...dividerStories(),
              ...buttonListStories(),
              ...showPopUPStories(),
              ...footerMoleculeStories(),
              ...headerMoleculeStories(),
              ...breadCrumbStories(),
              ...backNavigationButtonStories(),
              ...timelineMoleculeStories(),
              ///...customStepperStories(),
            ],
          ),
        ),
      ),
    );
  }
}
