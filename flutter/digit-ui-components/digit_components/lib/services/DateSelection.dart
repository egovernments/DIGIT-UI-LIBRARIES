import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionBloc {
  Future<void> selectDate({
    required BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    required TextEditingController controller,
    String? cancelText,
    String? confirmText,
    void Function(String)? onChange,
    DateFormat? dateFormat,

    /// Added parameter for custom date format
  }) async {
    final format = dateFormat ?? DateFormat('dd MMM yyyy');

    // If controller has text, try parsing it
    if (controller.text.isNotEmpty) {
      try {
        initialDate = format.parse(controller.text);
      } catch (_) {
        // If parsing fails, fallback to provided initialDate or now
        initialDate ??= DateTime.now();
      }
    } else {
      initialDate ??= DateTime.now();
    }

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
      cancelText: cancelText,
      confirmText: confirmText,
    );
    if (selectedDate != null) {
      final currentLocale = Localizations.localeOf(context).toString();

      String formattedDate = dateFormat?.format(selectedDate.toLocal()) ??
          DateFormat('dd MMM yyyy', currentLocale)
              .format(selectedDate.toLocal());
      controller.text = formattedDate;
    }

    if (onChange != null) {
      onChange(controller.text);
    }
  }
}
