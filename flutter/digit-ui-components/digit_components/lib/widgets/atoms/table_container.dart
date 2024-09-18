import 'package:flutter/material.dart';

class TableContainer extends StatelessWidget {
  final Widget child;

  const TableContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    );
  }
}