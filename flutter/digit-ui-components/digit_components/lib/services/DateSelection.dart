import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionBloc {
  Future<void> selectDate({
    required BuildContext context, DateTime? firstDate, DateTime? lastDate, DateTime? initialDate,
    required TextEditingController controller, String? cancelText, String? confirmText, void Function(String)? onChange,
    DateFormat? dateFormat,  /// Added parameter for custom date format
  }) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
      cancelText: cancelText,
      confirmText: confirmText,
    );
    if (selectedDate != null) {
      final currentLocale = Localizations.localeOf(context).toString();

      String formattedDate = dateFormat?.format(selectedDate.toLocal()) ??
          DateFormat('dd MMM yyyy', currentLocale).format(selectedDate.toLocal());
      controller.text = formattedDate;
    }

    if (onChange != null) {
      onChange(controller.text);
    }
  }
}