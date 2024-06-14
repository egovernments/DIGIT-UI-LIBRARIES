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
      name: 'Molecule/sideNav/light/default',
      builder: (context) => SideNavBar(
        type: SideNavType.light,
        navItems: [
          NavItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selectedIcon: Icons.home_filled),
          NavItem(
              icon: Icons.person_outline,
              title: 'Profile',
              selectedIcon: Icons.person),
          NavItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              selectedIcon: Icons.settings),
          // Add more items here
        ],
      ),
    ),
    Story(
      name: 'Molecule/sideNav/light/list of child',
      builder: (context) => SideNavBar(
        type: SideNavType.light,
        navItems: [
          NavItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selectedIcon: Icons.home_filled),
          NavItem(
              icon: Icons.person_outline,
              title: 'Profile',
              selectedIcon: Icons.person,
              children: [
                NavItem(icon: Icons.person_outline, title: 'profile1', selectedIcon: Icons.person),
                NavItem(icon: Icons.person_outline, title: 'profile2', selectedIcon: Icons.person),
              ]),
          NavItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              selectedIcon: Icons.settings,
              children: [
                NavItem(icon: Icons.person_outline, title: 'language', selectedIcon: Icons.person),
                NavItem(icon: Icons.person_outline, title: 'theme', selectedIcon: Icons.person),
              ]),
          // Add more items here
        ],
      ),
    ),
    Story(
      name: 'Molecule/sideNav/light/list of children',
      builder: (context) => SideNavBar(
        type: SideNavType.light,
        navItems: [
          NavItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selectedIcon: Icons.home_filled),
          NavItem(
              icon: Icons.person_outline,
              title: 'Profile',
              selectedIcon: Icons.person,
              children: [
                NavItem(icon: Icons.person, title: 'profile1', children: [
                  NavItem(icon: Icons.person_outline, title: 'logout', selectedIcon: Icons.person),
                  NavItem(icon: Icons.person_outline, title: 'save', selectedIcon: Icons.person),
                ]),
                NavItem(icon: Icons.settings, title: 'profile2', children: [
                  NavItem(icon: Icons.person_outline, title: 'logout', selectedIcon: Icons.person),
                  NavItem(icon: Icons.person_outline, title: 'save', selectedIcon: Icons.person),
                ]),
              ]),
          NavItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              selectedIcon: Icons.settings,
              children: [
                NavItem(icon: Icons.person_outline, title: 'language', selectedIcon: Icons.person),
                NavItem(icon: Icons.person_outline, title: 'theme', selectedIcon: Icons.person),
              ]),
          // Add more items here
        ],
      ),
    ),
    Story(
      name: 'Molecule/sideNav/dark/default',
      builder: (context) => SideNavBar(
        navItems: [
          NavItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selectedIcon: Icons.home_filled),
          NavItem(
              icon: Icons.person_outline,
              title: 'Profile',
              selectedIcon: Icons.person),
          NavItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              selectedIcon: Icons.settings),
          // Add more items here
        ],
      ),
    ),
    Story(
      name: 'Molecule/sideNav/dark/list of child',
      builder: (context) => SideNavBar(
        navItems: [
          NavItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selectedIcon: Icons.home_filled),
          NavItem(
              icon: Icons.person_outline,
              title: 'Profile',
              selectedIcon: Icons.person,
              children: [
                NavItem(icon: Icons.person_outline, title: 'profile1', selectedIcon: Icons.person),
                NavItem(icon: Icons.person_outline, title: 'profile2', selectedIcon: Icons.person),
              ]),
          NavItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              selectedIcon: Icons.settings,
              children: [
                NavItem(icon: Icons.person_outline, title: 'language', selectedIcon: Icons.person),
                NavItem(icon: Icons.person_outline, title: 'theme', selectedIcon: Icons.person),
              ]),
          // Add more items here
        ],
      ),
    ),
    Story(
      name: 'Molecule/sideNav/dark/list of children',
      builder: (context) => SideNavBar(
        navItems: [
          NavItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selectedIcon: Icons.home_filled),
          NavItem(
              icon: Icons.person_outline,
              title: 'Profile',
              selectedIcon: Icons.person,
              children: [
                NavItem(icon: Icons.person, title: 'profile1', children: [
                  NavItem(icon: Icons.person_outline, title: 'logout', selectedIcon: Icons.person),
                  NavItem(icon: Icons.person_outline, title: 'save', selectedIcon: Icons.person),
                ]),
                NavItem(icon: Icons.settings, title: 'profile2', children: [
                  NavItem(icon: Icons.person_outline, title: 'logout', selectedIcon: Icons.person),
                  NavItem(icon: Icons.person_outline, title: 'save', selectedIcon: Icons.person),
                ]),
              ]),
          NavItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              selectedIcon: Icons.settings,
              children: [
                NavItem(icon: Icons.person_outline, title: 'language', selectedIcon: Icons.person),
                NavItem(icon: Icons.person_outline, title: 'theme', selectedIcon: Icons.person),
              ]),
          // Add more items here
        ],
      ),
    ),
  ];
}
