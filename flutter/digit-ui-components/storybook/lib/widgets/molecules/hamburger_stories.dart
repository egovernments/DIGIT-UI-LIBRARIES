import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/widgets/helper_widget/digit_profile.dart';
import 'package:digit_ui_components/widgets/molecules/hamburger.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> hamBurgerStories() {
  return [
    Story(
      name: 'Molecule/HamBurger/Default',
      builder: (context) => SideBar(
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
                  icon: Icons.language,
                  onPressed: () {
                    print('go to home');
                  },
                ),
                SidebarItem(
                  title: 'log out',
                  icon: Icons.language,
                  onPressed: () {
                    print('log out');
                  },
                ),
              ]),
          SidebarItem(
              title: 'Language',
              icon: Icons.language,
              isSearchEnabled: false,
              onPressed: () {
                print('change language');
              },
              children: [
                SidebarItem(
                  initiallySelected: true,
                  title: 'English',
                  icon: Icons.language,
                  onPressed: () {
                    print('enlish selected'
                    );
                  },
                ),
                SidebarItem(
                  title: 'Hindi',
                  icon: Icons.language,
                  onPressed: () {
                    print('hindi selected');
                  },
                ),
                SidebarItem(
                  title: 'French',
                  icon: Icons.language,
                  onPressed: () {
                    print('french selected');
                  },
                ),
                SidebarItem(
                  title: 'Spanish',
                  icon: Icons.language,
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
                  title: 'Edit Profile',
                  icon: Icons.language,
                  onPressed: () {
                    // Implement language change
                  },
                ),
                SidebarItem(
                  title: 'Logout',
                  icon: Icons.language,
                  onPressed: () {
                    // Implement language change
                  },
                ),
                SidebarItem(
                  title: 'Change Password',
                  icon: Icons.language,
                  onPressed: () {
                    // Implement language change
                  },
                ),
              ]),
          SidebarItem(
            title: 'View Downloaded Data',
            icon: Icons.download,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Downloaded Data
            },
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/HamBurger/footer action',
      builder: (context) => SideBar(
        logOutDigitButtonLabel: 'Log Out',
        profile: const ProfileWidget(
          title: 'Bird',
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'), // Default image
          ),
        ),
        footerActions: [
          SidebarItem(
            title: 'upgrade app',
            icon: Icons.app_blocking,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        sidebarItems: [
          SidebarItem(
            title: 'Home',
            icon: Icons.home,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SidebarItem(
            title: 'Language',
            icon: Icons.language,
            onPressed: () {
              // Implement language change
            },
          ),
          SidebarItem(
            title: 'City',
            icon: Icons.person,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Profile
            },
          ),
          SidebarItem(
            title: 'View Downloaded Data',
            icon: Icons.download,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Downloaded Data
            },
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/HamBurger/3',
      builder: (context) => SideBar(
        logOutDigitButtonLabel: 'Log Out',
        profile: const ProfileWidget(
          title: 'John Doe',
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg'), // Default image
          ),
        ),
        sidebarItems: [
          SidebarItem(
            title: 'Home',
            icon: Icons.home,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Home
            },
          ),
          SidebarItem(
            title: 'Language',
            icon: Icons.language,
            onPressed: () {
              // Implement language change
            },
          ),
          SidebarItem(
            title: 'Modules',
            icon: Icons.view_module,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Profile
            },
          ),
          SidebarItem(
            title: 'View Downloaded Data',
            icon: Icons.download,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Downloaded Data
            },
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/HamBurger/4',
      builder: (context) => SideBar(
        logOutDigitButtonLabel: 'Log Out',
        sidebarItems: [
          SidebarItem(
            title: 'Home',
            icon: Icons.home,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SidebarItem(
            title: 'Language',
            icon: Icons.language,
            onPressed: () {
              // Implement language change
            },
          ),
          SidebarItem(
            title: 'Profile',
            icon: Icons.person,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Profile
            },
          ),
          SidebarItem(
            title: 'View Downloaded Data',
            icon: Icons.download,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Downloaded Data
            },
          ),
        ],
      ),
    ),
  ];
}