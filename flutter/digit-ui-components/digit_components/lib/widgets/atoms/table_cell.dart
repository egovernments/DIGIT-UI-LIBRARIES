import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitTableCell extends StatelessWidget {
  final String data;
  final bool withColumnDividers;

  const DigitTableCell({
    Key? key,
    required this.data,
    this.withColumnDividers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Container(
      color: theme.colorTheme.paper.primary,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(data, style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary)),
            ),
          ),
          if (withColumnDividers)
            const VerticalDivider(width: 1, color: Colors.grey),
        ],
      ),
    );
  }
}

