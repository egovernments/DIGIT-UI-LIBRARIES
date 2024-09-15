import 'package:flutter/material.dart';

import 'landing_page_card.dart';

class MatrixListScrollComponent extends StatelessWidget {
  final List<MatrixListComponent> matrixListComponents;

  const MatrixListScrollComponent({
    Key? key,
    required this.matrixListComponents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Enable horizontal scrolling
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        children: matrixListComponents.map((matrixComponent) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.15, // Adjust card width as needed
            ),
            child: matrixComponent,
          );
        }).toList(),
      ),
    );
  }
}