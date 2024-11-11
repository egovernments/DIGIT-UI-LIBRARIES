import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class MatrixListComponent extends StatelessWidget {
  final IconData? icon;
  final String heading;
  final List<MatrixModel>? matrixList; // Matrix list is now optional
  final List<ActionItem>? actions;
  final bool filledIcon;
  final Widget? centerWidget;
  final Widget? additionalWidget;
  final bool alignCenterMatrixList;
  final bool showIconOnRight;

  const MatrixListComponent({
    Key? key,
    this.icon,
    required this.heading,
    this.matrixList,
    this.actions,
    this.centerWidget,
    this.additionalWidget,
    this.filledIcon = false,
    this.showIconOnRight = false,
    this.alignCenterMatrixList = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitCard(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: showIconOnRight && icon != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  if (!showIconOnRight && icon != null) _buildIcon(context),
                  if (!showIconOnRight && icon != null)
                    const SizedBox(width: spacer2),
                  if (!showIconOnRight && icon != null && filledIcon)
                    const SizedBox(width: spacer2),
                  Flexible(
                    child: Text(
                      heading,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headingM.copyWith(
                        color: theme.colorTheme.primary.primary2,
                      ),
                    ),
                  ),
                  if (showIconOnRight && icon != null)
                    const SizedBox(width: spacer2),
                  if (showIconOnRight && icon != null) _buildIcon(context),
                ],
              ),
            ),
            const SizedBox(height: spacer4),
            const DigitDivider(
              dividerType: DividerType.small,
            ),
            const SizedBox(height: spacer4),
            if (matrixList != null && matrixList!.isNotEmpty)
              _buildMatrixList(context),
            if (matrixList != null && matrixList!.isNotEmpty)
              const SizedBox(
                height: spacer4,
              ),
            if (matrixList != null && matrixList!.isNotEmpty)
              const DigitDivider(dividerType: DividerType.small),
            if (matrixList != null && matrixList!.isNotEmpty)
              const SizedBox(height: spacer4),
            if (centerWidget != null) ...[
              centerWidget!,
              const SizedBox(height: spacer4),
              const DigitDivider(dividerType: DividerType.small),
              const SizedBox(height: spacer4),
            ],
            if(actions != null && actions!.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 0; i < actions!.length; i++) ...[
                  ActionDigitButton(action: actions![i]),
                  if (i < actions!.length - 1) const SizedBox(height: spacer4),
                ],
              ],
            ),
            if (additionalWidget != null) ...[
              const SizedBox(height: spacer4),
              const DigitDivider(dividerType: DividerType.small),
              const SizedBox(height: spacer4),
              additionalWidget!,
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    final theme = Theme.of(context);

    bool isMobile = AppView.isMobileView(MediaQuery
        .of(context)
        .size);
    bool isTab = AppView.isTabletView(MediaQuery
        .of(context)
        .size);

    return Container(
      padding: const EdgeInsets.all(spacer2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: filledIcon
            ? theme.colorTheme.primary.primary1
            : theme.colorTheme.paper.primary,
      ),
      child: Icon(
        icon,
        color: filledIcon
            ? theme.colorTheme.paper.primary
            : theme.colorTheme.primary.primary1,
        size: isMobile
            ? 28
            : isTab
            ? 32
            : 40,
      ),
    );
  }

  Widget _buildMatrixList(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: matrixList!.asMap().entries.map((entry) {
        int index = entry.key;
        var matrix = entry.value;

        return Flexible(
          child: Padding(
            padding: EdgeInsets.only(right: index == matrixList!.length - 1 ? 0 : 16.0),
            child: Column(
              crossAxisAlignment: alignCenterMatrixList
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  matrix.title,
                  maxLines: 10,
                  textAlign: alignCenterMatrixList ? TextAlign.center : TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headingM.copyWith(
                    color: theme.colorTheme.text.primary,
                  ),
                ),

                Text(
                  matrix.description,
                  maxLines: 10,
                  textAlign: alignCenterMatrixList ? TextAlign.center : TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyXS.copyWith(
                    color: theme.colorTheme.text.secondary,
                  ),
                ),

              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

  class ActionItem {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  ActionItem({required this.label, this.icon, required this.onPressed});
}

class ActionDigitButton extends StatelessWidget {
  final ActionItem action;

  const ActionDigitButton({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitButtonTextTheme;
    return InkWell(
      hoverColor: const DigitColors().transparent,
      splashColor: const DigitColors().transparent,
      highlightColor: const DigitColors().transparent,
      onTap: action.onPressed,
      child: Row(
        children: [
          if (action.icon != null)
            Icon(
              action.icon,
              color: theme.colorTheme.primary.primary1,
              size: spacer5,
            ),
          if (action.icon != null)
            const SizedBox(
              width: spacer2,
            ),
          Text(
            action.label,
            style: textTheme.buttonM.copyWith(
              color: theme.colorTheme.primary.primary1,
            ),
          )
        ],
      ),
    );
  }
}

class MatrixModel {
  final String title;
  final String description;

  MatrixModel({required this.title, required this.description});
}
