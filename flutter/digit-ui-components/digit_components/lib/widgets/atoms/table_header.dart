import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final List<String> headers;
  final bool withColumnDividers;

  const TableHeader({
    Key? key,
    required this.headers,
    this.withColumnDividers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    List<Widget> headerWidgets = [];

    for (int i = 0; i < headers.length; i++) {
      headerWidgets.add(
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: const DigitColors().light.genericBackground,
            child: Center(
              child: Text(
                headers[i],
                style: textTheme.headingS.copyWith(
                  color: theme.colorTheme.primary.primary2,
                )
              ),
            ),
          ),
        ),
      );
      //
      // if (withColumnDividers && i < headers.length - 1) {
      //   headerWidgets.add(const VerticalDivider(width: 1, color: Colors.grey));
      // }
    }

    return Row(
      children: headerWidgets,
    );
  }
}

