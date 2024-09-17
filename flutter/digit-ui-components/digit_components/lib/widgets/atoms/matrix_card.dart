import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

// Custom Matrix Layout Widget
class MatrixList extends StatelessWidget {
  final List<Matrix> matrices;
  final int itemsPerRow;
  final bool isProgress;
  final bool showVerticalDivider;
  final double verticalDividerWidth; // Width of the vertical divider
  final double verticalDividerHeight; // Height of the vertical divider

  const MatrixList({
    super.key,
    required this.matrices,
    this.itemsPerRow = 2,
    this.isProgress = false,
    this.showVerticalDivider = true,
    this.verticalDividerWidth = 1.0,
    this.verticalDividerHeight = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < matrices.length; i += itemsPerRow) {
      final rowItems = matrices.sublist(
        i,
        i + itemsPerRow > matrices.length ? matrices.length : i + itemsPerRow,
      );

      List<Widget> rowWidgets = [];
      for (int j = 0; j < rowItems.length; j++) {
        // Add MatrixCard widget
        rowWidgets.add(
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: (j != rowItems.length - 1  && showVerticalDivider) ? 24 : 0.0,
                left: (j != 0 && showVerticalDivider) ? 24 : 0.0,
              ),
              child: MatrixCard(matrix: rowItems[j], isProgress: isProgress,),
            ),
          ),
        );

        // Add VerticalDivider if needed and not the last item
        if (showVerticalDivider && j < rowItems.length - 1) {
          rowWidgets.add(
            Container(
              width: verticalDividerWidth,
              height: 100,
              color: Colors.grey, // Adjust color as needed
            ),
          );
        }
      }

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowWidgets,
        ),
      );
    }

    return DigitCard(
      children: rows.map((row) {
        return Container(
          margin: EdgeInsets.only(bottom: verticalDividerWidth), // Adjust margin to match verticalDividerWidth
          child: row,
        );
      }).toList(),
    );
  }
}

class MatrixCard extends StatelessWidget {
  final Matrix matrix;
  final bool isProgress;

  MatrixCard({required this.matrix, this.isProgress = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    Color textColor;
    String statusText;

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
        if(!isProgress)
        Text(
          matrix.value,
          style: textTheme.headingM.copyWith(
            color: theme.colorTheme.text.primary,
          )
        ),
        if(!isProgress)
        SizedBox(height: 16),
        Text(
          matrix.description,
          style: textTheme.bodyS.copyWith(
            color: theme.colorTheme.text.secondary,
          )
        ),
        SizedBox(height: 16),
        isProgress
            ? ProgressIndicatorContainer(
          prefixLabel: matrix.description,
          suffixLabel: matrix.statusText,
          value: double.parse(matrix.value),
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ) : Row(
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
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              matrix.statusText ?? '',
              style: textTheme.bodyS.copyWith(
                color: textColor,
              )
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


class ProgressIndicatorContainer extends StatelessWidget {
  final String? prefixLabel;
  final String? suffixLabel;
  final double value;
  final Animation<Color?>? valueColor;

  const ProgressIndicatorContainer({
    super.key,
     this.prefixLabel,
     this.suffixLabel,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              LinearProgressIndicator(
                valueColor: valueColor ??
                    AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.onSurfaceVariant,
                    ),
                value: value,
                minHeight: 7.0,
              ),
              if(prefixLabel != null || suffixLabel != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(prefixLabel != null)
                    Text(
                      prefixLabel!,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    if(suffixLabel != null)
                    Text(
                      suffixLabel!,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
