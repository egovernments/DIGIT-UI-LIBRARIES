

import 'package:digit_ui_components/widgets/molecules/side_nav_bar.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';

List<Story> sideNavStories() {
  return [
    Story(
      name: 'Molecule/Side Nav/light/default',
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
      name: 'Molecule/Side Nav/light/list of child',
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
      name: 'Molecule/Side Nav/light/list of children',
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
      name: 'Molecule/Side Nav/dark/default',
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
      name: 'Molecule/Side Nav/dark/list of child',
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
      name: 'Molecule/Side Nav/dark/list of children',
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
