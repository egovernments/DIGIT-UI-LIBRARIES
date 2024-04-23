import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/widgets/atoms/buttons_story.dart';
import 'package:storybook/widgets/atoms/checkbox_story.dart';
import 'package:storybook/widgets/atoms/chip_stoty.dart';
import 'package:storybook/widgets/atoms/custom_toast_story.dart';
import 'package:storybook/widgets/atoms/dropdown_story.dart';
import 'package:storybook/widgets/atoms/file_uploader_story.dart';
import 'package:storybook/widgets/atoms/info_card_story.dart';
import 'package:storybook/widgets/atoms/input_field_story.dart';
import 'package:storybook/widgets/atoms/radio_list_story.dart';
import 'package:storybook/widgets/atoms/stepper_story.dart';
import 'package:storybook/widgets/atoms/timeline_story.dart';
import 'package:storybook/widgets/atoms/toast_story.dart';
import 'package:storybook/widgets/atoms/toggle_group_story.dart';
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
              // ...fileUploaderStories(),
              ...animatedToastStories(),
            ],
          ),
        ),
      ),
    );
  }
}
