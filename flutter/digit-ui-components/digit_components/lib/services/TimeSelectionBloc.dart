import 'package:flutter/material.dart';
import '../../utils/time_utils.dart';

class TimeSelectionBloc {
  Future<void> selectTime({
    required BuildContext context,
    required TextEditingController controller,
    String? cancelText,
    String? confirmText,
    void Function(String)? onChange,
    bool is24HourFormat = false,
  }) async {
    /// Show a time picker and update the controller's value
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: confirmText,
      cancelText: cancelText,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: is24HourFormat),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      controller.text = formatTime(selectedTime);
    }

    if (onChange != null) {
      onChange(controller.text);
    }
  }
}