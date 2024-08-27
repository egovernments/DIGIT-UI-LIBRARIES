import 'package:collection/collection.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../helper_widget/digit_profile.dart';


class SideBar extends Drawer {
  final List<SidebarItem> sidebarItems;
  final List<SidebarItem>? footerActions;
  final ProfileWidget? profile;
  final String logOutButtonLabel;
  final VoidCallback? onLogOut;

  const SideBar({
    Key? key,
    required this.sidebarItems,
    required this.logOutButtonLabel,
    this.profile,
    this.footerActions,
    this.onLogOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: 280,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: theme.colorTheme.paper.primary,
        child: Column(
          children: [
            // Top content with profile and sidebar items
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (profile != null) profile!,
                  if (profile != null) const DigitDivider(dividerType: DividerType.small),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < sidebarItems.length; i++)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ItemWidget(
                                  title: sidebarItems[i].title,
                                  icon: sidebarItems[i].icon,
                                  onPressed: sidebarItems[i].onPressed,
                                  index: i,
                                  isSearchEnabled: sidebarItems[i].isSearchEnabled,
                                  initiallySelected: sidebarItems[i].initiallySelected,
                                  children: sidebarItems[i].children,
                                ),
                                const DigitDivider(dividerType: DividerType.small),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Optional footer actions
            if (footerActions != null && footerActions!.isNotEmpty)
              Column(
                children: [
                  for (var action in footerActions!)
                    ChildItemWidget(item: action),
                  const DigitDivider(dividerType: DividerType.small),
                ],
              ),
            // Logout button at the bottom
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: theme.colorTheme.generic.divider,
                  width: 1,
                ),
                color: theme.colorTheme.paper.primary,
              ),
              child: Button(
                size: ButtonSize.medium,
                type: ButtonType.secondary,
                prefixIcon: Icons.logout,
                label: logOutButtonLabel,
                mainAxisSize: MainAxisSize.max,
                onPressed: onLogOut != null ? onLogOut! : () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  final String title;
  final IconData? icon;
  final bool isSearchEnabled;
  final bool initiallySelected;
  final Function() onPressed;
  final int index;
  final List<SidebarItem>? children;

  const ItemWidget({
    Key? key,
    required this.title,
    this.icon,
    this.isSearchEnabled = true,
    this.initiallySelected = false,
    required this.onPressed,
    required this.index,
    this.children,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool _isExpanded = false;
  bool _isSelected = false;
  SidebarItem? _selectedChild; // Track selected child

  @override
  void initState() {
    super.initState();

    if (widget.children != null && widget.children!.any((child) => child.initiallySelected)) {
      _isExpanded = true;
    }
    _isSelected = widget.initiallySelected;
    if(widget.children != null && widget.children!.isNotEmpty) {
      _selectedChild = widget.children!.firstWhereOrNull((child) => child.initiallySelected);
    }
  }

  void _handleItemTap() {
    if (widget.children != null) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    } else {
      setState(() {
        _isSelected = true;
      });
      widget.onPressed();
    }
  }

  void _handleChildSelected(SidebarItem selectedItem) {
    setState(() {
      _selectedChild = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    Color backgroundColor  = _isSelected
        ? theme.colorTheme.primary.primaryBg
        : (widget.index % 2 == 0 || _isExpanded
        ? theme.colorTheme.paper.secondary
        : theme.colorTheme.paper.primary);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _handleItemTap,
          onHover: (isHovering) {
            setState(() {

            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.zero,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 24,
                        color: theme.colorTheme.primary.primary2,
                      ),
                      const SizedBox(width: 12),
                    ],
                    Text(
                      widget.title,
                      style: textTheme.headingS.copyWith(
                        color: theme.colorTheme.primary.primary2,
                      ),
                    ),
                  ],
                ),
                if (widget.children != null)
                  Icon(
                    _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: theme.colorTheme.primary.primary2,
                  ),
              ],
            ),
          ),
        ),
        if (_isExpanded && widget.children != null)
          SideNavWithSearch(
            navItems: widget.children!,
            isSearchEnabled: widget.isSearchEnabled,
            onChildSelected: _handleChildSelected, // Pass callback to children
            selectedItem: _selectedChild, // Pass selected item to children
          ),
      ],
    );
  }
}

