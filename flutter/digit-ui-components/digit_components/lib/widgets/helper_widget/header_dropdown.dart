import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_header.dart';
import 'package:digit_ui_components/widgets/helper_widget/simple_dropdown_list.dart';
import 'package:flutter/material.dart';
import '../../models/DropdownModels.dart';

class HeaderDropdown extends StatefulWidget {
  final void Function(DropdownItem)? onChange;
  final List<DropdownItem> items;
  final IconData suffixIcon;
  final String title;
  final HeaderType headerType;
  final bool searchable;

  const HeaderDropdown({
    Key? key,
    required this.items,
    this.suffixIcon = Icons.arrow_drop_down,
    this.onChange,
    this.headerType = HeaderType.light,
    required this.title,
    this.searchable = false,
  }) : super(key: key);

  @override
  _HeaderDropdownState createState() => _HeaderDropdownState();
}

class _HeaderDropdownState extends State<HeaderDropdown>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late List<DropdownItem> filteredItems;
  late String currentTitle;
  late DigitTypography currentTypography;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.items);
    currentTitle = widget.title;
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    super.dispose();
  }

  void _toggleDropdown({bool close = false}) {
    if (close) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOpen = false;
    } else {
      if (_overlayEntry == null) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
      } else {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
      _isOpen = !_isOpen;
    }
    setState(() {});
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    /// Calculate the right offset for the dropdown

    /// Create a TextPainter to measure the width of the text
    TextSpan textSpan = TextSpan(
        text: currentTitle,
        style: currentTypography.bodyS.copyWith(
          color: const DigitColors().light.textPrimary,
        ));
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    /// Calculate the width of the label based on the measured text width
    double labelWidth = textPainter.width;

    double dropdownWidth = size.width < 220 ? 220 : size.width;
    double rightOffset = (labelWidth + 8 + 24) - dropdownWidth;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                right: rightOffset,
                top: 45,
                width: size.width < 220 ? 220 : size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(rightOffset, 45),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(4.0),
                    child: SizedBox(
                      width: size.width < 220 ? 220 : size.width,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            // maxHeight: 200,
                            ),
                        child: DropdownListView(
                          items: filteredItems,
                          searchable: widget.searchable,
                          width: size.width < 220 ? 220 : size.width,
                          onSelect: (item) {
                            setState(() {
                              currentTitle = item.name;
                            });
                            _toggleDropdown(close: true);
                            if (widget.onChange != null) {
                              widget.onChange!(item);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    currentTypography = getTypography(context, false);

    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        highlightColor: const DigitColors().transparent,
        splashColor: const DigitColors().transparent,
        hoverColor: const DigitColors().transparent,
        onTap: _toggleDropdown,
        child: Row(
          children: [
            Text(currentTitle,
                style: currentTypography.bodyS.copyWith(
                  color: widget.headerType == HeaderType.light
                      ? const DigitColors().light.textPrimary
                      : const DigitColors().light.paperPrimary,
                )),
            const SizedBox(
              width: 8,
            ),
            Icon(
              widget.suffixIcon,
              size: 24,
              color: widget.headerType == HeaderType.light
                  ? const DigitColors().light.textSecondary
                  : const DigitColors().light.paperPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
