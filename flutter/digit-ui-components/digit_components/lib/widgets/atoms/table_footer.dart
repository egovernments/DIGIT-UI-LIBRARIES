import 'dart:math';

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class TableFooter extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int rowsPerPage;
  final List<int> rowsPerPageOptions;
  final List<int>? pageOptions;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<int>? onPageChanged;
  final VoidCallback onNext;
  final Widget? footerWidget;
  final VoidCallback onPrevious;
  final ValueChanged<int> onPageSelected;
  final bool showRowsPerPage;
  final double width;

  const TableFooter({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.rowsPerPage,
    required this.rowsPerPageOptions,
    this.pageOptions,
    required this.onRowsPerPageChanged,
    this.onPageChanged,
    this.footerWidget,
    required this.onNext,
    required this.onPrevious,
    required this.onPageSelected,
    required this.width,
    this.showRowsPerPage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      width: min(width, MediaQuery.of(context).size.width),
      color: const DigitColors().light.paperSecondary,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(footerWidget != null) footerWidget!,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Conditional dropdown selector
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showRowsPerPage) ...[
                    const Text('Rows per page: '),
                    DropdownButton<int>(
                      value: rowsPerPage,
                      items: rowsPerPageOptions.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onRowsPerPageChanged(value);
                        }
                      },
                    ),
                  ],
                  if (!showRowsPerPage) ...[
                    const Text('Page: '),
                    DropdownButton<int>(
                      value: currentPage,
                      items: List.generate(totalPages, (index) {
                        int page = index + 1;
                        return DropdownMenuItem(
                          value: page,
                          child: Text(page.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null && onPageChanged != null) {
                          onPageChanged!(value);
                        }
                      },
                    ),
                  ],
                ],
              ),
              // Page navigation
              Row(
                children: [
                  if (showRowsPerPage) ...[
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: currentPage > 1 ? onPrevious : null,
                    ),
                    Text('Page $currentPage of $totalPages'),
                    IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: currentPage < totalPages ? onNext : null,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}