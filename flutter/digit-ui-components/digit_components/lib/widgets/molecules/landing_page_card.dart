import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class MatrixListComponent extends StatelessWidget {
  final IconData? icon;
  final String heading;
  final List<MatrixModel>? matrixList;  // Matrix list is now optional
  final List<ActionItem> actions;
  final bool filledIcon;
  final bool alignCenterMatrixList;
  final bool showIconOnRight;

  const MatrixListComponent({
    Key? key,
    this.icon,
    required this.heading,
    this.matrixList,
    required this.actions,
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
              height: 56,
              child: Row(
                mainAxisAlignment: showIconOnRight && icon != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  if (!showIconOnRight && icon != null) _buildIcon(),
                  if (!showIconOnRight && icon != null) const SizedBox(width: 8),
                  if(!showIconOnRight && icon != null && filledIcon) const SizedBox(width: 8),
                  Text(
                    heading,
                    style: textTheme.headingM.copyWith(
                      color: theme.colorTheme.primary.primary2,
                    ),
                  ),
                  if (showIconOnRight && icon != null) _buildIcon(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const DigitDivider(dividerType: DividerType.small,),
            const SizedBox(height: 16),
            if (matrixList != null && matrixList!.isNotEmpty)
              _buildMatrixList(context),
            if (matrixList != null && matrixList!.isNotEmpty)
              const SizedBox(height: 16,),
            if (matrixList != null && matrixList!.isNotEmpty)const DigitDivider(dividerType: DividerType.small),
            if (matrixList != null && matrixList!.isNotEmpty)
              const SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 0; i < actions.length; i++) ...[
                  ActionDigitButton(action: actions[i]),
                  if (i < actions.length - 1) SizedBox(height: 16), // Add gap between items
                ],
              ],
            )

          ],
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: filledIcon
            ? const DigitColors().light.primary1
            : const DigitColors().light.paperPrimary,
      ),
      child: Icon(
        icon,
        color: filledIcon
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.primary1,
        size: 40,
      ),
    );
  }

  Widget _buildMatrixList(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: matrixList!.map((matrix) {
        return Column(
          crossAxisAlignment: alignCenterMatrixList ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              matrix.title,
              style: textTheme.headingM.copyWith(
                color: theme.colorTheme.text.primary,
              ),
            ),
            Text(
                matrix.description,
                style: textTheme.bodyXS.copyWith(
                  color: theme.colorTheme.text.secondary,
                )
            ),
          ],
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
          if(action.icon != null)
            Icon(action.icon, color: theme.colorTheme.primary.primary1, size: 20,),
          if(action.icon != null)
            const SizedBox(width: spacer2,),
          Text(action.label, style: textTheme.buttonM.copyWith(
            color: theme.colorTheme.primary.primary1,
          ),)
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