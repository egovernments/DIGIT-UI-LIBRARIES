import 'dart:math';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_constants.dart';

typedef ExpansionChangedCallback = void Function(int index, bool isExpanded);


class SideNavBar extends StatefulWidget {
  final SideNavType type;
  final List<NavItem> navItems;

  const SideNavBar(
      {super.key, required this.navItems, this.type = SideNavType.dark});

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool isHovered = false;
  NavItem? selectedNavItem;
  Map<int, bool> isExpandedMap = {};

  @override
  Widget build(BuildContext context) {
    Color primary = widget.type == SideNavType.dark
        ? const DigitColors().light.paperPrimary
        : const DigitColors().light.primary2;
    Color background = widget.type == SideNavType.dark
        ? const DigitColors().light.primary2
        : const DigitColors().light.paperPrimary;

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
        width: isHovered ? 240 : widget.type == SideNavType.dark ? 48 : 50,
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          border: widget.type == SideNavType.light
              ? Border.all(
            width: 1.0,
            color: widget.type == SideNavType.light
                ? const DigitColors().light.genericDivider
                : const DigitColors().transparent,
          )
              : null,
          color: background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isHovered
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DigitSearchFormInput(
                enableBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.type == SideNavType.light
                        ? const DigitColors().light.textDisabled
                        : const DigitColors().light.paperPrimary,
                    width: 1.0,
                  ),
                  borderRadius: Common.radius,
                ),
                focusBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.type == SideNavType.light
                        ? const DigitColors().light.primary1
                        : const DigitColors().light.paperPrimary,
                    width: 1.5,
                  ),
                  borderRadius: Common.radius,
                ),
                iconColor: widget.type == SideNavType.light
                    ? const DigitColors().light.textSecondary
                    : const DigitColors().light.paperPrimary,
                controller: TextEditingController(),
              ),
            )
                : Center(
              child: Icon(
                Icons.search,
                size: 24,
                color: widget.type == SideNavType.light
                    ? const DigitColors().light.primary2
                    : const DigitColors().light.paperPrimary,
              ),
            ),
            SizedBox(height: isHovered ? 16 : 24),
            NavItemBuilder(
              navItems: widget.navItems,
              isHovered: isHovered,
              type: widget.type,
              selectedNavItem: selectedNavItem,
              onItemTapped: (navItem) {
                setState(() {
                  selectedNavItem = navItem;
                });
              },
              isExpandedMap: isExpandedMap,
              onExpansionChanged: (index, isExpanded) {
                setState(() {
                  isExpandedMap[index] = isExpanded;
                });
              },
            ),
            const Spacer(),
            if (isHovered) _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: widget.type == SideNavType.light
              ? const DigitColors().light.genericDivider
              : const DigitColors().transparent,
        ),
        color: widget.type == SideNavType.light
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.paperPrimary.withOpacity(.20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline,
                  color: widget.type == SideNavType.light
                      ? const DigitColors().light.primary2
                      : const DigitColors().light.paperPrimary,
                  size: 24),
              ...[
                const SizedBox(width: 10),
                Text('Help',
                    style: TextStyle(
                        color: widget.type == SideNavType.light
                            ? const DigitColors().light.primary2
                            : const DigitColors().light.paperPrimary)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.settings_accessibility,
                  color: widget.type == SideNavType.light
                      ? const DigitColors().light.primary2
                      : const DigitColors().light.paperPrimary,
                  size: 24),
              if (isHovered) ...[
                const SizedBox(width: 10),
                Text('Accessibility',
                    style: TextStyle(
                        color: widget.type == SideNavType.light
                            ? const DigitColors().light.primary2
                            : const DigitColors().light.paperPrimary)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.logout,
                  color: widget.type == SideNavType.light
                      ? const DigitColors().light.primary2
                      : const DigitColors().light.paperPrimary,
                  size: 24),
              if (isHovered) ...[
                const SizedBox(width: 10),
                Text('Logout',
                    style: TextStyle(
                        color: widget.type == SideNavType.light
                            ? const DigitColors().light.primary2
                            : const DigitColors().light.paperPrimary)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          const DigitDivider(thickness: .5),
          ...[
            const SizedBox(height: 16),
            isHovered
                ? Center(
                child: Image.asset(
                  'assets/images/powered_by_digit.png',
                  color: widget.type == SideNavType.light
                      ? const DigitColors().light.primary2
                      : const DigitColors().light.paperPrimary,
                  height: 12,
                ))
                : SvgPicture.asset(
              Common.digitIconSvg,
              height: 24,
            )
          ],
        ],
      ),
    );
  }
}

