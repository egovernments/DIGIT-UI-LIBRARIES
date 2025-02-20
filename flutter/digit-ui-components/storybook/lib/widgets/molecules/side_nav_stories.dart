

import 'package:digit_ui_components/widgets/molecules/side_nav_bar.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:flutter/material.dart';

import '../../iframe/iframe_widget.dart';

List<Story> sideNavStories() {
  return [
    Story(
      name: 'Molecule/Side Nav/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Molecule/Side Nav/light',
      builder: (context){
        final bool enableSearch = context.knobs.boolean(label: 'Enable Search', initial: true);
        final bool bottomActions = context.knobs.boolean(label: 'Universal Actions', initial: true);

        return SideNavBar(
          enableSearch: enableSearch,
          bottomActions: bottomActions,
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
        );
      },
    ),
    Story(
      name: 'Molecule/Side Nav/dark',
      builder: (context){
        final bool enableSearch = context.knobs.boolean(label: 'Enable Search', initial: true);

        final bool bottomActions = context.knobs.boolean(label: 'Universal Actions', initial: true);

        return SideNavBar(
          enableSearch: enableSearch,
          bottomActions: bottomActions,
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
        );
      }
    ),
  ];
}
