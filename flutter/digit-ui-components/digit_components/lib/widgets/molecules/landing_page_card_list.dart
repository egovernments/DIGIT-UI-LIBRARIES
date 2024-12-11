import 'package:flutter/material.dart';

import '../../constants/AppView.dart';
import 'landing_page_card.dart';

class MatrixListScrollComponent extends StatelessWidget {
  final double? matrixWidth;
  final List<MatrixListComponent> matrixListComponents;

  const MatrixListScrollComponent({
    Key? key,
    this.matrixWidth,
    required this.matrixListComponents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Enable horizontal scrolling
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        children: matrixListComponents.map((matrixComponent) {
          return SizedBox(
            width: matrixWidth ?? 300,
            child: matrixComponent,
          );
        }).toList(),
      ),
    );
  }
}