class NavItemBuilder extends StatefulWidget {
  final bool isHovered;
  final SideNavType type;
  final List<NavItem> navItems;
  final NavItem? selectedNavItem;
  final ValueChanged<NavItem> onItemTapped;
  final Map<int, bool> isExpandedMap;
  final ExpansionChangedCallback onExpansionChanged;

  const NavItemBuilder({
    Key? key,
    required this.navItems,
    this.type = SideNavType.dark,
    required this.isHovered,
    this.selectedNavItem,
    required this.onItemTapped,
    required this.isExpandedMap,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  _NavItemBuilderState createState() => _NavItemBuilderState();
}

class _NavItemBuilderState extends State<NavItemBuilder> {
  Map<int, bool> isHoveredMap = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < widget.navItems.length; i++)
          _buildNavItem(widget.navItems[i], -1, i),
      ],
    );
  }

  Widget _buildNavItem(NavItem navItem, int parentIndex, int index) {
    isHoveredMap.putIfAbsent(index, () => false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (navItem.children != null) {
                widget.isExpandedMap[index] =
                !(widget.isExpandedMap[index] ?? false);
                widget.onExpansionChanged(index, widget.isExpandedMap[index]!);
              } else {
                widget.onItemTapped(navItem);
              }
            });
          },
          onHover: (isHovered) {
            setState(() {
              isHoveredMap[index] = isHovered;
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              right: widget.isHovered ? 24 : 12,
            ),
            color: (widget.selectedNavItem == navItem ||
                isHoveredMap[index]! ||
                (_isParentOfSelected(navItem, widget.navItems) && !widget.isHovered))
                ? widget.type == SideNavType.light
                ? const DigitColors().light.primary1Bg
                : const DigitColors().light.paperPrimary.withOpacity(0.2)
                : Colors.transparent,
            child: Row(
              children: [
                if (widget.selectedNavItem == navItem || (_isParentOfSelected(navItem, widget.navItems) && !widget.isHovered))
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.primary1
                          : const DigitColors().light.paperPrimary,
                    ),
                  ),

                Container(
                  padding: EdgeInsets.only(
                    left: widget.isHovered
                        ? widget.selectedNavItem == navItem
                        ? 20
                        : 24
                        : widget.selectedNavItem == navItem || (_isParentOfSelected(navItem, widget.navItems) && !widget.isHovered)
                        ? 8
                        : 12,
                    top: 12,
                    bottom: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.selectedNavItem == navItem || (_isParentOfSelected(navItem, widget.navItems) && !widget.isHovered)
                            ? navItem.selectedIcon
                            : navItem.icon ?? Icons.folder,
                        color: widget.type == SideNavType.light
                            ? const DigitColors().light.primary2
                            : const DigitColors().light.paperPrimary,
                        size: 24,
                      ),
                      if (widget.isHovered) ...[
                        const SizedBox(width: 10),
                        Text(
                          navItem.title,
                          style: TextStyle(
                              color: widget.type == SideNavType.light
                                  ? const DigitColors().light.primary2
                                  : const DigitColors().light.paperPrimary),
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.isHovered) const Spacer(),
                if (navItem.children != null && widget.isHovered)
                  Transform.rotate(
                    angle: widget.isExpandedMap[index] == true ? 0 : -pi / 2,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.primary2
                          : const DigitColors().light.paperPrimary,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),
        /// Recursively build child NavItems if they exist and the parent is expanded
        if (navItem.children != null && widget.isHovered)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: widget.type == SideNavType.light
                        ? const DigitColors().light.genericDivider
                        : const DigitColors().light.paperPrimary,
                    width: 1.0,
                  ),
                  top: BorderSide.none,
                  bottom: BorderSide.none,
                  right: BorderSide.none,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < navItem.children!.length; i++)
                    if (widget.isExpandedMap[index] == true)
                      _buildNavItem(navItem.children![i], index, index * 10 + i),
                ],
              ),
            ),
          ),
      ],
    );
  }

  bool _isParentOfSelected(NavItem navItem, List<NavItem> originalNavItems) {
    /// Check if the current navItem is selected
    if (widget.selectedNavItem == navItem) {
      return true;
    }

    /// Recursively check all children of the current navItem
    if (navItem.children != null) {
      for (var child in navItem.children!) {
        if (_isParentOfSelected(child, originalNavItems)) {
          return true;
        }
      }
    }

    return false;
  }
}

class NavItem {
  final String title;
  final IconData? icon;
  final IconData? selectedIcon;
  final List<NavItem>? children;

  NavItem({required this.title, this.icon, this.selectedIcon, this.children});
}

enum SideNavType {
  dark,
  light,
}
