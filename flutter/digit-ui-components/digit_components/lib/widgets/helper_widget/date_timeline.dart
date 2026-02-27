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
  final bool disableScroll;

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
    this.disableScroll = false,
  });

  @override
  State<DigitInfiniteDateTimeline> createState() =>
      _DigitInfiniteDateTimelineState();
}

class _DigitInfiniteDateTimelineState extends State<DigitInfiniteDateTimeline> {
  late List<DateTime> _dates;
  int _selectedIndex = 0;
  final CarouselController _carouselController = CarouselController();
  bool _externalChangeInProgress = false;

  @override
  void didUpdateWidget(covariant DigitInfiniteDateTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Rewire controller listener if the controller instance changed
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      widget.controller?.addListener(_handleControllerChange);
    }

    // Rebuild date list when range bounds change
    if (!DateUtils.isSameDay(oldWidget.startDate, widget.startDate) ||
        !DateUtils.isSameDay(oldWidget.endDate, widget.endDate)) {
      setState(() {
        _dates = _buildDates(widget.startDate, widget.endDate);
        final index = _dates.indexWhere(
          (d) => DateUtils.isSameDay(d, widget.selectedDate),
        );
        _selectedIndex = index != -1 ? index : 0;
      });
      return;
    }

    if (!DateUtils.isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      final newIndex = _dates.indexWhere((d) => DateUtils.isSameDay(d, widget.selectedDate));
      if (newIndex != -1 && newIndex != _selectedIndex) {
        _externalChangeInProgress = true;
        _carouselController.animateToPage(newIndex).then((_) {
          setState(() {
            _selectedIndex = newIndex;
          });
          _externalChangeInProgress = false;
        });
      }
    }
  }

  List<DateTime> _buildDates(DateTime start, DateTime end) {
    final days = end.difference(start).inDays;
    if (days < 0) return [start];
    return List.generate(days + 1, (i) => start.add(Duration(days: i)));
  }

  @override
  void initState() {
    super.initState();
    _dates = _buildDates(widget.startDate, widget.endDate);

    final index = _dates.indexWhere(
      (d) => DateUtils.isSameDay(d, widget.selectedDate),
    );
    _selectedIndex = index != -1 ? index : 0;

    widget.controller?.addListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    final jumpDate = widget.controller?.consumeJumpDate();
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
            if (_selectedIndex != index) {
              // Prevent triggering onPageChanged logic again
              _externalChangeInProgress = true;

              setState(() {
                _selectedIndex = index;
              });
              widget.onDateSelected(_dates[index]);

              _carouselController.animateToPage(index).then((_) {
                _externalChangeInProgress = false;
              });
            }
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
                    style: isSelected
                        ? textTheme.bodyL.copyWith(color: widget.selectedTextColor)
                        : textTheme.bodyS.copyWith(color: widget.unselectedTextColor)),
                const SizedBox(height: spacer2),
                Text(DateFormat('dd').format(date),
                    style: isSelected
                        ? textTheme.headingL.copyWith(color: widget.selectedTextColor)
                        : textTheme.headingS.copyWith(color: widget.unselectedTextColor)),
                const SizedBox(height: spacer2),
                Text(DateFormat('MMM').format(date),
                    style: isSelected
                        ? textTheme.bodyL.copyWith(color: widget.selectedTextColor)
                        : textTheme.bodyS.copyWith(color: widget.unselectedTextColor)),
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
        scrollPhysics: widget.disableScroll ? const NeverScrollableScrollPhysics() : null,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        onPageChanged: (index, reason) {
          if (_externalChangeInProgress || index == _selectedIndex) return;

          setState(() {
            _selectedIndex = index;
          });

          widget.onDateSelected(_dates[index]);
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

  /// Returns and clears the pending jump date so it is only consumed once.
  DateTime? consumeJumpDate() {
    final date = _jumpDate;
    _jumpDate = null;
    return date;
  }

  DateTime? get jumpDate => _jumpDate;
}
