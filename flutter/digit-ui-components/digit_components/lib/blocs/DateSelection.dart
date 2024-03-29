import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionBloc {
  Future<void> selectDate({
    required BuildContext context, DateTime? firstDate, DateTime? lastDate, DateTime? initialDate,
    required TextEditingController controller,
    DateFormat? dateFormat, /// Added parameter for custom date format
  }) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
    );
    if (selectedDate != null) {
      String formattedDate =
          dateFormat?.format(selectedDate.toLocal()) ??
              DateFormat('dd/MM/yyyy').format(selectedDate.toLocal());
      controller.text = formattedDate;
    }
  }
}