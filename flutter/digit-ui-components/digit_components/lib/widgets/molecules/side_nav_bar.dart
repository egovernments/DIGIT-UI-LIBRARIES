import 'dart:math';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_constants.dart';

typedef ExpansionChangedCallback = void Function(int index, bool isExpanded);

class SideNavBar extends StatefulWidget {
  final SideNavType type;
  final List<NavItem> navItems;

  const SideNavBar({
    super.key,
    required this.navItems,
    this.type = SideNavType.dark,
  });

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool isHovered = false;
  NavItem? selectedNavItem;
  Map<int, bool> isExpandedMap = {};
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primary = widget.type == SideNavType.dark
        ? const DigitColors().light.paperPrimary
        : const DigitColors().light.primary2;
    Color background = widget.type == SideNavType.dark
        ? const DigitColors().light.primary2
        : const DigitColors().light.paperPrimary;

    return Align(
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
            searchController.text = "";
            searchQuery = "";
          });
          _onSearchChanged();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isHovered
              ? 240
              : widget.type == SideNavType.dark
              ? 48
              : 50,
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
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHovered
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: DigitSearchFormInput(
                  controller: searchController,
                  textStyle: widget.type == SideNavType.light
                      ? Theme.of(context)
                      .digitTextTheme(context)
                      .bodyL
                      .copyWith(
                      color: const DigitColors().light.textPrimary)
                      : Theme.of(context)
                      .digitTextTheme(context)
                      .bodyL
                      .copyWith(
                      color:
                      const DigitColors().light.paperPrimary),
                  enableBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.textDisabled
                          : const DigitColors().light.paperPrimary,
                      width: 1.0,
                    ),
                    borderRadius: Base.radius,
                  ),
                  focusBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.primary1
                          : const DigitColors().light.paperPrimary,
                      width: 1.5,
                    ),
                    borderRadius: Base.radius,
                  ),
                  iconColor: widget.type == SideNavType.light
                      ? const DigitColors().light.primary2
                      : const DigitColors().light.paperPrimary,
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
                searchQuery: searchQuery,
              ),
              if (isHovered) _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    bool isAccessibilityHovered = false;
    bool isLogoutHovered = false;
    bool isHelpHovered = false;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: widget.type == SideNavType.light
                ? const DigitColors().light.genericDivider
                : const DigitColors().light.paperPrimary.withOpacity(.20),
          ),
          color: widget.type == SideNavType.light
              ? const DigitColors().light.paperPrimary
              : const DigitColors().light.paperPrimary.withOpacity(.20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() {
                isHelpHovered = true;
              }),
              onExit: (_) => setState(() {
                isHelpHovered = false;
              }),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                color: isHelpHovered
                    ? widget.type == SideNavType.light ? const DigitColors().light.primary1Bg: const DigitColors().light.paperPrimary.withOpacity(.2)
                    : null,
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.primary2
                          : const DigitColors().light.paperPrimary,
                      size: 24,
                    ),
                    ...[
                      const SizedBox(width: 10),
                      Text(
                        'Help',
                        style: TextStyle(
                          color: widget.type == SideNavType.light
                              ? const DigitColors().light.primary2
                              : const DigitColors().light.paperPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            MouseRegion(
              onEnter: (_) => setState(() {
                isAccessibilityHovered = true;
              }),
              onExit: (_) => setState(() {
                isAccessibilityHovered = false;
              }),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                color: isAccessibilityHovered
                    ? widget.type == SideNavType.light ? const DigitColors().light.primary1Bg: const DigitColors().light.paperPrimary.withOpacity(.2)
                    : null,
                child: Row(
                  children: [
                    Icon(
                      Icons.settings_accessibility,
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.primary2
                          : const DigitColors().light.paperPrimary,
                      size: 24,
                    ),
                    if (isHovered) ...[
                      const SizedBox(width: 10),
                      Text(
                        'Accessibility',
                        style: TextStyle(
                          color: widget.type == SideNavType.light
                              ? const DigitColors().light.primary2
                              : const DigitColors().light.paperPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            MouseRegion(
              onEnter: (_) => setState(() {
                isLogoutHovered = true;
              }),
              onExit: (_) => setState(() {
                isLogoutHovered = false;
              }),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                color: isLogoutHovered
                    ? widget.type == SideNavType.light ? const DigitColors().light.primary1Bg: const DigitColors().light.paperPrimary.withOpacity(.2)
                    : null,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: widget.type == SideNavType.light
                          ? const DigitColors().light.primary2
                          : const DigitColors().light.paperPrimary,
                      size: 24,
                    ),
                    if (isHovered) ...[
                      const SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: widget.type == SideNavType.light
                              ? const DigitColors().light.primary2
                              : const DigitColors().light.paperPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const DigitDivider(dividerType: DividerType.small),
            ...[
              const SizedBox(height: 16),
              if (isHovered)
                Center(
                  child: Image.asset(
                    'assets/images/powered_by_digit.png',
                    color: widget.type == SideNavType.light
                        ? const DigitColors().light.primary2
                        : const DigitColors().light.paperPrimary,
                    height: 12,
                  ),
                ),
            ],
          ],
        ),
      );
    });
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
  final String searchQuery;

  const NavItemBuilder({
    Key? key,
    required this.navItems,
    this.type = SideNavType.dark,
    required this.isHovered,
    this.selectedNavItem,
    required this.onItemTapped,
    required this.isExpandedMap,
    required this.onExpansionChanged,
    required this.searchQuery,
  }) : super(key: key);

  @override
  _NavItemBuilderState createState() => _NavItemBuilderState();
}

class _NavItemBuilderState extends State<NavItemBuilder> {
  Map<int, bool> isHoveredMap = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredNavItems = _filterNavItems(widget.navItems);

    return filteredNavItems.isNotEmpty
        ? Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < filteredNavItems.length; i++)
              _buildNavItem(filteredNavItems[i], -1, i),
          ],
        ),
      ),

    )
        : Flexible(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'No items found',
            style: theme.digitTextTheme(context).bodyS.copyWith(
              color: theme.colorTheme.text.disabled,
            ),
          ),
        ),
      ),
    );
  }

  List<NavItem> _filterNavItems(List<NavItem> items) {
    final List<NavItem> filteredItems = [];

    for (var item in items) {
      if (_matchesSearch(item)) {
        filteredItems.add(item);
      } else if (item.children != null &&
          item.children!.any((child) => _matchesSearch(child))) {
        filteredItems.add(item);
      }
    }

    return filteredItems;
  }

  bool _matchesSearch(NavItem item) {
    final itemTitle = item.title.toLowerCase() ?? '';
    return itemTitle.contains(widget.searchQuery);
  }

  Widget _buildNavItem(NavItem navItem, int parentIndex, int index) {
    isHoveredMap.putIfAbsent(index, () => false);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
                (_isParentOfSelected(navItem, widget.navItems) &&
                    !widget.isHovered))
                ? widget.type == SideNavType.light
                ? const DigitColors().light.primary1Bg
                : const DigitColors().light.paperPrimary.withOpacity(0.2)
                : Colors.transparent,
            child: Row(
              children: [
                if (widget.selectedNavItem == navItem ||
                    (_isParentOfSelected(navItem, widget.navItems) &&
                        !widget.isHovered))
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
                        : widget.selectedNavItem == navItem ||
                        (_isParentOfSelected(
                            navItem, widget.navItems) &&
                            !widget.isHovered)
                        ? 8
                        : 12,
                    top: widget.isHovered ? 16 : 8,
                    bottom: widget.isHovered ? 16 : 8,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.selectedNavItem == navItem ||
                            (_isParentOfSelected(
                                navItem, widget.navItems) &&
                                !widget.isHovered)
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

        if(!widget.isHovered)
          const SizedBox(height: 24,),

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
                      _buildNavItem(
                          navItem.children![i], index, index * 10 + i),
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