/*
The DigitDropdownExample widget is a stateful widget that initializes a TextEditingController and a list of DropdownItem objects.
The DigitDropdown component is then used with the provided parameters,
and the onChange callback is used to handle the selected value.

 Example usage:
 ```dart
 DigitDropdown(
       // Pass the TextEditingController
       textEditingController: _textEditingController,

       // Pass the list of DropdownItems
       items: _dropdownItems,

       // default is searchable but can be configured
       isSearchable: false,

       // Callback function when an option is selected
       onChange: (value, index) {
         print('Selected: $value'); // Handle the selected value here
       },

       // Optional parameters can be customized as needed
       suffixIcon: Icons.arrow_drop_down,
       dropdownType: DropdownType.defaultSelect,
      emptyItemText: 'No Options available',
)
....*/

import 'package:digit_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';

class DigitDropdown<T> extends StatefulWidget {
  final TextEditingController textEditingController;

  /// onChange is called when the selected option is changed
  /// It will pass back the value and the index of the option (can be different for different case).
  final void Function(String, String) onChange;

  /// list of DropdownItems
  final List<DropdownItem> items;

  /// used for text with icon
  final IconData? textIcon;

  /// dropdown button icon defaults to caret
  final IconData suffixIcon;

  final DropdownType dropdownType;

  /// text to shown, when no options is available....... even while searching if no options matches
  final String emptyItemText;

  /// searching the items can be configurable
  final bool isSearchable;

  /// default selected Item
  final DropdownItem? selectedOption;

  /// Whether the dropdown is enabled or disabled.
  final bool isDisabled;

  const DigitDropdown({
    Key? key,
    required this.items,
    this.suffixIcon = Icons.arrow_drop_down,
    this.textIcon,
    required this.onChange,
    this.isSearchable = true,
    this.dropdownType = DropdownType.defaultSelect,
    required this.textEditingController,
    this.emptyItemText = "No Options available",
    this.selectedOption,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  _DigitDropdownState<T> createState() => _DigitDropdownState<T>();
}

class _DigitDropdownState<T> extends State<DigitDropdown<T>>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  String _currentIndex = '';
  String _nestedIndex = '';
  late List<DropdownItem> filteredItems;
  late List<DropdownItem> _lastFilteredItems;
  late Map<String, bool> _itemMouseDownStates;
  late Map<String, bool> _itemHoverStates;
  late bool isMouseDown;
  int _focusedIndex = -1;
  late bool _isMouseUsed;
  late double dropdownWidth;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    filteredItems = List.from(widget.items);
    _lastFilteredItems = List.from(widget.items);
    _itemHoverStates = {};
    _itemMouseDownStates = {};
    isMouseDown = true;
    _isMouseUsed = false;

    /// if there is a selectedOption
    if (widget.selectedOption != null) {
      setState(() {
        if (widget.dropdownType == DropdownType.nestedSelect) {
          _nestedIndex = widget.selectedOption!.code;
          widget.textEditingController.text =
              '${widget.selectedOption?.type}: ${widget.selectedOption?.name}';
        } else {
          _currentIndex = widget.selectedOption!.code;
          widget.textEditingController.text = widget.selectedOption!.name;
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();

    /// Check if _overlayEntry is not null before removing and disposing
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _selectDropdownOption();
      if (_isOpen && isMouseDown == false) {
        _toggleDropdown(close: true);
      }

      /// If no match found, clear the controller text
      if (_currentIndex == '' && _nestedIndex == '') {
        widget.textEditingController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Responsive width based on screen size
    dropdownWidth = AppView.isMobileView(MediaQuery.of(context).size.width)
        ? Default.mobileInputWidth
        : Default.desktopInputWidth;

    /// link the overlay to the button
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        /// Check for arrow up and arrow down key events
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _navigateDropdown(-1);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _navigateDropdown(1);
          }
        }
      },
      child: CompositedTransformTarget(
        link: this._layerLink,
        child: SizedBox(
          width: dropdownWidth,
          height: Default.height,
          child: TextField(
            enabled: !widget.isDisabled,
            onTap: () {
              _toggleDropdown();
              FocusScope.of(context).requestFocus(_focusNode);
            },
            onChanged: widget.isSearchable
                ? (input) {
                    _filterItems(input);
                    if (!listEquals(filteredItems, _lastFilteredItems)) {
                      _updateOverlay();
                      _lastFilteredItems = filteredItems;
                    }
                  }
                : null,
            focusNode: _focusNode,
            controller: widget.textEditingController,
            style:
                DigitTheme.instance.mobileTheme.textTheme.bodyLarge?.copyWith(
              height: 1.5,
              color: const DigitColors().lightTextPrimary,
            ),
            decoration: InputDecoration(
              filled: true,
              hoverColor: const DigitColors().transparent,
              fillColor: widget.isDisabled
                  ? const DigitColors().lightPaperSecondary
                  : const DigitColors().lightPaperPrimary,
              contentPadding: const EdgeInsets.only(
                left: 12,
                top: 8,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const DigitColors().lightGenericInputBorder,
                    width: 1.0),
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const DigitColors().lightPrimaryOrange, width: 1.0),
                borderRadius: BorderRadius.zero,
              ),
              disabledBorder: BaseConstants.disabledBorder,
              suffixIcon: InkWell(
                highlightColor: const DigitColors().transparent,
                splashColor: const DigitColors().transparent,
                hoverColor: const DigitColors().transparent,
                onTap: () {
                  _toggleDropdown();
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                child: Icon(
                  widget.suffixIcon,
                  size: 24,
                ),
              ),
              suffixIconColor: widget.isDisabled
                  ? const DigitColors().lightGenericDivider
                  : const DigitColors().lightTextSecondary,
            ),
          ),
        ),
      ),
    );
  }

