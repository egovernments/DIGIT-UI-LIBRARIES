import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import '../atoms/digit_button.dart';
import '../atoms/table_cell.dart';
import '../atoms/table_footer.dart';
import 'digit_table.dart';

class DigitTableWrapper extends StatefulWidget {
  final List<DigitTableColumn> columns;
  final List<DigitTableRow> rows;
  final List<int> rowsPerPageOptions;
  final bool showRowsPerPage;
  final bool withColumnDividers;
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool stickyHeader;
  final int frozenColumnsCount;
  final Widget? customRow;
  final bool isCustomRowFixed;
  final String? tableHeader;

  const DigitTableWrapper({
    Key? key,
    required this.columns,
    required this.rows,
    this.rowsPerPageOptions = const [5, 10, 15, 20],
    this.showRowsPerPage = true,
    this.withColumnDividers = true,
    this.withRowDividers = true,
    this.alternateRowColor = false,
    this.enableBorder = false,
    this.stickyHeader = false,
    this.frozenColumnsCount = 0,
    this.customRow,
    this.isCustomRowFixed = false,
    this.tableHeader,
  }) : super(key: key);

  @override
  _DigitTableWrapperState createState() => _DigitTableWrapperState();
}

class _DigitTableWrapperState extends State<DigitTableWrapper> {
  int currentPage = 1;
  int rowsPerPage = 5;
  int selectedRowsCount = 0;
  SortOrder? sortOrder;
  int? sortedColumnIndex;
  List<DigitTableRow> sortedRows = [];

  // Update selected row count when a row is selected/deselected
  void _onRowSelected(int count) {
    setState(() {
      selectedRowsCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);



    return DigitCard(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.tableHeader ?? "", style: textTheme.headingM.copyWith(color: theme.colorTheme.text.primary),),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('filter', style: textTheme.bodyL.copyWith(color: theme.colorTheme.text.primary),),
                  const SizedBox(width: 8,),
                  Icon(Icons.filter_list, color: theme.colorTheme.text.primary,)
                ],
              )
            ],
          ),
        ),
        if(selectedRowsCount > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.done_all, color: theme.colorTheme.primary.primary1,),
                  const SizedBox(width: 8,),
                  Text('$selectedRowsCount selected', style: textTheme.headingS.copyWith(color: theme.colorTheme.primary.primary2),),
                ],
              ),
              DigitButton(label: 'action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.medium)
            ],
          ),
        DigitTable(
          columns: widget.columns,
          rows: widget.rows,
          rowsPerPageOptions: widget.rowsPerPageOptions,
          showRowsPerPage: widget.showRowsPerPage,
          withColumnDividers: widget.withColumnDividers,
          withRowDividers: widget.withRowDividers,
          alternateRowColor: widget.alternateRowColor,
          enableBorder: widget.enableBorder,
          stickyHeader: widget.stickyHeader,
          frozenColumnsCount: widget.frozenColumnsCount,
          customRow: widget.customRow,
          isCustomRowFixed: widget.isCustomRowFixed,
          onSelectedRowsChanged: _onRowSelected,
        ),
      ],
    );
  }
}