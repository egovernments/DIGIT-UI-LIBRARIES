import 'package:digit_ui_components/widgets/atoms/table_cell.dart';
import 'package:digit_ui_components/widgets/molecules/digit_table.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> tableStories() {
  return [
    Story(
      name: 'Molecule/Table/Variant 1',
      builder: (context) => CustomTable(
        alternateRowColor: context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers: context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers:  context.knobs.boolean(label: 'With Column Dividers', initial: true),
        enableBorder: context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [TableColumn(
          header: 'Column A',
          //columnType: ColumnType.checkbox,
        ),
          TableColumn(
            header: 'Column B',
            //columnType: ColumnType.text,
          ),
          TableColumn(
            header: 'Column C',
            //columnType: ColumnType.numeric,
          ),],
        rows: List.generate(
          40,
          (index) => [
            CustomColumn(
              columnType: ColumnType.text,
              label: 'Columnsdffffffffffffffffffffffff A',
            ),
            CustomColumn(
              columnType: ColumnType.text,
              label: 'Colusdffffffffffffffffffffffffmn B', // Text data
            ),
            CustomColumn(
              columnType: ColumnType.text,
              label: 'Colsdffffffffffffffffffffffffffumn C',
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 2',
      builder: (context) => CustomTable(
        columns: [TableColumn(
          header: 'Select',
         // columnType: ColumnType.checkbox,
        ),
          TableColumn(
            header: 'Description',
            //columnType: ColumnType.text,
          ),
          TableColumn(
            header: 'Action',
           // columnType: ColumnType.numeric,
          ),],
        rows: List.generate(
          40,
          (index) => [
            CustomColumn(
              columnType: ColumnType.checkbox,
              value: index % 2 == 0,
              // Example checkbox value: true for even rows, false for odd rows
              label: 'Select',
              onCheckboxChanged: (newValue) {
                // Handle checkbox change
                print('Checkbox changed: $newValue');
              },
            ),
            CustomColumn(
              columnType: ColumnType.text,
              label: 'Data ${index + 1}', // Text data
            ),
            CustomColumn(
              columnType: ColumnType.textField,
              label: 'Button ${index + 1}', // Button label
              value: 'sdfksjjjjj',
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 3',
      builder: (context) => CustomTable(
        columns: [TableColumn(
          header: 'Select',
         // columnType: ColumnType.checkbox,
        ),
          TableColumn(
            header: 'Description',
           // columnType: ColumnType.text,
          ),
          TableColumn(
            header: 'Action',
           // columnType: ColumnType.numeric,
          ),],
        rows: List.generate(
          40,
          (index) => [
            CustomColumn(
              columnType: ColumnType.checkbox,
              value: index % 2 == 0,
              // Example checkbox value: true for even rows, false for odd rows
              label: 'Select',
              onCheckboxChanged: (newValue) {
                // Handle checkbox change
                print('Checkbox changed: $newValue');
              },
            ),
            CustomColumn(
              columnType: ColumnType.text,
              label: 'Data ${index + 1}', // Text data
            ),
            CustomColumn(
              columnType: ColumnType.dropDown,
              label: 'sdffffff',
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 4',
      builder: (context) => CustomTable(
        withRowDividers: true,
         columns: [TableColumn(
           header: 'Select',
           //columnType: ColumnType.checkbox,
         ),
           TableColumn(
             header: 'Description',
             //columnType: ColumnType.text,
           ),
           TableColumn(
             header: 'Action',
            isSortable: true
            // columnType: ColumnType.numeric,
           ),],
        rows: List.generate(
          40,
              (index) => [
            CustomColumn(
              columnType: ColumnType.checkbox,
              value: index % 2 == 0,
              label: 'Select ${index + 1}',
              onCheckboxChanged: (newValue) {
                print('Checkbox changed: $newValue');
              },
            ),
            CustomColumn(
              columnType: ColumnType.text,
              label: 'DataDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFGKJ;LDFGKLDJFLGKDFJGKLDFJGLDFKGJDFKLGJDFLKGJDFLKGJDFLKGJDFLKGJDFLKGJDFLKGJDFLKGJDFLKGJDFLKGJDFLKGJLDK ${index + 1}', // Text data
            ),
            CustomColumn(
              columnType: ColumnType.numeric,
              label: 'Button ${index + 1}', // Button label
              value: (index+100 - (index*2)),
            ),
          ],
        ),
      ),
    ),
  ];
}
