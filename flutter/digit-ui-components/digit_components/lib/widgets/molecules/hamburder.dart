import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../helper_widget/digit_profile.dart';

class SideBar extends Drawer {
  final List<SidebarItem> sidebarItems;
  final Widget? profile;

  const SideBar({
    Key? key,
    required this.sidebarItems,
    this.profile,
  }) : super(key: key);

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
      child: Container(
        color: theme.colorTheme.paper.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                  ProfileWidget(
                  leading: profile,
                  title: 'John Doe',
                  description: '1234567890',
                ),
                const DigitDivider(),
                Column(
                  children: [
                    for (var i = 0; i < sidebarItems.length; i++)
                      Column(
                        children: [
                          ItemWidget(
                            title: sidebarItems[i].title,
                            icon: sidebarItems[i].icon,
                            onPressed: sidebarItems[i].onPressed,
                            index: i,
                            children: sidebarItems[i].children,
                          ),
                          const DigitDivider(), // Divider after each item
                        ],
                      ),
                  ],
                ),
              ],
            ),

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
                label: 'Logout',
                mainAxisSize: MainAxisSize.max,
                onPressed: () {
                  // Implement logout logic
                },
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
  final Function() onPressed;
  final int index;
  final List<SidebarItem>? children;

  const ItemWidget({
    Key? key,
    required this.title,
    this.icon,
    required this.onPressed,
    required this.index,
    this.children,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    Color backgroundColor = widget.index % 2 == 0
        ? theme.colorTheme.paper.secondary
        : theme.colorTheme.paper.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (widget.children != null) {
                _isExpanded = !_isExpanded;
              } else {
                widget.onPressed();
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
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
                    Icon(widget.icon ?? Icons.circle, size: 24, color: theme.colorTheme.primary.primary2,),
                    const SizedBox(width: 12),
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
         SideNavWithSearch(navItems: widget.children!),
      ],
    );
  }
}

class SideNavWithSearch extends StatelessWidget {
  final List<SidebarItem> navItems;

  const SideNavWithSearch({
    Key? key,
    required this.navItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DigitSearchFormInput(
            enableBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorTheme.text.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.zero,
            ),
            focusBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorTheme.primary.primary2,
                width: 1.5,
              ),
              borderRadius: BorderRadius.zero,
            ),
            controller: TextEditingController(),
          ),
        ),
        for (var item in navItems)
          ChildItemWidget(item: item),
      ],
    );
  }
}

class ChildItemWidget extends StatelessWidget {
  final SidebarItem item;

  const ChildItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return ListTile(
      leading: Icon(item.icon, color: theme.colorTheme.primary.primary2),
      title: Text(item.title, style: textTheme.headingS),
      onTap: () {
        // Handle navigation or expansion logic here
      },
    );
  }
}

// Define SidebarItem model class
class SidebarItem {
  final String title;
  final IconData icon;
  final Function() onPressed;
  final List<SidebarItem>? children;

  SidebarItem({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.children,
  });
}

