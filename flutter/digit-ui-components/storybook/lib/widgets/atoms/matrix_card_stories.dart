import 'package:digit_ui_components/widgets/atoms/label_value_list.dart';
import 'package:digit_ui_components/widgets/atoms/matrix_card.dart';
import 'package:digit_ui_components/widgets/atoms/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';


List<Story> matrixCardStories() {
  return [
    Story(
      name: 'Molecule/Metric Card/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Molecule/Metric Card/Vertically Stacked',
      builder: (context) =>  MatrixList(
        direction: Axis.vertical,
        showItemDivider: context.knobs.boolean(label: 'Show Horizontal Divider', initial: true),
        showGroupDivider: context.knobs.boolean(label: 'Show Vertical Divider', initial: true),
        matrices: [
          Matrix(value: '10', description: 'Description 1', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: '20', description: 'Description 2', type: MatrixType.noProgress, statusText: 'Inactive'),
          Matrix(value: '30', description: 'Description 3', type: MatrixType.decrease, statusText: 'Closed'),
          Matrix(value: '40', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
          // Add more Matrix items here
        ],
      ),
    ),
    Story(
      name: 'Molecule/Metric Card/Horizontally Stacked',
      builder: (context) =>  MatrixList(
        showItemDivider: context.knobs.boolean(label: 'Show Vertical Divider', initial: true),
        showGroupDivider: context.knobs.boolean(label: 'Show Horizontal Divider', initial: true),
        direction: Axis.horizontal,
        matrices: [
          Matrix(value: '10', description: 'Description 1', type: MatrixType.progress, statusText: 'Active'),
          Matrix(value: '20', description: 'Description 2', type: MatrixType.noProgress, statusText: 'Inactive'),
          Matrix(value: '30', description: 'Description 3', type: MatrixType.decrease, statusText: 'Closed'),
          Matrix(value: '40', description: 'Description 4', type: MatrixType.progress, statusText: 'Active'),
          // Add more Matrix items here
        ],
      ),
    ),
  ];
}