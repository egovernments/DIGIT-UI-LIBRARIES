import 'package:digit_ui_components/services/DateSelection.dart';
import 'package:digit_ui_components/theme/theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_base_form_input.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helper_widget/date_timeline.dart';


class InfiniteDateScrollInput extends BaseDigitFormInput {

  final bool disableScroll;

  const InfiniteDateScrollInput({
    super.key,
    super.controller,
    super.initialValue,
    super.readOnly,
    super.isDisabled,
    bool editable = false,
    super.charCount,
    super.initialDate,
    super.firstDate,
    super.lastDate,
    super.innerLabel,
    super.helpText,
    super.isRequired,
    IconData? suffixIcon,
    super.onError,
    super.validations,
    super.onChange,
    super.errorMessage,
    super.inputFormatters,
    super.cancelText,
    final TextInputType? keyboardType,
    super.confirmText,
    super.onFocusLost,
    super.iconColor,
    this.disableScroll = false,
  }) : super(
    suffixIcon: suffixIcon ?? Icons.date_range,
    keyboardType: keyboardType ?? TextInputType.datetime,
    showCurser: editable,
    isEditable: editable,
  );

  @override
  DigitDateFormInputState createState() => DigitDateFormInputState();
}

class DigitDateFormInputState extends BaseDigitFormInputState {
  late DateTime _selectedDate;
  late DateTime _startDate;
  late DateTime _endDate;
  String? _lastEmittedValue;

  DateSelectionBloc dateSelectionBloc = DateSelectionBloc();
  final DateTimelineController _timelineController = DateTimelineController();

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _selectedDate = widget.initialDate ?? now;
    _startDate = widget.firstDate ?? DateTime(now.year, 5, 1);
    _endDate = widget.lastDate ?? DateTime(now.year, 5, 31);

    if (controller.text.isEmpty) {
      controller.text = DateFormat('dd MMM yyyy').format(_selectedDate);
      onTap();
    }
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _timelineController.jumpTo(_selectedDate); // scroll the timeline
    //   _emitIfChanged(controller.text);
    // });
  }

  @override
  void didUpdateWidget(covariant InfiniteDateScrollInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newInitialDate = widget.initialDate;
    if (newInitialDate != null && newInitialDate != _selectedDate) {
      final formattedDate = DateFormat('dd MMM yyyy').format(newInitialDate);

      setState(() {
        _selectedDate = newInitialDate;
        controller.text = formattedDate;
      });

      _emitIfChanged(formattedDate);
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      controller.text = DateFormat('dd MMM yyyy').format(date);
    });
    _emitIfChanged(controller.text);
  }


  void _emitIfChanged(String newValue) {
    if (_lastEmittedValue != newValue) {
      _lastEmittedValue = newValue;
      widget.onChange?.call(newValue);
    }
  }

  @override
  void onSuffixIconClick({void Function()? customFunction}) async {
    await dateSelectionBloc.selectDate(
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: _selectedDate,
      context: context,
      controller: controller,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      onChange: (val) {
        final parsedDate = DateFormat('dd MMM yyyy').parse(val);
        setState(() {
          _selectedDate = parsedDate; // update selectedDate
        });
         // _timelineController.jumpTo(parsedDate); // scroll the timeline
        _emitIfChanged(controller.text);
      },
    );
  }

  @override
  void onTap() async {
    await dateSelectionBloc.selectDate(
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: _selectedDate,
      context: context,
      controller: controller,
      onChange: (val) {
        final parsedDate = DateFormat('dd MMM yyyy').parse(val);
        setState(() {
          _selectedDate = parsedDate;
        });
        _emitIfChanged(controller.text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DigitCard(
      children: [
        super.build(context),
        DigitInfiniteDateTimeline(
          disableScroll : (widget as InfiniteDateScrollInput).disableScroll,
          controller: _timelineController,
          selectedDate: _selectedDate,
          onDateSelected: _onDateSelected,
          startDate: _startDate,
          endDate: _endDate,
          selectedColor: DigitTheme.instance.colorScheme.primary,
          unselectedColor: Colors.white,
          selectedTextColor: Colors.white,
          unselectedTextColor: Colors.black87,
        ),
      ],
    );
  }
}