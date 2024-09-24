import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class MatrixList extends StatelessWidget {
  final List<Matrix> matrices;
  final int itemsPerGroup;
  final bool showVerticalDivider;
  final bool showGroupDivider; // New: for group divider
  final double verticalDividerWidth;
  final double verticalDividerHeight;
  final double groupDividerHeight; // New: for group divider height
  final Axis direction;

  const MatrixList({
    super.key,
    required this.matrices,
    this.itemsPerGroup = 2,
    this.showVerticalDivider = true,
    this.showGroupDivider = true,
    this.verticalDividerWidth = 1.0,
    this.verticalDividerHeight = 50.0,
    this.groupDividerHeight = 24.0,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? _buildHorizontalGroup(context)
        : _buildVerticalGroup(context);
  }

  // Method for building horizontal groups (rows)
  Widget _buildHorizontalGroup(BuildContext context) {
    final theme = Theme.of(context);
    final rows = <Widget>[];
    for (int i = 0; i < matrices.length; i += itemsPerGroup) {
      final rowItems = matrices.sublist(
        i,
        i + itemsPerGroup > matrices.length ? matrices.length : i + itemsPerGroup,
      );

      List<Widget> rowWidgets = [];
      for (int j = 0; j < rowItems.length; j++) {
        rowWidgets.add(
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: (j != rowItems.length - 1 || showVerticalDivider) ? 24 : 0.0,
                left: (j != 0 || showVerticalDivider) ? 24 : 0.0,
              ),
              child: MatrixCard(matrix: rowItems[j]),
            ),
          ),
        );

        // Add Vertical Divider if needed and not the last item
        if (showVerticalDivider && j < rowItems.length - 1) {
          rowWidgets.add(
            Container(
              width: 1,
              height: 100,
              color: theme.colorTheme.generic.divider, // Adjust color as needed
            ),
          );
        }
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowWidgets,
        ),
      );

      // Add group divider between rows if enabled
      if (showGroupDivider && i + itemsPerGroup < matrices.length) {
        rows.add(
          const DigitDivider(dividerType: DividerType.small),
        );
      }
    }

    return DigitCard(
      children: rows.map((row) {
        return Container(
          margin: EdgeInsets.only(bottom: verticalDividerWidth), // Adjust margin
          child: row,
        );
      }).toList(),
    );
  }

  // Method for building vertical groups (columns)
  Widget _buildVerticalGroup(BuildContext context) {
    final theme = Theme.of(context);
    final columns = <Widget>[];
    for (int i = 0; i < matrices.length; i += itemsPerGroup) {
      final columnItems = matrices.sublist(
        i,
        i + itemsPerGroup > matrices.length ? matrices.length : i + itemsPerGroup,
      );

      List<Widget> columnWidgets = [];
      for (int j = 0; j < columnItems.length; j++) {
        columnWidgets.add(
          Padding(
            padding: EdgeInsets.only(
              bottom: (j != columnItems.length - 1 && showVerticalDivider) ? 24 : 0.0,
              top: (j != 0 && showVerticalDivider) ? 24 : 0.0,
            ),
            child: MatrixCard(matrix: columnItems[j]),
          ),
        );

        // Add Horizontal Divider if needed and not the last item
        if (showVerticalDivider && j < columnItems.length - 1) {
          columnWidgets.add(
            const DigitDivider(dividerType: DividerType.small),
          );
        }
      }

      columns.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: columnWidgets,
        ),
      );

      // Add group divider between columns if enabled
      if (showGroupDivider && i + itemsPerGroup < matrices.length) {
        columns.add(
          Container(
            width: verticalDividerWidth,
            height: 260 ,
            color: theme.colorTheme.generic.divider, // Adjust color as needed
          ),
        );
      }
    }

    return DigitCard(
      inline: true,
      children: columns.map((column) {
        return Container(
          margin: EdgeInsets.only(right: verticalDividerWidth), // Adjust margin
          child: column,
        );
      }).toList(),
    );
  }
}

class MatrixCard extends StatelessWidget {
  final Matrix matrix;

  const MatrixCard({super.key, required this.matrix});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    Color textColor;

    switch (matrix.type) {
      case MatrixType.progress:
        textColor = theme.colorTheme.alert.success;
        break;
      case MatrixType.noProgress:
        textColor = theme.colorTheme.alert.info;
        break;
      case MatrixType.decrease:
        textColor = theme.colorTheme.alert.error;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          matrix.value,
          style: textTheme.headingM.copyWith(
            color: theme.colorTheme.primary.primary2,
          ),
        ),
        const SizedBox(height: spacer1),
        Text(
          matrix.description,
          style: textTheme.bodyS.copyWith(
            color: theme.colorTheme.text.secondary,
          ),
        ),
        const SizedBox(height: spacer1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              matrix.type == MatrixType.progress
                  ? Icons.arrow_upward
                  : matrix.type == MatrixType.noProgress
                  ? Icons.info
                  : Icons.arrow_downward,
              color: textColor,
              size: 16,
            ),
            const SizedBox(width: spacer1),
            Text(
              matrix.statusText ?? '',
              style: textTheme.bodyS.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Matrix {
  final String value;
  final String description;
  final MatrixType type;
  final String? statusText;

  Matrix({
    required this.value,
    required this.description,
    required this.type,
    this.statusText,
  });
}

enum MatrixType {
  progress,
  noProgress,
  decrease,
}
