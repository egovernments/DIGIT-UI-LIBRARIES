import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/widgets/atoms/Info_card_stories.dart';
import 'package:storybook/widgets/atoms/action_card_stories.dart';
import 'package:storybook/widgets/atoms/button_stories.dart';
import 'package:storybook/widgets/atoms/checkbox_stories.dart';
import 'package:storybook/widgets/atoms/chip_stories.dart';
import 'package:storybook/widgets/atoms/dropdown_stories.dart';
import 'package:storybook/widgets/atoms/flie_upload_stories.dart';
import 'package:storybook/widgets/atoms/input_field_stories.dart';
import 'package:storybook/widgets/atoms/pop_up_card_stories.dart';
import 'package:storybook/widgets/atoms/radio_list_stories.dart';
import 'package:storybook/widgets/atoms/stepper_stories.dart';
import 'package:storybook/widgets/atoms/timeline_stories.dart';
import 'package:storybook/widgets/atoms/toast_stories.dart';
import 'package:storybook/widgets/atoms/toggle_stories.dart';
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
      theme: DigitTheme.instance.mobileTheme.copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: DigitTheme.instance.colorScheme.secondary,
          )),
      home: Scaffold(
        body: Inspector(
          isEnabled: true,
          child: Storybook(
            initialStory: 'Screens/Scaffold',
            stories: [
              ...buttonStories(),
              ...checkboxStories(),
              ...chipStories(),
              ...toastStories(),
              ...infoCardStories(),
              ...timeLineStories(),
              ...inputFieldStories(),
              ...radioListStories(),
              ...toggleGroupStories(),
              ...dropdownStories(),
              ...stepperStories(),
              ...fileUploaderStories(),
              ...actionStories(),
              ...popUpStories(),
            ],
          ),
        ),
      ),
    );
  }
}