class SideNavWithSearch extends StatefulWidget {
  final List<SidebarItem> navItems;
  final bool isSearchEnabled;
  final ValueChanged<SidebarItem>? onChildSelected; // Callback to notify parent
  final SidebarItem? selectedItem; // Track selected item

  const SideNavWithSearch({
    Key? key,
    required this.navItems,
    this.isSearchEnabled = true,
    this.onChildSelected,
    this.selectedItem,
  }) : super(key: key);

  @override
  _SideNavWithSearchState createState() => _SideNavWithSearchState();
}

class _SideNavWithSearchState extends State<SideNavWithSearch> {
  late TextEditingController _searchController;
  final FocusNode searchFocusNode = FocusNode();
  List<SidebarItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.navItems;

    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredItems = widget.navItems;
      } else {
        _filteredItems = widget.navItems.where((item) {
          return _containsSearchText(item);
        }).toList();
      }
    });
  }

  bool _containsSearchText(SidebarItem item) {
    if (item.title.toLowerCase().contains(_searchController.text.toLowerCase())) {
      return true;
    }

    if (item.children != null) {
      return item.children!.any(_containsSearchText);
    }

    return false;
  }

  void _handleChildSelected(SidebarItem selectedItem) {
    if (widget.onChildSelected != null) {
      widget.onChildSelected!(selectedItem); // Notify parent
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.isSearchEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocusNode.requestFocus();
      });
    }

    return Column(
      children: [
        if (widget.isSearchEnabled)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DigitSearchFormInput(
              focusNode: searchFocusNode,
              controller: _searchController,
              enableBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorTheme.generic.divider,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.zero,
              ),
              iconColor: theme.colorTheme.primary.primary2,
              focusBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorTheme.primary.primary2,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ..._filteredItems.map((item) => ChildItemWidget(
          item: item,
          isSelected: item == widget.selectedItem, // Pass selection state to ChildItemWidget
          onChildSelected: _handleChildSelected, // Pass callback to ChildItemWidget
        )).toList(),
      ],
    );
  }
}




class ChildItemWidget extends StatelessWidget {
  final SidebarItem item;
  final bool isSelected; // Track selection state
  final ValueChanged<SidebarItem>? onChildSelected; // Callback to notify parent

  const ChildItemWidget({
    Key? key,
    required this.item,
    this.isSelected = false,
    this.onChildSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    final backgroundColor = isSelected
        ? theme.colorTheme.primary.primaryBg
        : theme.colorTheme.paper.primary;

    return InkWell(
      onTap: () {
        if (onChildSelected != null) {
          onChildSelected!(item); // Notify parent
        }
        item.onPressed();
            },
      child: Container(
        height: 48,

        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.zero,
        ),
        child: Row(
          children: [
            if (isSelected)
              Container(
                width: 8,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  color: const DigitColors().light.primary1,
                ),
              ),
            if (isSelected) const SizedBox(width: 18,),
              Padding(
                padding:  EdgeInsets.only(right: 24, top: 12, bottom: 12, left: isSelected ? 0 : 24),
                child: Row(
                  children: [
                    if (item.icon != null)
                    Icon(
                      item.icon,
                      color: theme.colorTheme.primary.primary2,
                    ),
                    if (item.icon != null)
                    const SizedBox(width: 12),
                    Text(
                      item.title,
                      style: textTheme.headingS.copyWith(
                        color: theme.colorTheme.primary.primary2,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}



// Define SidebarItem model class
class SidebarItem {
  final String title;
  final IconData? icon;
  final Function() onPressed;
  final bool isSearchEnabled;
  final bool initiallySelected;
  final List<SidebarItem>? children;

  SidebarItem({
    required this.title,
    this.icon,
    required this.onPressed,
    this.initiallySelected = false,
    this.isSearchEnabled = true,
    this.children,
  });
}

