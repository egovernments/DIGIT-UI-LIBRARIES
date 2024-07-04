import 'package:flutter/material.dart';

class TableColumn extends StatelessWidget {
  final String data;

  const TableColumn({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(data),
    );
  }
}
