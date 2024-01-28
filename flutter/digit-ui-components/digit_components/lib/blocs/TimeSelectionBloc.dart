import 'package:flutter/material.dart';
import '../../utils/time_utils.dart';
import '../theme/digit_theme.dart';

class TimeSelectionBloc {
  Future<void> selectTime({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    /// Show a time picker and update the controller's value
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
    if (selectedTime != null) {
      controller.text = formatTime(selectedTime);
    }
  }
}
