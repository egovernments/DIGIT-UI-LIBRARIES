import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/helper_widget/button_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../atoms/panel.dart';

class PanelCard extends StatefulWidget {
  final PanelType type;
  final String title;
  final List<Text>? additionalDetails;
  final String? description;
  final List<Widget>? additionWidgets;
  final List<Button>? actions;
  final double? actionSpacing;
  final bool? inlineActions;
  final MainAxisAlignment? actionAlignment;
  final bool? animate;
  final bool? repeat;

  const PanelCard({
    Key? key,
    required this.title,
    required this.type,
    this.additionalDetails,
    this.description,
    this.additionWidgets,
    this.actions,
    this.inlineActions,
    this.actionSpacing,
    this.actionAlignment,
    this.animate,
    this.repeat,
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
            ? spacer4
            : isTab
                ? spacer5
                : spacer6,
        right: isMobile
            ? spacer4
            : isTab
                ? spacer5
                : spacer6,
        top: _isOverflowing
            ? (isMobile
                ? spacer4
                : isTab
                    ? spacer5
                    : spacer6)
            : 0,
        bottom: !_isOverflowing && (widget.actions != null)
            ? 0
            : isMobile
                ? spacer4
                : isTab
                    ? spacer5
                    : spacer6,
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
                  ? spacer4
                  : isTab
                      ? spacer5
                      : spacer6,
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
                              ? spacer4
                              : isTab
                                  ? spacer5
                                  : spacer6)
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
        borderRadius: BorderRadius.circular(spacer1),
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
            padding: isMobile
                ? EdgeInsets.only(
                    bottom: widget.description != null ||
                            widget.additionWidgets != null ||
                            widget.actions != null
                        ? spacer4
                        : 0)
                : EdgeInsets.all(
                    isTab ? spacer5 : spacer6,
                  ),
            decoration: BoxDecoration(
              color: const DigitColors().light.paperPrimary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(spacer1),
                  topRight: Radius.circular(spacer1)),
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
              description: widget.additionalDetails,
              animate: widget.animate ?? true,
              repeat: widget.repeat ?? false,
            ),
          ),
          if (widget.description != null || widget.additionWidgets != null)
            _buildContent(currentTypography, isMobile, isTab),
          if (widget.actions != null)
            Container(
                padding: EdgeInsets.only(
                  left: isMobile
                      ? spacer4
                      : isTab
                          ? spacer5
                          : spacer6,
                  right: isMobile
                      ? spacer4
                      : isTab
                          ? spacer5
                          : spacer6,
                  top: _isOverflowing ||
                          (widget.additionWidgets != null ||
                              widget.description != null)
                      ? isMobile
                          ? spacer4
                          : isTab
                              ? spacer5
                              : spacer6
                      : 0,
                  bottom: isMobile
                      ? spacer4
                      : isTab
                          ? spacer5
                          : spacer6,
                ),
                decoration: BoxDecoration(
                  color: const DigitColors().light.paperPrimary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(spacer1),
                      bottomRight: Radius.circular(spacer1)),
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
                child: ButtonListTile(
                  buttons: widget.actions!,
                  isVertical: widget.inlineActions != null
                      ? !widget.inlineActions!
                      : (isMobile ? true : false),
                  alignment: widget.actionAlignment ??
                      ((isMobile || isTab)
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end),
                  spacing: widget.actionSpacing ??
                      (isMobile
                          ? spacer4
                          : isTab
                              ? spacer5
                              : spacer6),
                )),
        ],
      ),
    );
  }
}