  /// function to filter items based on the input
  void _filterItems(String input) {
    List<DropdownItem> newFilteredItems = widget.items
        .where((item) =>
            item.name
                .trim()
                .toLowerCase()
                .contains(input.trim().toLowerCase()) ||
            (item.description != null &&
                item.description!
                    .trim()
                    .toLowerCase()
                    .contains(input.trim().toLowerCase())))
        .toList();

    if (!listEquals(newFilteredItems, _lastFilteredItems)) {
      setState(() {
        filteredItems = newFilteredItems;
      });
    }
  }

  /// update the overlay when overlay needs to build again
  void _updateOverlay() {
    if (_isOpen && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    }
  }

  ///overlay for dropdown
  OverlayEntry _createOverlayEntry() {
    /// find the size and position of the current widget
    RenderBox? renderBox = context?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      /// Handle the case where renderBox is null (e.g., widget not yet laid out)
      return OverlayEntry(builder: (context) => const SizedBox.shrink());
    }
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height;
    OverlayEntry overlayEntry = OverlayEntry(
      /// full screen GestureDetector to register when a user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,

        /// full screen SizedBox to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height),
                  link: this._layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.zero,
                    color: const DigitColors().lightPaperPrimary,
                    clipBehavior: Clip.none,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(context).size.height - topOffset - 15,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              if (filteredItems.isNotEmpty)
                                const BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 4.4,
                                  spreadRadius: 0,
                                  color: Color(0x26000000), // #00000026
                                ),
                            ],
                          ),
                          child: _buildDropdownListView()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return overlayEntry;
  }

  /// build the dropdown based on the type
  Widget _buildDropdownListView() {
    return widget.dropdownType == DropdownType.nestedSelect
        ? _buildNestedListView()
        : _buildListView();
  }

  Widget _buildListView() {
    return filteredItems.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(height: 0),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return StatefulBuilder(
                builder: (context, setState) {
                  Color backgroundColor = index % 2 == 0
                      ? const DigitColors().lightPaperPrimary
                      : const DigitColors().lightPaperSecondary;

                  bool isFocused = _focusedIndex == index && !_isMouseUsed;
                  if (_isMouseUsed) {
                    _focusedIndex = -1;
                  }
                  return InkWell(
                    onTapDown: (_) {
                      /// Handle mouse down state
                      setState(() {
                        isMouseDown = false;
                        _itemMouseDownStates[filteredItems[index].code] = true;
                      });
                    },
                    onTapUp: (_) {
                      /// Handle mouse up state
                      setState(() {
                        isMouseDown = true;
                        _itemMouseDownStates[filteredItems[index].code] = false;
                      });
                    },
                    splashColor: const DigitColors().transparent,
                    hoverColor: const DigitColors().transparent,
                    highlightColor: const DigitColors().transparent,
                    onHover: (hover) {
                      setState(() {
                        _isMouseUsed = hover;
                        _itemHoverStates[filteredItems[index].code] = hover;
                      });
                    },
                    onTap: () {
                      setState(() => _currentIndex = filteredItems[index].code);
                      widget.onChange(
                          filteredItems[index].name, filteredItems[index].code);
                      _toggleDropdown();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: .5,
                          color: _itemMouseDownStates[
                                          filteredItems[index].code] ==
                                      true ||
                                  _itemHoverStates[filteredItems[index].code] ==
                                      true ||
                                  isFocused
                              ? const DigitColors().lightPrimaryOrange
                              : Colors.transparent,
                        ),
                        color:
                            _itemMouseDownStates[filteredItems[index].code] ==
                                    true
                                ? const DigitColors().lightPrimaryOrange
                                : _itemHoverStates[filteredItems[index].code] ==
                                            true ||
                                        isFocused
                                    ? const DigitColors().orangeBG
                                    : backgroundColor,
                      ),
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding:
                            widget.dropdownType == DropdownType.defaultSelect &&
                                    filteredItems[index].description == null
                                ? DropdownConstants.defaultPadding
                                : DropdownConstants.nestedItemPadding,
                        child: Row(
                          children: [
                            if (filteredItems[index].profileImage != null)
                              SizedBox(
                                height: DropdownConstants.defaultProfileSize,
                                width: DropdownConstants.defaultProfileSize,
                                child: CircleAvatar(
                                  radius: DropdownConstants.defaultImageRadius,

                                  /// This radius is the radius of the picture in the circle avatar itself.
                                  backgroundImage:
                                      filteredItems[index].profileImage,
                                  backgroundColor:
                                      const DigitColors().lightTextSecondary,
                                ),
                              ),
                            if (filteredItems[index].profileImage != null)
                              const SizedBox(
                                width: 6,
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (filteredItems[index].textIcon != null)
                                      Icon(
                                        filteredItems[index].textIcon,
                                        size: DropdownConstants.textIconSize,
                                        color: _itemMouseDownStates[
                                                    filteredItems[index]
                                                        .code] ==
                                                true
                                            ? const DigitColors()
                                                .lightPaperPrimary
                                            : const DigitColors()
                                                .lightTextSecondary,
                                      ),
                                    if (filteredItems[index].textIcon != null)
                                      const SizedBox(
                                        width: kPadding / 2,
                                      ),
                                    SizedBox(
                                      width:
                                          filteredItems[index].profileImage !=
                                                  null
                                              ? dropdownWidth - 50
                                              : filteredItems[index].textIcon !=
                                                      null
                                                  ? dropdownWidth - 40
                                                  : dropdownWidth - 16,
                                      child: Text(
                                        filteredItems[index].name,
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: _itemMouseDownStates[
                                                    filteredItems[index]
                                                        .code] ==
                                                true
                                            ? DigitTheme.instance.mobileTheme
                                                .textTheme.headlineSmall
                                                ?.copyWith(
                                                    height: 1.188,
                                                    color: const DigitColors()
                                                        .lightPaperPrimary)
                                            : DigitTheme.instance.mobileTheme
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                                    height: 1.125,
                                                    color: const DigitColors()
                                                        .lightTextPrimary),
                                      ),
                                    )
                                  ],
                                ),
                                if (filteredItems[index].description != null)
                                  SizedBox(
                                    width: filteredItems[index].profileImage !=
                                            null
                                        ? dropdownWidth - 50
                                        : filteredItems[index].textIcon != null
                                            ? dropdownWidth - 40
                                            : dropdownWidth - 16,
                                    child: Text(
                                      filteredItems[index].description!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: DigitTheme.instance.mobileTheme
                                          .textTheme.bodySmall
                                          ?.copyWith(
                                        color: _itemMouseDownStates[
                                                    filteredItems[index]
                                                        .code] ==
                                                true
                                            ? const DigitColors()
                                                .lightPaperPrimary
                                            : const DigitColors()
                                                .lightTextSecondary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        : Padding(
            padding: DropdownConstants.noItemAvailablePadding,
            child: Text(widget.emptyItemText),
          );
  }

  Widget _buildNestedListView() {
    Set<String?> uniqueTypes = filteredItems.map((item) => item.type).toSet();
    return filteredItems.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(height: 0),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: uniqueTypes.length,
            itemBuilder: (context, outerIndex) {
              return StatefulBuilder(
                builder: (context, setState) {
                  String? currentType = uniqueTypes.elementAt(outerIndex);
                  List<DropdownItem> typeItems = filteredItems
                      .where((item) => item.type == currentType)
                      .toList();
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: DropdownConstants.nestedItemHeaderPadding,
                        color: const DigitColors().lightPaperSecondary,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(currentType!,
                                style: DigitTheme.instance.mobileTheme.textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                  color: const DigitColors().lightTextSecondary,
                                )),
                          ],
                        ),
                      ),
                      for (int index = 0; index < typeItems.length; index++)
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              children: [
                                InkWell(
                                  splashColor: const DigitColors().transparent,
                                  hoverColor: const DigitColors().transparent,
                                  onTapDown: (_) {
                                    /// Handle mouse down state
                                    setState(() {
                                      isMouseDown = false;
                                      _itemMouseDownStates[
                                          typeItems[index].code] = true;
                                    });
                                  },
                                  onTapUp: (_) {
                                    /// Handle mouse up state
                                    setState(() {
                                      isMouseDown = true;
                                      _itemMouseDownStates[
                                          typeItems[index].code] = false;
                                    });
                                  },
                                  onHover: (hover) {
                                    setState(() {
                                      _itemHoverStates[typeItems[index].code] =
                                          hover;
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      _nestedIndex = typeItems[index].code;
                                    });
                                    widget.onChange(typeItems[index].name,
                                        typeItems[index].code);
                                    _toggleDropdown();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _itemMouseDownStates[
                                                    typeItems[index].code] ==
                                                true
                                            ? Colors.transparent
                                            : _itemHoverStates[typeItems[index]
                                                        .code] ==
                                                    true
                                                ? const DigitColors()
                                                    .lightPrimaryOrange
                                                : Colors.transparent,
                                      ),
                                      color: _itemMouseDownStates[
                                                  typeItems[index].code] ==
                                              true
                                          ? const DigitColors()
                                              .lightPrimaryOrange
                                          : _itemHoverStates[
                                                      typeItems[index].code] ==
                                                  true
                                              ? const DigitColors().orangeBG
                                              : const DigitColors()
                                                  .lightPaperPrimary,
                                    ),
                                    padding: EdgeInsets.zero,
                                    child: Padding(
                                      padding: widget.dropdownType ==
                                                  DropdownType.defaultSelect &&
                                              typeItems[index].description ==
                                                  null
                                          ? DropdownConstants.defaultPadding
                                          : DropdownConstants.nestedItemPadding,
                                      child: Row(
                                        children: [
                                          if (filteredItems[index]
                                                  .profileImage !=
                                              null)
                                            SizedBox(
                                              height: DropdownConstants
                                                  .defaultProfileSize,
                                              width: DropdownConstants
                                                  .defaultProfileSize,
                                              child: CircleAvatar(
                                                radius: DropdownConstants
                                                    .defaultImageRadius,

                                                /// This radius is the radius of the picture in the circle avatar itself.
                                                backgroundImage:
                                                    filteredItems[index]
                                                        .profileImage,
                                                backgroundColor:
                                                    const DigitColors()
                                                        .lightTextSecondary,
                                              ),
                                            ),
                                          if (filteredItems[index]
                                                  .profileImage !=
                                              null)
                                            const SizedBox(
                                              width: 6,
                                            ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  if (typeItems[index]
                                                          .textIcon !=
                                                      null)
                                                    Icon(
                                                      typeItems[index].textIcon,
                                                      size: DropdownConstants
                                                          .textIconSize,
                                                      color: _itemMouseDownStates[
                                                                  typeItems[
                                                                          index]
                                                                      .code] ==
                                                              true
                                                          ? const DigitColors()
                                                              .lightPaperPrimary
                                                          : const DigitColors()
                                                              .lightTextSecondary,
                                                    ),
                                                  if (typeItems[index]
                                                          .textIcon !=
                                                      null)
                                                    const SizedBox(
                                                      width: kPadding / 2,
                                                    ),
                                                  SizedBox(
                                                    width: filteredItems[index]
                                                                .profileImage !=
                                                            null
                                                        ? dropdownWidth - 50
                                                        : filteredItems[index]
                                                                    .textIcon !=
                                                                null
                                                            ? dropdownWidth - 40
                                                            : dropdownWidth -
                                                                16,
                                                    child: Text(
                                                      typeItems[index].name,
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      style: DigitTheme
                                                          .instance
                                                          .mobileTheme
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                        color: _itemMouseDownStates[
                                                                    typeItems[
                                                                            index]
                                                                        .code] ==
                                                                true
                                                            ? const DigitColors()
                                                                .lightPaperPrimary
                                                            : const DigitColors()
                                                                .lightTextSecondary,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              if (typeItems[index]
                                                      .description !=
                                                  null)
                                                SizedBox(
                                                  width: filteredItems[index]
                                                              .profileImage !=
                                                          null
                                                      ? dropdownWidth - 50
                                                      : filteredItems[index]
                                                                  .textIcon !=
                                                              null
                                                          ? dropdownWidth - 40
                                                          : dropdownWidth - 16,
                                                  child: Text(
                                                    typeItems[index]
                                                        .description!,
                                                    maxLines: 3,
                                                    softWrap: true,
                                                    style: DigitTheme
                                                        .instance
                                                        .mobileTheme
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                      color: _itemMouseDownStates[
                                                                  typeItems[
                                                                          index]
                                                                      .code] ==
                                                              true
                                                          ? const DigitColors()
                                                              .lightPaperPrimary
                                                          : const DigitColors()
                                                              .lightTextSecondary,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// Divider after each option
                                Container(
                                  height: 1,
                                  color:
                                      const DigitColors().lightGenericDivider,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      if (outerIndex != uniqueTypes.length - 1)
                        Container(
                          height: kPadding * 2,
                          color: const DigitColors().lightPaperPrimary,
                        ),
                    ],
                  );
                },
              );
            })
        : Padding(
            padding: DropdownConstants.noItemAvailablePadding,
            child: Text(widget.emptyItemText),
          );
  }

  void _navigateDropdown(int direction) {
    if (_focusedIndex == -1) {
      setState(() {
        _focusedIndex = 0;
      });
    } else {
      int newIndex = _focusedIndex + direction;
      if (newIndex < filteredItems.length) {
        setState(() {
          _focusedIndex = newIndex;
        });
      } else if (newIndex >= filteredItems.length) {
        setState(() {
          _focusedIndex = 0;
        });
      } else {
        setState(() {
          _focusedIndex = filteredItems.length - 1;
        });
      }
    }
    _updateOverlay();
  }

  void _selectDropdownOption() {
    if (_focusedIndex != -1) {
      DropdownItem selectedItem = filteredItems[_focusedIndex];
      setState(() => _currentIndex = selectedItem.code);
      widget.onChange(selectedItem.name, selectedItem.code);
      _toggleDropdown(close: true);
    }
  }

  /// function to make change when the dropdown is opening or closing.... we will reset and set the value inside this
  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      /// Check if _overlayEntry is not null before removing
      if (_overlayEntry != null) {
        _overlayEntry?.remove();
      }
      setState(() {
        _isOpen = false;
      });
      setState(() {
        /// Reset the index when opening the dropdown
        _focusedIndex = -1;
        _itemHoverStates = {};
        _itemMouseDownStates = {};
      });
      _focusNode.unfocus();
    } else {
      setState(() {
        /// Reset the index when opening the dropdown
        _itemHoverStates = {};
        _itemMouseDownStates = {};
        _overlayEntry = _createOverlayEntry();
      });
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOpen = true);
    }
    if (_currentIndex != '') {
      /// Find the item with the code matching the current index
      DropdownItem selectedItem = filteredItems.firstWhere(
        (item) => item.code == _currentIndex,
      );

      /// Check if the found item is not the default item
      if (selectedItem.name.isNotEmpty) {
        setState(() {
          widget.textEditingController.text = selectedItem.name;
        });
      }
      _focusNode.unfocus();
    }
    if (widget.dropdownType == DropdownType.nestedSelect &&
        _nestedIndex != '') {
      /// Find the item with the code matching the current index
      DropdownItem selectedItem = filteredItems.firstWhere(
        (item) => item.code == _nestedIndex,
      );

      /// Check if the found item is not the default item
      if (selectedItem.name.isNotEmpty) {
        setState(() {
          widget.textEditingController.text =
              '${selectedItem.type}: ${selectedItem.name}';
        });
      }
      _focusNode.unfocus();
    }
  }
}
