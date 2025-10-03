import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/date_utils.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DigitDobPicker extends StatefulWidget {
  final String datePickerFormControl;
  final bool readOnly;
  final ControlValueAccessor? valueAccessor;
  final String datePickerLabel;
  final String ageFieldLabel;
  final String yearsHintLabel;
  final String monthsHintLabel;
  final String separatorLabel;
  final String? initialValue;
  final String yearsAndMonthsErrMsg;
  final String cancelText;
  final String confirmText;
  final String? errorMessage;
  final String? ageErrorMessage;
  final String? monthErrorMessage;
  final DateTime? initialDate;
  final void Function(DateTime?)? onChangeOfFormControl;

  const DigitDobPicker({
    super.key,
    required this.datePickerFormControl,
    this.readOnly = false,
    this.valueAccessor,
    required this.datePickerLabel,
    required this.ageFieldLabel,
    required this.yearsHintLabel,
    required this.monthsHintLabel,
    required this.separatorLabel,
    this.initialDate,
    required this.yearsAndMonthsErrMsg,
    this.initialValue,
    this.ageErrorMessage,
    this.errorMessage,
    this.monthErrorMessage,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onChangeOfFormControl,
  });

  @override
  State<DigitDobPicker> createState() => _DigitDobPickerState();
}

class _DigitDobPickerState extends State<DigitDobPicker> {
  // Controllers for the year and month fields
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedDate = DigitDateUtils.getFormattedDateToDateTime(
          widget.initialValue.toString());
      _setAgeFromDate(selectedDate);

      /// updated all the controller value also
    }
  }

  // Calculate the age (years and months) from the selected date
  void _setAgeFromDate(DateTime? date) {
    if (date == null) {
      return;
    }
    final now = DateTime.now();
    int years = now.year - date.year;
    int months = now.month - date.month;
    int days = now.day - date.day;

    // If days are negative, adjust months and days
    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0).day;
    }

    // If months are negative, adjust years and months
    if (months < 0) {
      years--;
      months += 12;
    }

    setState(() {
      yearController.text = years.toString();
      monthController.text = months.toString();
    });
  }

  // Calculate the date from the given age in years and months
  DateTime _getDateFromAge() {
    int years = int.tryParse(yearController.text) ?? 0;
    int months = int.tryParse(monthController.text) ?? 0;
    final now = DateTime.now();

    // Total months to subtract
    int totalMonths = (years * 12) + months;

    // Compute new year and month
    int newYear = now.year;
    int newMonth = now.month - totalMonths;

    while (newMonth <= 0) {
      newMonth += 12;
      newYear -= 1;
    }

    // Preserve the day, clamp to last valid day if needed
    int day = now.day;
    int maxDayInMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (day > maxDayInMonth) {
      day = maxDayInMonth;
    }

    return DateTime(newYear, newMonth, day);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DigitCard(
          borderColor:
              widget.errorMessage != null ? theme.colorTheme.alert.error : null,
          cardType: CardType.secondary,
          children: [
            Column(
              children: [
                // Date picker component to select the date of birth
                LabeledField(
                  label: widget.datePickerLabel,
                  child: DigitDateFormInput(
                    readOnly: widget.readOnly,
                    editable: false,
                    initialValue: selectedDate != null
                        ? DateFormat('dd MMM yyyy',
                                Localizations.localeOf(context).toLanguageTag())
                            .format(selectedDate!)
                        : '',
                    firstDate: widget.initialDate,
                    cancelText: widget.cancelText,
                    confirmText: widget.confirmText,
                    lastDate: DateTime.now(),
                    onChange: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          selectedDate = DateFormat('dd MMM yyyy').parse(value);
                          _setAgeFromDate(selectedDate);
                        });
                        if (widget.onChangeOfFormControl != null) {
                          widget.onChangeOfFormControl!(selectedDate);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.separatorLabel,
                  style: theme.textTheme.bodyLarge,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // Text form field for entering the age in years
                      child: LabeledField(
                        labelInline: false,
                        label: widget.ageFieldLabel,
                        child: DigitTextFormInput(
                          errorMessage: widget.ageErrorMessage,
                          prefixTextStyle: textTheme.bodyS.copyWith(
                            color: theme.colorTheme.text.secondary,
                          ),
                          prefixText: widget.yearsHintLabel,
                          maxLength: 3,
                          controller: yearController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChange: (value) {
                            setState(() {
                              selectedDate = _getDateFromAge();
                            });
                            if (widget.onChangeOfFormControl != null) {
                              widget.onChangeOfFormControl!(selectedDate);
                            }
                          },
                          keyboardType: TextInputType.number,
                          readOnly: widget.readOnly,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      // Text form field for entering the age in months
                      child: LabeledField(
                        labelInline: false,
                        label: '',
                        child: DigitTextFormInput(
                          errorMessage: widget.monthErrorMessage,
                          prefixTextStyle: textTheme.bodyS.copyWith(
                            color: theme.colorTheme.text.secondary,
                          ),
                          prefixText: widget.monthsHintLabel,
                          maxLength: 2,
                          controller: monthController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChange: (value) {
                            setState(() {
                              selectedDate = _getDateFromAge();
                            });
                            if (widget.onChangeOfFormControl != null) {
                              widget.onChangeOfFormControl!(selectedDate);
                            }
                          },
                          keyboardType: TextInputType.number,
                          readOnly: widget.readOnly,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: spacer1),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: spacer1 / 2,
                  ),
                  SizedBox(
                    height: spacer4,
                    width: spacer4,
                    child: Icon(
                      Icons.info,
                      color: theme.colorTheme.alert.error,
                      size: spacer4,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: spacer1),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  widget.errorMessage!,
                  style: textTheme.bodyL.copyWith(
                    color: theme.colorTheme.alert.error,
                  ),
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}
