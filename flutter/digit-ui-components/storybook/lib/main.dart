import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/models/toggleButtonModel.dart';
import 'package:digit_ui_components/utils/validators/validator.dart';
import 'package:digit_ui_components/widgets/atoms/digit_timeline.dart';
import 'package:digit_ui_components/widgets/atoms/stepper.dart';
import 'package:digit_ui_components/widgets/atoms/toast.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/widgets/atoms/buttons_story.dart';
import 'package:storybook/widgets/atoms/checkbox_story.dart';
import 'package:storybook/widgets/atoms/dropdown_story.dart';
import 'package:storybook/widgets/atoms/file_uploader_story.dart';
import 'package:storybook/widgets/atoms/info_card_story.dart';
import 'package:storybook/widgets/atoms/input_field_story.dart';
import 'package:storybook/widgets/atoms/radio_list_story.dart';
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
              ...toastStories(),
              ...infoCardStories(),
              ...timeLineStories(),
              ...inputFieldStories(),
              ...radioListStories(),
              ...toggleGroupStories(),
              ...dropdownStories(),
              // ...fileUploaderStories(),
            ],
          ),
        ),
      ),
    );
  }
}
