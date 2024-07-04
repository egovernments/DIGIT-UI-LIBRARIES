import 'package:digit_ui_components/widgets/molecules/digit_table.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> tableStories() {
  return [
    Story(
      name: 'Molecule/Table/Variant 1',
      builder: (context) => CustomTable(
        headers: const ['Header 1', 'Header 2', 'Header 3'],
        rows: List.generate(
          40,
              (index) => ['Data ${index + 1}', 'More Data ${index + 1}', 'Extra Data ${index + 1}'],
        ),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 2',
      builder: (context) => CustomTable(
        withColumnDividers: true,
        headers: const ['Header 1', 'Header 2', 'Header 3'],
        rows: List.generate(
          40,
              (index) => ['Data ${index + 1}', 'More Data ${index + 1}', 'Extra Data ${index + 1}'],
        ),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 3',
      builder: (context) => CustomTable(
        withRowDividers: true,
        headers: const ['Header 1', 'Header 2', 'Header 3'],
        rows: List.generate(
          40,
              (index) => ['Data ${index + 1}', 'More Data ${index + 1}', 'Extra Data ${index + 1}'],
        ),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 4',
      builder: (context) => const CustomTable(
        headers: ['Header1', 'Header2', 'Header3'],
        rows: [
          ['Row1 Column1fdewfffffffffffffffffffffffffffffffffffffffff', 'Row1 Column2', 'Row1 Column3'],
          ['Row2 Column1', 'Row2 Column2', 'Row2 Column3'],
          // Add more rows here
        ],
        withColumnDividers: true,
        withRowDividers: true,
      ),
    ),
  ];
}
