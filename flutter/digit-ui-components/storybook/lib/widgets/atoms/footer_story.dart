import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_footer.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> footerStories() {
  return [
    Story(
      name: 'Atom/Footer/1',
      builder: (context) => CustomFooter(
        actionAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Button(label: 'Next', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large, suffixIcon: Icons.arrow_forward,),
          Button(label: 'back', onPressed: (){}, type: ButtonType.secondary, size: ButtonSize.large, prefixIcon: Icons.arrow_back,),
        ],
      ),
    ),
    Story(
      name: 'Atom/Footer/2',
      builder: (context) => CustomFooter(
        actions: [
          Button(label: 'go to hcm campaign', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'go back to home', onPressed: (){}, type: ButtonType.secondary, size: ButtonSize.large,prefixIcon: Icons.arrow_back,),
        ],
      ),
    ),
    Story(
      name: 'Atom/Footer/3',
      builder: (context) => CustomFooter(
        actionAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Button(label: 'Go to home', onPressed: (){}, type: ButtonType.primary, size: ButtonSize.large),
          Button(label: 'Back', onPressed: (){}, type: ButtonType.secondary, size: ButtonSize.large,prefixIcon: Icons.arrow_back,),
        ],
      ),
    ),
  ];
}
