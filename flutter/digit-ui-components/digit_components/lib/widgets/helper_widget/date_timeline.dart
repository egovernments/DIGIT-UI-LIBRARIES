import 'package:carousel_slider/carousel_slider.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitInfiniteDateTimeline extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;
  final DateTime startDate;
  final DateTime endDate;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final DateTimelineController? controller;

  const DigitInfiniteDateTimeline({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.startDate,
    required this.endDate,
    this.controller,
    this.selectedColor = Colors.orange,
    this.unselectedColor = Colors.white,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black87,
  });

  @override
  State<DigitInfiniteDateTimeline> createState() =>
      _DigitInfiniteDateTimelineState();
}

class _DigitInfiniteDateTimelineState extends State<DigitInfiniteDateTimeline> {
  late final List<DateTime> _dates;
  int _selectedIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _dates = List.generate(
      widget.endDate.difference(widget.startDate).inDays + 1,
      (index) => widget.startDate.add(Duration(days: index)),
    );

    _selectedIndex = _dates.indexWhere(
      (d) => DateUtils.isSameDay(d, widget.selectedDate),
    );

    widget.controller?.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    final jumpDate = widget.controller?.jumpDate;
    if (jumpDate != null) {
      final index = _dates.indexWhere((d) => DateUtils.isSameDay(d, jumpDate));
      if (index != -1) {
        _carouselController.animateToPage(index);
        setState(() => _selectedIndex = index);
        widget.onDateSelected(jumpDate);
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: _dates.length,
      itemBuilder: (context, index, realIdx) {
        final date = _dates[index];
        final isSelected = index == _selectedIndex;

        return GestureDetector(
          onTap: () {
            setState(() => _selectedIndex = index);
            widget.onDateSelected(date);
            _carouselController.animateToPage(index);
          },
          child: Container(
            margin: const EdgeInsets.all(spacer1),
            decoration: BoxDecoration(
                color: widget.unselectedColor,
                borderRadius: BorderRadius.circular(spacer2),
                border: Border.all(
                  color:
                      isSelected ? widget.selectedColor : Colors.grey.shade300,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: theme.colorTheme.primary.primary1,
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        )
                      ]
                    : []),
            width: 80,
            padding: const EdgeInsets.all(spacer1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat('EEE').format(date),
                    style:  isSelected ? textTheme.bodyL.copyWith(
                      color: theme.colorTheme.primary.primary2,
                    ) : textTheme.bodyS
                        .copyWith(color: theme.colorTheme.primary.primary2)),
                const SizedBox(height: spacer2),
                Text(DateFormat('dd').format(date),
                    style: isSelected ?textTheme.headingL.copyWith(
                      color: theme.colorTheme.primary.primary2,
                    ) :  textTheme.headingS
                        .copyWith(color: theme.colorTheme.primary.primary2)),
                const SizedBox(height: spacer2),
                Text(DateFormat('MMM').format(date),
                    style:  isSelected ? textTheme.bodyL.copyWith(
                      color: theme.colorTheme.primary.primary2,
                    ) : textTheme.bodyS
                        .copyWith(color: theme.colorTheme.primary.primary2)),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.13,
        viewportFraction: 0.22,
        enableInfiniteScroll: false,
        initialPage: _selectedIndex,
        enlargeCenterPage: true,
        enlargeFactor: 0.12,
        // <- Decrease this for less dramatic size difference
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        onPageChanged: (index, reason) {
          setState(() {
            _selectedIndex = index;
            widget.onDateSelected(_dates[index]);
          });
        },
      ),
    );
  }
}

class DateTimelineController extends ChangeNotifier {
  DateTime? _jumpDate;

  void jumpTo(DateTime date) {
    _jumpDate = date;
    notifyListeners();
  }

  DateTime? get jumpDate => _jumpDate;
}
