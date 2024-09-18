import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:digit_ui_components/widgets/molecules/digit_slider.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card.dart';
import 'package:digit_ui_components/widgets/molecules/landing_page_card_list.dart';
import 'package:digit_ui_components/widgets/molecules/language_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> sliderStories() {
  return [
    Story(
      name: 'Slider',
      builder: (context) => RightSideSlider(
        expandedContent: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Expanded Content"),
            ElevatedButton(
              onPressed: () {
                print("Action triggered!");
              },
              child: Text("Trigger Action"),
            ),
          ],
        ),
      ),
    ),
  ];
}
