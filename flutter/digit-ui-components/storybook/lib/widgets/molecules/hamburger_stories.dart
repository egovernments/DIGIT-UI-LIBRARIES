import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/widgets/helper_widget/digit_profile.dart';
import 'package:digit_ui_components/widgets/molecules/hamburger.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';

import '../../iframe/iframe_widget.dart';

List<Story> hamBurgerStories() {
  return [
    Story(
      name: 'Molecule/HamBurger/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/HamBurger/Light',
      builder: (context) => Align(
        alignment: Alignment.topLeft,
        child: SideBar(
          logOutDigitButtonLabel: 'Log Out',
          profile: const ProfileWidget(
            title: 'John Doe',
            description: 'house number 5',
          ),
          sidebarItems: [
            SidebarItem(
                title: 'Home',
                icon: Icons.home,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Home
                },
                children: [
                  SidebarItem(
                    title: 'go to home',
                    onPressed: () {
                      print('go to home');
                    },
                  ),
                  SidebarItem(
                    title: 'log out',
                    onPressed: () {
                      print('log out');
                    },
                  ),
                ]),
            SidebarItem(
                title: 'Language',
                icon: Icons.language_sharp,
                isSearchEnabled: false,
                onPressed: () {
                  print('change language');
                },
                children: [
                  SidebarItem(
                    initiallySelected: true,
                    title: 'English',
                    onPressed: () {
                      print('enlish selected'
                      );
                    },
                  ),
                  SidebarItem(
                    title: 'Hindi',
                    onPressed: () {
                      print('hindi selected');
                    },
                  ),
                  SidebarItem(
                    title: 'French',
                    onPressed: () {
                      print('french selected');
                    },
                  ),
                  SidebarItem(
                    title: 'Spanish',
                    onPressed: () {
                      print('spanish selected');
                    },
                  ),
                ]),
            SidebarItem(
                title: 'Profile',
                icon: Icons.person,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Profile
                },
                children: [
                  SidebarItem(
                    title: 'Edit profile',
                    onPressed: () {
                      // Implement language change
                    },
                  ),
                  SidebarItem(
                    title: 'Logout',
                    onPressed: () {
                      // Implement language change
                    },
                  ),
                  SidebarItem(
                    title: 'Change password',
                    onPressed: () {
                      // Implement language change
                    },
                  ),
                ]),
            SidebarItem(
              title: 'View downloaded data',
              icon: Icons.download,
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to Downloaded Data
              },
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Molecule/HamBurger/Dark',
      builder: (context) => Align(
        alignment: Alignment.topLeft,
        child: SideBar(
          type: SidebarType.dark,
          logOutDigitButtonLabel: 'Log Out',
          profile: const ProfileWidget(
            type: SidebarType.dark,
            title: 'John Doe',
            description: 'house number 5',
          ),
          sidebarItems: [
            SidebarItem(
                title: 'Home',
                icon: Icons.home,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Home
                },
                children: [
                  SidebarItem(
                    title: 'go to home',
                    onPressed: () {
                      print('go to home');
                    },
                  ),
                  SidebarItem(
                    title: 'log out',
                    onPressed: () {
                      print('log out');
                    },
                  ),
                ]),
            SidebarItem(
                title: 'Language',
                icon: Icons.language_sharp,
                isSearchEnabled: false,
                onPressed: () {
                  print('change language');
                },
                children: [
                  SidebarItem(
                    initiallySelected: true,
                    title: 'English',
                    onPressed: () {
                      print('enlish selected'
                      );
                    },
                  ),
                  SidebarItem(
                    title: 'Hindi',
                    onPressed: () {
                      print('hindi selected');
                    },
                  ),
                  SidebarItem(
                    title: 'French',
                    onPressed: () {
                      print('french selected');
                    },
                  ),
                  SidebarItem(
                    title: 'Spanish',
                    onPressed: () {
                      print('spanish selected');
                    },
                  ),
                ]),
            SidebarItem(
                title: 'Profile',
                icon: Icons.person,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Profile
                },
                children: [
                  SidebarItem(
                    title: 'Edit profile',
                    onPressed: () {
                      // Implement language change
                    },
                  ),
                  SidebarItem(
                    title: 'Logout',
                    onPressed: () {
                      // Implement language change
                    },
                  ),
                  SidebarItem(
                    title: 'Change password',
                    onPressed: () {
                      // Implement language change
                    },
                  ),
                ]),
            SidebarItem(
              title: 'View downloaded data',
              icon: Icons.download,
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to Downloaded Data
              },
            ),
          ],
        ),
      ),
    ),
  ];
}