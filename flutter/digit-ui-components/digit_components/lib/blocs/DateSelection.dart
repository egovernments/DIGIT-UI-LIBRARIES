import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionBloc {
  Future<void> selectDate({
    required BuildContext context,
    required TextEditingController controller,
    DateFormat? dateFormat,

    /// Added parameter for custom date format
  }) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: DigitTheme.instance.colorScheme,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      String formattedDate = dateFormat?.format(selectedDate.toLocal()) ??
          DateFormat('dd/MM/yyyy').format(selectedDate.toLocal());
      controller.text = formattedDate;
    }
  }
}
