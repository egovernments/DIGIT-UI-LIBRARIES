import 'package:flutter/material.dart';
import '../atoms/table_body.dart';
import '../atoms/table_container.dart';
import '../atoms/table_footer.dart';
import '../atoms/table_header.dart';

class CustomTable extends StatefulWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final int rowsPerPage;
  final bool withColumnDividers;
  final bool withRowDividers;

  const CustomTable({
    Key? key,
    required this.headers,
    required this.rows,
    this.rowsPerPage = 5,
    this.withColumnDividers = false,
    this.withRowDividers = false,
  }) : super(key: key);

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.rows.length / widget.rowsPerPage).ceil();
    int startIndex = (currentPage - 1) * widget.rowsPerPage;
    int endIndex = startIndex + widget.rowsPerPage;
    List<List<String>> paginatedRows = widget.rows.sublist(
      startIndex,
      endIndex > widget.rows.length ? widget.rows.length : endIndex,
    );

    return TableContainer(
      child: Column(
        children: [
          TableHeader(
            headers: widget.headers,
            withColumnDividers: widget.withColumnDividers,
          ),
          TableBody(
            rows: paginatedRows,
            withColumnDividers: widget.withColumnDividers,
            withRowDividers: widget.withRowDividers,
          ),
          TableFooter(
            currentPage: currentPage,
            totalPages: totalPages,
            onNext: () {
              setState(() {
                if (currentPage < totalPages) {
                  currentPage++;
                }
              });
            },
            onPrevious: () {
              setState(() {
                if (currentPage > 1) {
                  currentPage--;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
