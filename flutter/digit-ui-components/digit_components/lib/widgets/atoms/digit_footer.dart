import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/helper_widget/button_list.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class CustomFooter extends StatelessWidget {
  final List<Button> actions;
  final double? actionSpacing;
  final MainAxisAlignment? actionAlignment;
  final bool? inlineAction;

  const CustomFooter({
    Key? key,
    required this.actions,
    this.actionSpacing,
    this.actionAlignment,
    this.inlineAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : isTab ? 20 : 24),
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
      child: ButtonListTile(
        buttons: actions,
        spacing: actionSpacing ?? (isMobile ? 16 : isTab ? 20 : 24),
        alignment: (actionAlignment ?? (isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center)),
        isVertical: inlineAction!=null ? !inlineAction! : isMobile ? true : false,
      )
    );
  }
}

