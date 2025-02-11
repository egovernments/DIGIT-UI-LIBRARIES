import 'package:collection/collection.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../helper_widget/digit_profile.dart';


class SideBar extends Drawer {
  final List<SidebarItem> sidebarItems;
  final List<SidebarItem>? footerActions;
  final Widget? footer;
  final ProfileWidget? profile;
  final SidebarType type;
  final String logOutDigitButtonLabel;
  final VoidCallback? onLogOut;

  const SideBar({
    Key? key,
    required this.sidebarItems,
    required this.logOutDigitButtonLabel,
    this.profile,
    this.type = SidebarType.light,
    this.footerActions,
    this.footer,
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
        color: type==SidebarType.dark ? theme.colorTheme.primary.primary2 : theme.colorTheme.paper.primary,
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
                                  type: type,
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
                    ...[
                      const DigitDivider(dividerType: DividerType.small),
                      ChildItemWidget(item: action, type: type,)
                    ],
                ],
              ),
            if(footer!=null) footer!,
            // Logout DigitButton at the bottom
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: theme.colorTheme.generic.divider,
                  width: 1,
                ),
                color: type == SidebarType.dark ? theme.colorTheme.primary.primary2 : theme.colorTheme.paper.primary,
              ),
              child: DigitButton(
                size: DigitButtonSize.medium,
                type: DigitButtonType.secondary,
                prefixIcon: Icons.logout,
                label: logOutDigitButtonLabel,
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
  final SidebarType type;
  final List<SidebarItem>? children;

  const ItemWidget({
    Key? key,
    required this.title,
    this.icon,
    this.isSearchEnabled = true,
    this.initiallySelected = false,
    required this.onPressed,
    required this.index,
    this.type = SidebarType.light,
    this.children,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool _isExpanded = false;
  bool _isSelected = false;
  final bool isHovering = false;
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

    final bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);



    Color backgroundColor  = _isSelected
        ? theme.colorTheme.primary.primaryBg
        : (widget.index % 2 == 0 || _isExpanded
        ? widget.type ==SidebarType.dark ? theme.colorTheme.primary.primary2 :theme.colorTheme.paper.secondary
        : widget.type ==SidebarType.dark ? theme.colorTheme.primary.primary2 : theme.colorTheme.paper.primary);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _handleItemTap,
          onHover: (isHovering) {
            setState(() {
              isHovering = isHovering;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isHovering ? theme.colorTheme.primary.primaryBg: backgroundColor,
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
                        color: widget.type == SidebarType.dark ? theme.colorTheme.paper.primary : theme.colorTheme.primary.primary2,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.title,
                      style: textTheme.headingS.copyWith(
                        color: widget.type == SidebarType.dark ? theme.colorTheme.paper.primary : theme.colorTheme.primary.primary2,
                      ),
                    ),
                  ],
                ),
                if (widget.children != null)
                  Icon(
                    _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: widget.type == SidebarType.dark ? theme.colorTheme.paper.primary :  theme.colorTheme.primary.primary2,
                  ),
              ],
            ),
          ),
        ),
        if (_isExpanded && widget.children != null)
          Padding(
            padding: EdgeInsets.only(left: isMobile ? 8 : 16),
            child: SideNavWithSearch(
              type: widget.type,
              navItems: widget.children!,
              isSearchEnabled: widget.isSearchEnabled,
              onChildSelected: _handleChildSelected, // Pass callback to children
              selectedItem: _selectedChild, // Pass selected item to children
            ),
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
  final SidebarType type;

  const SideNavWithSearch({
    Key? key,
    required this.navItems,
    this.isSearchEnabled = true,
    this.onChildSelected,
    this.selectedItem,
    this.type = SidebarType.light,
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
    if (widget.isSearchEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocusNode.requestFocus();
      });
    }
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
    final textTheme = Theme.of(context).digitTextTheme(context);


    return Column(
      children: [
        if (widget.isSearchEnabled)
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 16),
            child: DigitSearchFormInput(
              height: 32,
              textStyle: textTheme.bodyS.copyWith(
                color: widget.type ==SidebarType.dark ? theme.colorTheme.paper.primary :theme.colorTheme.text.primary,
              ),
              iconSize: 16,
              focusNode: searchFocusNode,
              controller: _searchController,
              enableBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:  widget.type ==SidebarType.dark ? theme.colorTheme.paper.primary :theme.colorTheme.generic.divider,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.zero,
              ),
              iconColor: widget.type ==SidebarType.dark ? theme.colorTheme.paper.primary : theme.colorTheme.primary.primary2,
              focusBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:  widget.type ==SidebarType.dark ? theme.colorTheme.paper.primary :theme.colorTheme.primary.primary2,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        if(_filteredItems.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16),
            child: Text(
              'No items found',
              style: theme.digitTextTheme(context).bodyS.copyWith(
                color: theme.colorTheme.text.disabled,
              ),
            ),
          ),
        if(_filteredItems.isNotEmpty)
          ..._filteredItems.map((item) => ChildItemWidget(
            type: widget.type,
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
  final SidebarType type;
  final bool isSelected; // Track selection state
  final ValueChanged<SidebarItem>? onChildSelected; // Callback to notify parent

  const ChildItemWidget({
    Key? key,
    required this.item,
    this.type = SidebarType.light,
    this.isSelected = false,
    this.onChildSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    final backgroundColor = isSelected
        ? type ==SidebarType.dark ? theme.colorTheme.primary.primary1  : theme.colorTheme.primary.primaryBg
        : type ==SidebarType.dark ? theme.colorTheme.primary.primary2 : theme.colorTheme.paper.primary;

    return InkWell(
      onTap: () {
        if (onChildSelected != null) {
          onChildSelected!(item); // Notify parent
        }
        item.onPressed();
      },
      child: Padding(
        padding: EdgeInsets.only(left: isSelected ? 18 : 20.0),
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
                    color:  type ==SidebarType.dark ? theme.colorTheme.paper.primary :const DigitColors().light.primary1,
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
                        color:  type ==SidebarType.dark ? theme.colorTheme.paper.primary :theme.colorTheme.primary.primary2,
                      ),
                    if (item.icon != null)
                      const SizedBox(width: 12),
                    Text(
                      item.title,
                      style: textTheme.headingS.copyWith(
                        color: type ==SidebarType.dark ? theme.colorTheme.paper.primary :theme.colorTheme.primary.primary2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

enum SidebarType {
  dark,
  light
}