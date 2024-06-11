import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class SideNavBar extends StatefulWidget {
  final List<NavItem> navItems;

  const SideNavBar({super.key, required this.navItems});

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool isHovered = false;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isHovered ? 240 : 48,
        color: const DigitColors().light.primary2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            isHovered
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DigitSearchFormInput(
                      enableBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const DigitColors().light.paperPrimary,
                          width: 1.0,
                        ),
                        borderRadius: Common.radius,
                      ),
                      focusBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const DigitColors().light.paperPrimary,
                          width: 1.0,
                        ),
                        borderRadius: Common.radius,
                      ),
                      iconColor: const DigitColors().light.paperPrimary,
                      controller: TextEditingController(),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: const DigitColors().light.paperPrimary,
                    ),
                  ),
            const SizedBox(height: 16),
            ...widget.navItems.asMap().entries.map((entry) =>
                _buildNavItem(entry.key, entry.value.icon, entry.value.title)),
            const Spacer(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(

        color: isSelected
            ? const DigitColors().light.paperPrimary.withOpacity(0.2)
            : Colors.transparent,
        child: Row(
          children: [
            if(isSelected)
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
                  color: isSelected
                  ? const DigitColors().light.paperPrimary
            : Colors.transparent,
              ),

            ),
            if(isSelected)
            const SizedBox(width: 8),
            Container(
              padding: isSelected ? const EdgeInsets.only(right: 12, top: 12, bottom: 12) : const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(icon, color: const DigitColors().light.paperPrimary, size: 24),
                  if (isHovered) ...[
                    const SizedBox(width: 10),
                    Text(title, style: const TextStyle(color: Colors.white)),
                  ],
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: const DigitColors().light.paperPrimary.withOpacity(.20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline,
                  color: const DigitColors().light.paperPrimary, size: 24),
              if (isHovered) ...[
                const SizedBox(width: 10),
                const Text('Help', style: TextStyle(color: Colors.white)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.settings_accessibility,
                  color: const DigitColors().light.paperPrimary, size: 24),
              if (isHovered) ...[
                const SizedBox(width: 10),
                const Text('Accessibility',
                    style: TextStyle(color: Colors.white)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.logout,
                  color: const DigitColors().light.paperPrimary, size: 24),
              if (isHovered) ...[
                const SizedBox(width: 10),
                const Text('Logout', style: TextStyle(color: Colors.white)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          // _buildNavItemBottom(Icons.help_outline, 'Help'),
          // _buildNavItemBottom(Icons.settings_accessibility, 'Accessibility'),
          // _buildNavItemBottom(Icons.logout, 'Logout'),
          const DigitDivider(thickness: .5),
          if (isHovered) ...[
            const SizedBox(height: 16),
            Center(
                child: Image.asset(
              'assets/images/powered_by_digit.png',
              color: const DigitColors().light.paperPrimary,
              height: 12,
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItemBottom(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: const DigitColors().light.paperPrimary, size: 24),
          if (isHovered) ...[
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(color: Colors.white)),
          ],
        ],
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String title;

  NavItem({required this.icon, required this.title});
}
