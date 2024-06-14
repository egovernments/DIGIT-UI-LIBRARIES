import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../models/DropdownModels.dart';
import '../helper_widget/overlay_dropdown.dart';

class DigitFooter extends StatefulWidget {
  final List<FooterAction> actions;
  final double? actionSpacing;
  final MainAxisAlignment? actionAlignment;
  final bool? inlineAction;

  const DigitFooter({
    Key? key,
    required this.actions,
    this.actionSpacing,
    this.actionAlignment,
    this.inlineAction,
  }) : super(key: key);

  @override
  _DigitFooterState createState() => _DigitFooterState();
}

class _DigitFooterState extends State<DigitFooter> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? 16
              : isTab
              ? 20
              : 24,
          vertical: 16),
      decoration: BoxDecoration(
        color: const DigitColors().light.paperPrimary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.15),
            offset: const Offset(0, -1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: widget.inlineAction == true
          ? _buildHorizontalActions()
          : isMobile
          ? _buildVerticalActions()
          : _buildHorizontalActions(),
    );
  }

  Widget _buildVerticalActions() {
    List<Widget> actionWidgets = [];

    for (int i = 0; i < widget.actions.length; i++) {
      actionWidgets.add(
        widget.actions[i].dropdownItems != null
            ? OverlayDropdown(
          type: OverlayDropdownType.footer,
          items: widget.actions[i].dropdownItems!,
          title: widget.actions[i].button,
          onChange: (selectedItem) {
            if (widget.actions[i].onDropdownItemSelected != null) {
              widget.actions[i].onDropdownItemSelected!(selectedItem);
            }
          },
        )
            : widget.actions[i].button,
      );

      // Add a gap of 16 pixels between items
      if (i < widget.actions.length - 1) {
        actionWidgets.add(SizedBox(height: widget.actionSpacing ?? 16.0));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: actionWidgets,
    );
  }

  Widget _buildHorizontalActions() {
    List<Widget> actionWidgets = [];

    for (int i = 0; i < widget.actions.length; i++) {
      actionWidgets.add(
        widget.actions[i].dropdownItems != null
            ? OverlayDropdown(
          type: OverlayDropdownType.footer,
          items: widget.actions[i].dropdownItems!,
          title: widget.actions[i].button,
          onChange: (selectedItem) {
            if (widget.actions[i].onDropdownItemSelected != null) {
              widget.actions[i].onDropdownItemSelected!(selectedItem);
            }
          },
        )
            : widget.actions[i].button,
      );

      // Add a gap of 16 pixels between items
      if (i < widget.actions.length - 1) {
        actionWidgets.add(SizedBox(width: widget.actionSpacing ?? 16.0));
      }
    }

    return Row(
      mainAxisAlignment:
      widget.actionAlignment ?? MainAxisAlignment.spaceBetween,
      children: actionWidgets,
    );
  }
}

class FooterAction {
  final Button button;
  final List<DropdownItem>? dropdownItems;
  final void Function(DropdownItem)? onDropdownItemSelected;

  FooterAction({
    required this.button,
    this.dropdownItems,
    this.onDropdownItemSelected,
  });
}