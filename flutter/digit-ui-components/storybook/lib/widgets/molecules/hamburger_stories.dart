import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/hamburder.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> hamBurgerStories() {
  return [
    Story(
      name: 'Molecule/HamBurger',
      builder: (context) => const SideBar(),
    ),
  ];
}
