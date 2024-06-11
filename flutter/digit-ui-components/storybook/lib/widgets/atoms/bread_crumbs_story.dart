import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/bread_crumbs.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_cart.dart';
import 'package:digit_ui_components/widgets/molecules/digit_side_nav.dart';
import 'package:digit_ui_components/widgets/molecules/pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> breadCrumbStories() {
  return [
    Story(
      name: 'Atom/BreadCrumbs',
      builder: (context) =>  Breadcrumb(
        items: ['Home', 'Category', 'Product'],
        onTap: (index) {
          // Handle breadcrumb item tap
          print('Tapped on: ${index}');
        },
      ),
    ),
  ];
}
