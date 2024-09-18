import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/matrix_card.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> matrixCardStories() {
  return [
    Story(
      name: 'Atom/Matrix Card/Vertical',
      builder: (context) =>  MatrixList(
        direction: Axis.vertical,
        matrices: [
          Matrix(value: 'Value 1', description: 'Description 1', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: 'Value 2', description: 'Description 2', type: MatrixType.noProgress, statusText: 'Inactive'),
          Matrix(value: 'Value 3', description: 'Description 3', type: MatrixType.decrease, statusText: 'Closed'),
          Matrix(value: 'Value 4', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
          // Add more Matrix items here
        ],
      ),
    ),
    Story(
      name: 'Atom/Matrix Card/Horizontal',
      builder: (context) =>  MatrixList(
        direction: Axis.horizontal,
        matrices: [
          Matrix(value: 'Value 1', description: 'Description 1', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: 'Value 2', description: 'Description 2', type: MatrixType.noProgress, statusText: 'Inactive'),
          Matrix(value: 'Value 3', description: 'Description 3', type: MatrixType.decrease, statusText: 'Closed'),
          Matrix(value: 'Value 4', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
          // Add more Matrix items here
        ],
      ),
    ),
    Story(
      name: 'Atom/Matrix Card/No Vertical Divider',
      builder: (context) =>  MatrixList(
        itemsPerGroup: 3,
        showVerticalDivider: false,
        matrices: [
          Matrix(value: 'Value 1', description: 'Description 1', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: 'Value 2', description: 'Description 2', type: MatrixType.noProgress, statusText: 'Inactive'),
          Matrix(value: 'Value 3', description: 'Description 3', type: MatrixType.decrease, statusText: 'Closed'),
          Matrix(value: 'Value 4', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: 'Value 1', description: 'Description 1', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: 'Value 2', description: 'Description 2', type: MatrixType.noProgress, statusText: 'Inactive'),
          Matrix(value: 'Value 3', description: 'Description 3', type: MatrixType.decrease, statusText: 'Closed'),
          Matrix(value: 'Value 4', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: 'Value 4', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
        ],
      ),
    ),
  ];
}