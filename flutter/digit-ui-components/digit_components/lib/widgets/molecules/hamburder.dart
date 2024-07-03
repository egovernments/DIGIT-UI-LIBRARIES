import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';

class CustomIconTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconTile({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onPressed,
    );
  }
}

class SideBar extends Drawer {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    return Drawer(
      width: 280,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 64,),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'John Doe', // Replace with actual user name
                      style: textTheme.headingS.copyWith(
                        color: theme.colorTheme.text.primary,
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      '1234567890', // Replace with actual user mobile number
                      style: textTheme.bodyS.copyWith(
                        color: theme.colorTheme.text.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const DigitDivider(),
              CustomIconTile(
                title: 'Home',
                icon: Icons.home,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Home
                },
              ),
              CustomIconTile(
                title: 'Language',
                icon: Icons.language,
                onPressed: () {
                  // Implement language change
                },
              ),
              CustomIconTile(
                title: 'Profile',
                icon: Icons.person,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Profile
                },
              ),
              CustomIconTile(
                title: 'View Downloaded Data',
                icon: Icons.download,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Downloaded Data
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorTheme.paper.secondary,
            child: Button(
              size: ButtonSize.medium,

              type: ButtonType.secondary,
              prefixIcon: Icons.logout,
              label: 'Logout',
              mainAxisSize: MainAxisSize.max,
              onPressed: () {
                // Implement logout logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
