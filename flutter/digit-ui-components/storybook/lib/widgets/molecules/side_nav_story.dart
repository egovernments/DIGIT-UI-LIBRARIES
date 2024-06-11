import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_cart.dart';
import 'package:digit_ui_components/widgets/molecules/digit_side_nav.dart';
import 'package:digit_ui_components/widgets/molecules/pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> sideNavStories() {
  return [
    Story(
      name: 'Molecule/sideNav',
      builder: (context) =>  SideNavBar(
        navItems: [
          NavItem(icon: Icons.home, title: 'Home'),
          NavItem(icon: Icons.person, title: 'Profile'),
          NavItem(icon: Icons.settings, title: 'Settings'),
          // Add more items here
        ],
      ),
    ),
  ];
}
