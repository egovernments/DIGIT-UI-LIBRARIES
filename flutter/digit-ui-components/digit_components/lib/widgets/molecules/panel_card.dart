import 'package:digit_ui_components/constants/AppView.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/panels.dart';
import 'package:digit_ui_components/widgets/helper_widget/button_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../enum/app_enums.dart';

class PanelCard extends StatefulWidget {
  final PanelType type;
  final String title;
  final List<Text>? additionalDetails;
  final String? description;
  final List<Widget>? additionWidgets;
  final List<Button>? actions;
  final bool actionInline;

  const PanelCard({
    Key? key,
    required this.title,
    required this.type,
    this.additionalDetails,
    this.description,
    this.additionWidgets,
    this.actions,
    this.actionInline = true,
  }) : super(key: key);

  @override
  _PanelCardState createState() => _PanelCardState();
}

class _PanelCardState extends State<PanelCard> {
  final _scrollController = ScrollController();
  bool _isOverflowing = false;
  bool firstBuild = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildContent(
      DigitTypography currentTypography, bool isMobile, bool isTab) {
    Widget list = Padding(
      padding: EdgeInsets.only(
        left: isMobile
            ? 16
            : isTab
                ? 20
                : 24,
        right: isMobile
            ? 16
            : isTab
                ? 20
                : 24,
        top: _isOverflowing
            ? (isMobile
                ? 16
                : isTab
                    ? 20
                    : 24)
            : 0,
        bottom: !_isOverflowing && (widget.actions != null)
            ? 0
            : isMobile
                ? 16
                : isTab
                    ? 20
                    : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.description != null)
            Text(
              widget.description!,
              style: currentTypography.bodyS.copyWith(
                color: const DigitColors().light.textPrimary,
              ),
            ),
          if (widget.description != null && widget.additionWidgets != null)
            SizedBox(
              height: isMobile
                  ? 16
                  : isTab
                      ? 20
                      : 24,
            ),
          if (widget.additionWidgets != null)
            ...widget.additionWidgets!
                .asMap()
                .entries
                .map(
                  (widgets) => Padding(
                    padding: EdgeInsets.only(
                      bottom: widgets.key != widget.additionWidgets!.length - 1
                          ? (isMobile
                              ? 16
                              : isTab
                                  ? 20
                                  : 24)
                          : 0,
                    ),
                    child: widgets.value,
                  ),
                )
                .toList(),
        ],
      ),
    );

    return Flexible(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [list],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!firstBuild) {
      firstBuild = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (_scrollController.hasClients) {
            _isOverflowing = (_scrollController.position.maxScrollExtent > 0);
          }
        });
      });
    }
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const DigitColors().light.paperPrimary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.16),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: isMobile ?  EdgeInsets.only(bottom: widget.description!=null ? 16 : 0): EdgeInsets.all(
              isTab ? 20 :24,
            ),
            decoration: BoxDecoration(
              color: const DigitColors().light.paperPrimary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              boxShadow: _isOverflowing
                  ? [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(.16),
                        offset: const Offset(0, 1),
                        spreadRadius: 0,
                        blurRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Panel(
                type: widget.type,
                title: widget.title,
                description: widget.additionalDetails),
          ),
          if (widget.description != null || widget.additionWidgets != null)
            _buildContent(currentTypography, isMobile, isTab),
          if (widget.actions != null)
            Container(
              padding: EdgeInsets.only(
                left: isMobile
                    ? 16
                    : isTab
                        ? 20
                        : 24,
                right: isMobile
                    ? 16
                    : isTab
                        ? 20
                        : 24,
                top: _isOverflowing ||
                        (widget.additionWidgets != null ||
                            widget.description != null)
                    ? isMobile
                        ? 16
                        : isTab
                            ? 20
                            : 24
                    : 0,
                bottom: isMobile
                    ? 16
                    : isTab
                        ? 20
                        : 24,
              ),
              decoration: BoxDecoration(
                color: const DigitColors().light.paperPrimary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
                boxShadow: _isOverflowing
                    ? [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(.16),
                          offset: const Offset(0, -1),
                          spreadRadius: 0,
                          blurRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: widget.actionInline
                  ? Row(
                      mainAxisAlignment: isMobile
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: _buildInlineActions(isMobile, isTab),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _buildStackedActions(isMobile, isTab),
                    ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildInlineActions(bool isMobile, bool isTab) {
    if (widget.actions == null) {
      return [];
    }

    List<Button> primaryActions = widget.actions!
        .where((button) => button.type == ButtonType.primary)
        .toList();
    List<Button> secondaryActions = widget.actions!
        .where((button) => button.type != ButtonType.primary)
        .toList();

    return [
      ButtonListTile(
        spacing: isMobile ? 16 : isTab ? 20 : 24,
          buttons: [
        ...secondaryActions,
        ...primaryActions,
      ])
    ];
  }

  List<Widget> _buildStackedActions(bool isMobile, bool isTab) {
    if (widget.actions == null) {
      return [];
    }
    List<Widget> primaryActions = [];
    List<Widget> secondaryActions = [];
     primaryActions = widget.actions!
        .where((button) => button.type == ButtonType.primary)
        .toList();
    secondaryActions = widget.actions!
        .where((button) => button.type != ButtonType.primary)
        .toList();

    return [
      ...primaryActions
        ..asMap()
            .entries
            .map(
              (widgets) => Padding(
                padding: EdgeInsets.only(
                  bottom: widgets.key != primaryActions.length - 1
                      ? (isMobile
                          ? 16
                          : isTab
                              ? 20
                              : 24)
                      : 0,
                ),
                child: widgets.value,
              ),
            )
            .toList(),
      if(secondaryActions.isNotEmpty && primaryActions.isNotEmpty)
       SizedBox(
        height: isMobile? 16 : isTab ? 20 : 24,
      ),
      ...secondaryActions
          .asMap()
          .entries
          .map(
            (widgets) => Padding(
              padding: EdgeInsets.only(
                bottom: widgets.key != secondaryActions.length - 1
                    ? (isMobile
                        ? 16
                        : isTab
                            ? 20
                            : 24)
                    : 0,
              ),
              child: widgets.value,
            ),
          )
          .toList(),
    ];
  }
}
