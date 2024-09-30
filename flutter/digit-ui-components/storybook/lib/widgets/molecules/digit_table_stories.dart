import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/table_cell.dart';
import 'package:digit_ui_components/widgets/molecules/digit_table.dart';
import 'package:digit_ui_components/widgets/molecules/table_container.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> tableStories() {
  return [
    Story(
      name: 'Molecule/Table/Simple Table',
      builder: (context) => DigitTable(
        showPagination: false,
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: false),
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
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/Nested Table',
      builder: (context) => DigitTable(
        showExpandIconOnHover: context.knobs.boolean(label: 'Expand Icon', initial: true),
        showPagination: false,
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: false),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            header: 'Column B',
            cellValue: 'second',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Column C',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'Column D',
            type: ColumnType.text,
          ),
        ],
        rows: [
          DigitTableRow(
            tableRow: [
              DigitTableData(
                'Main Row 1',
                cellKey: 'first',
                callBack: (data) {
                  print(data);
                },
              ),
              DigitTableData(
                'Main Row 1',
                cellKey: 'second',
                callBack: (data) {
                  print(data);
                },
              ),
              DigitTableData(
                'Main Row 1',
                cellKey: 'third',
                callBack: (data) {
                  print(data);
                },
              ),
              DigitTableData(
                'Main Row 1',
                cellKey: 'forth',
                callBack: (data) {
                  print(data);
                },
              ),
            ],
            nestedTable: DigitTable(
              showPagination: false,
              enableBorder:true,
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
                  type: ColumnType.text,
                  //columnType: ColumnType.text,
                ),
                DigitTableColumn(
                  cellValue: 'third',
                  header: 'Column C',
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
                ])
              ],
            ),
          ),
          DigitTableRow(
            tableRow: [
              DigitTableData(
                'Main Row 2',
                cellKey: 'first',
                callBack: (data) {
                  print(data);
                },
              ),
              DigitTableData(
                'Main Row 2',
                cellKey: 'second',
                callBack: (data) {
                  print(data);
                },
              ),
              DigitTableData(
                'Main Row 2',
                cellKey: 'third',
                callBack: (data) {
                  print(data);
                },
              ),
              DigitTableData(
                'Main Row 2',
                cellKey: 'forth',
                callBack: (data) {
                  print(data);
                },
              ),
            ],
            nestedTable: DigitTable(
              stickyHeader: false,
              showPagination: false,
              enableBorder:true,
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
                  type: ColumnType.text,
                  //columnType: ColumnType.text,
                ),
                DigitTableColumn(
                  cellValue: 'third',
                  header: 'Column C',
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
                ])
              ],
            ),
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/Simple Table with long header and description',
      builder: (context) => DigitTable(
        showPagination: false,
        stickyHeader:
        context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
        context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
        context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
        context.knobs.boolean(label: 'Enable Border', initial: false),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A long header',
            type: ColumnType.text,
            description: 'Description for column A',
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'Column B long header',
            cellValue: 'second',
            type: ColumnType.text,
            description: 'Description for column B',
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Column C long header',
            type: ColumnType.text,
            description: 'Description for column C',
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'Column D long header',
            type: ColumnType.text,
            description: 'Description for column D',
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'fifth',
            header: 'Column E long header',
            type: ColumnType.text,
            description: 'Description for column E',
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'six',
            header: 'Column F long header',
            type: ColumnType.text,
            description: 'Description for column F',
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
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/Simple Table with no selection',
      builder: (context) => DigitTable(
        showSelectedState: false,
        showPagination: false,
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: false),
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
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/Simple Table with first row highlighted',
      builder: (context) => DigitTable(
        showPagination: false,
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: false),
        highlightedRows: const [0],
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
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/Simple Table with large list',
      builder: (context) => DigitTable(
        showPagination:
            context.knobs.boolean(label: 'Show Pagination', initial: true),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: false),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            header: 'Column B',
            cellValue: 'second',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Column C',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'Column D',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'fifth',
            header: 'Column E',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'six',
            header: 'Column F',
            type: ColumnType.text,
          ),
        ],
        rows: List.generate(100, (index) {
          return DigitTableRow(tableRow: [
            DigitTableData(
              'Row ${index + 1} A',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} B',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} C',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} D',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} E',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} F',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]);
        }),
      ),
    ),
    Story(
      name: 'Molecule/Table/Simple Table with large list with sorting',
      builder: (context) => DigitTable(
        showPagination:
        context.knobs.boolean(label: 'Show Pagination', initial: true),
        alternateRowColor:
        context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
        context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
        context.knobs.boolean(label: 'Enable Border', initial: false),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            header: 'Column B',
            cellValue: 'second',
            isSortable: true,
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Column C',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'Column D',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'fifth',
            header: 'Column E',
            type: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'six',
            header: 'Column F',
            type: ColumnType.text,
          ),
        ],
        rows: List.generate(100, (index) {
          return DigitTableRow(tableRow: [
            DigitTableData(
              '${index+1}',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} B',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} C',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} D',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} E',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} F',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]);
        }),
      ),
    ),
    Story(
      name: 'Molecule/Table/Simple Table with initial frozen column',
      builder: (context) => DigitTable(
        showSelectedState: false,
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: true),
        showPagination: true,
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Column A',
            isFrozen: true,
            type: ColumnType.text,
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
        showRowsPerPage: false,
        rows: List.generate(5, (index) {
          return DigitTableRow(tableRow: [
            DigitTableData(
              'Row ${index + 1} A',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} B',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} C',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} D',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} E',
              cellKey: 'fifth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Row ${index + 1} F',
              cellKey: 'six',
              callBack: (data) {
                print(data);
              },
            ),
          ]);
        }),
      ),
    ),
    Story(
      name: 'Molecule/Table/Variant 2',
      builder: (context) => DigitTable(
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'c',
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
            type: ColumnType.DigitButton,
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
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/figma1',
      builder: (context) => DigitTable(
        showPagination: false,
        stickyHeader:
            context.knobs.boolean(label: 'Sticky Header', initial: false),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        withColumnDividers: context.knobs
            .boolean(label: 'With Column Dividers', initial: false),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Lorem Ipsum',
            type: ColumnType.text,
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'Sr no',
            cellValue: 'second',
            type: ColumnType.numeric,
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'Lorem Ipsum',
            type: ColumnType.dropDown,
            //columnType: ColumnType.numeric,
          ),
        ],
        rows: [
          DigitTableRow(tableRow: [
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              '1',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              '2',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              '3',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              '4',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'Lorem Ipsum',
              cellKey: 'third',
              callBack: (data) {
                print(data);
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/figma2',
      builder: (context) => DigitTable(
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Sr No',
            type: ColumnType.numeric,
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'Select',
            cellValue: 'second',
            type: ColumnType.checkbox,
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'profile',
            header: 'Column C',
          ),
          DigitTableColumn(
            cellValue: 'Description',
            header: 'Column D',
            type: ColumnType.description,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'Suffix',
            header: 'Column E',
          ),
          DigitTableColumn(
            cellValue: 'Date',
            header: 'Column F',
          ),
          DigitTableColumn(
            cellValue: 'Switch',
            header: 'Column E',
            type: ColumnType.switchs,
          ),
          DigitTableColumn(
            cellValue: 'Status',
            header: 'Column F',
            type: ColumnType.tags,
          ),
          DigitTableColumn(
            cellValue: 'Link',
            header: 'Column E',
          ),
          DigitTableColumn(
            cellValue: 'Status',
            header: 'Action',
          ),
        ],
        rows: [
          DigitTableRow(tableRow: [
            DigitTableData(
              '1',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              '2',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: InkWell(
                  onTap: () {
                    print('tapped');
                  },
                  child: const Row(children: [
                    Icon(Icons.account_circle),
                    Text('Lorem Ipsum'),
                  ]),
                )),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {
                    print('button pressed');
                  },
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              '3',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              '4',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              '5',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/figma3',
      builder: (context) => DigitTable(
        isCustomRowFixed: true,
        customRow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'total count',
                style: Theme.of(context).digitTextTheme(context).headingS,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '400',
                style: Theme.of(context).digitTextTheme(context).headingS,
              ),
            ),
          ],
        ),
        alternateRowColor:
            context.knobs.boolean(label: 'Alternate Row Color', initial: false),
        withRowDividers:
            context.knobs.boolean(label: 'With Row Dividers', initial: true),
        enableBorder:
            context.knobs.boolean(label: 'Enable Border', initial: true),
        columns: [
          DigitTableColumn(
            cellValue: 'first',
            header: 'Sr No',
            type: ColumnType.numeric,
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'Select',
            cellValue: 'second',
            type: ColumnType.checkbox,
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'profile',
            header: 'Column C',
          ),
          DigitTableColumn(
            cellValue: 'Description',
            header: 'Column D',
            type: ColumnType.description,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'Suffix',
            header: 'Column E',
          ),
          DigitTableColumn(
            cellValue: 'Date',
            header: 'Column F',
          ),
          DigitTableColumn(
            cellValue: 'Switch',
            header: 'Column E',
            type: ColumnType.switchs,
          ),
          DigitTableColumn(
            cellValue: 'Status',
            header: 'Column F',
            type: ColumnType.tags,
          ),
          DigitTableColumn(
            cellValue: 'Link',
            header: 'Column E',
          ),
          DigitTableColumn(
            cellValue: 'Status',
            header: 'Action',
          ),
        ],
        rows: [
          DigitTableRow(tableRow: [
            DigitTableData(
              '1',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              '1',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
          DigitTableRow(tableRow: [
            DigitTableData(
              '1',
              cellKey: 'first',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'value',
              cellKey: 'second',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('', cellKey: 'third', callBack: (data) {
              print(data);
            },
                widget: const Row(children: [
                  Icon(Icons.account_circle),
                  Text('Lorem Ipsum'),
                ])),
            DigitTableData(
              'Lorem Ipsum s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              cellKey: 'forth',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('label', cellKey: 'fifth', callBack: (data) {
              print(data);
            },
                widget: const DigitTextFormInput(
                  suffixText: '₹',
                )),
            DigitTableData('', cellKey: 'six', callBack: (data) {
              print(data);
            }, widget: const DigitDateFormInput()),
            DigitTableData(
              'switch',
              cellKey: 'seven',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData(
              'active',
              cellKey: 'eight',
              callBack: (data) {
                print(data);
              },
            ),
            DigitTableData('DigitButton', cellKey: 'nine', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.link,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
            DigitTableData('active', cellKey: 'ten', callBack: (data) {
              print(data);
            },
                widget: DigitButton(
                  type: DigitButtonType.primary,
                  label: 'DigitButton',
                  size: DigitButtonSize.large,
                  onPressed: () {},
                )),
          ]),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/wrapper card',
      builder: (context) => DigitTableWrapper(
        tableHeader: 'Table Header',
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
              },
            ),
          ])
        ],
      ),
    ),
    Story(
      name: 'Molecule/Table/wrapper card 2',
      builder: (context) => DigitTableWrapper(
        tableHeader: 'Table Header',
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
            header: 'A',
            type: ColumnType.checkbox,
            showCheckbox: true,
            //columnType: ColumnType.checkbox,
          ),
          DigitTableColumn(
            header: 'B',
            cellValue: 'second',
            type: ColumnType.text,
            //columnType: ColumnType.text,
          ),
          DigitTableColumn(
            cellValue: 'third',
            header: 'C',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'forth',
            header: 'D',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'fifth',
            header: 'E',
            type: ColumnType.text,
            //columnType: ColumnType.numeric,
          ),
          DigitTableColumn(
            cellValue: 'six',
            header: 'F',
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
              },
            ),
          ])
        ],
      ),
    ),
  ];
}
