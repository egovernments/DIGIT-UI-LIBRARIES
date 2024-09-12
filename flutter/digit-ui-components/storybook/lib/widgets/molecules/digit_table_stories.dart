import 'package:digit_ui_components/widgets/atoms/table_cell.dart';
import 'package:digit_ui_components/widgets/molecules/digit_table.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> tableStories() {
  return [
    Story(
      name: 'Molecule/Table/Variant 1',
      builder: (context) => CustomTable(
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers:
            context.knobs.boolean(label: 'With Column Dividers', initial: true),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A',
            type: ColumnType.text,
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'Column B',
            cellValue: 'second',
            isFrozen: true,
            type: ColumnType.text,
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Column C',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'Column D',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'fifth',
            header: 'Column E',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'six',
            header: 'Column F',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
        ],
        rows: [
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 1',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 2',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 3',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
  ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 4',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },  ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 2',
      builder: (context) => CustomTable(
        stickyHeader:
        context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
        context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
        context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers:
        context.knobs.boolean(label: 'With Column Dividers', initial: true),
        enableBorder:
        context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A',
            type: ColumnType.checkbox,
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'Column B',
            cellValue: 'second',
            type: ColumnType.text,
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Column C',
            type: ColumnType.dropDown,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'Column D',
            type: ColumnType.button,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'fifth',
            header: 'Column E',
            type: ColumnType.description,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'six',
            header: 'Column F',
            type: ColumnType.textField,
            //columnType: ColumnType.numeric,
          ),
        ],
        rows: [
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 1',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 1',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 2',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 2',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 3',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 3',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Row 4',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row 4',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },  ),
          ])
        ],
      ),
    ),
  ];
}
