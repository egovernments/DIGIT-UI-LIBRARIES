import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/helper_widget/simple_dropdown_list.dart';
import 'package:flutter/material.dart';
import '../molecules/digit_header.dart';

class OverlayDropdown extends StatefulWidget {
  final OverlayDropdownType type;
  final void Function(DropdownItem)? onChange;
  final List<DropdownItem> items;
  final IconData suffixIcon;
  final Widget title;
  final HeaderType headerType;
  final bool searchable;

  const OverlayDropdown({
    Key? key,
    this.type = OverlayDropdownType.header,
    required this.items,
    this.suffixIcon = Icons.arrow_drop_down,
    this.onChange,
    this.headerType = HeaderType.light,
    required this.title,
    this.searchable = false,
  }) : super(key: key);

  @override
  _OverlayDropdownState createState() => _OverlayDropdownState();
}

class _OverlayDropdownState extends State<OverlayDropdown>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late List<DropdownItem> filteredItems;
  late DigitTypography currentTypography;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.items);
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
    double screenWidth = MediaQuery.of(context).size.width;
    double dropdownWidth = size.width < 220 ? 220 : size.width;
    double widgetWidth = size.width; /// Get the width of the widget
    double rightOffset = widgetWidth - dropdownWidth;
    // Adjust dropdownWidth to ensure it fits within the screen
    double maxDropdownWidth = screenWidth - renderBox.localToGlobal(Offset.zero).dx - 16;
    if (dropdownWidth > maxDropdownWidth) {
      dropdownWidth = maxDropdownWidth;
    }

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
                //right: rightOffset,
                top: widget.type == OverlayDropdownType.footer ? null : 16.5,
                bottom: widget.type == OverlayDropdownType.footer ? size.height: null,
                width: dropdownWidth,
                //left: rightOffset,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  targetAnchor: Alignment.bottomRight,
                  followerAnchor: widget.type == OverlayDropdownType.footer ? Alignment.bottomRight : Alignment.topRight,
                  offset: Offset(0, widget.type == OverlayDropdownType.footer ? -(size.height) : 16.5),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(0),
                    color: const DigitColors().light.paperPrimary,
                    child: Container(
                      width: dropdownWidth,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, widget.type == OverlayDropdownType.header ? -1 : 1),
                            blurRadius: 4.4,
                            spreadRadius: 0,
                            color: const Color(0x26000000), // #00000026
                          ),
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 700,
                        ),
                        child: DropdownListView(
                          isOpen: _isOpen,
                          items: filteredItems,
                          searchable: widget.searchable,
                          width: dropdownWidth,
                          onSelect: (item) {
                            if (item != null) {
                              setState(() {
                                // Update title if needed
                              });
                            }
                            _toggleDropdown(close: true);
                            if (widget.onChange != null && item != null) {
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
    // typography based on screen
    currentTypography = getTypography(context, false);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _toggleDropdown,
            child: SizedBox(height: 40, child: Center(child: widget.title)),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: _toggleDropdown,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum OverlayDropdownType {
  header,
  footer,
}