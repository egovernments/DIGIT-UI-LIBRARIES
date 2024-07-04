import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class TableFooter extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TableFooter({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const DigitColors().light.paperSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: currentPage > 1 ? onPrevious : null,
          ),
          Text('Page $currentPage of $totalPages'),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: currentPage < totalPages ? onNext : null,
          ),
        ],
      ),
    );
  }
}
