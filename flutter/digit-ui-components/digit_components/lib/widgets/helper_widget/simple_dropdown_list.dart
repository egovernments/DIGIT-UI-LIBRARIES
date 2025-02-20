import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/utils.dart';

class DropdownListView extends StatefulWidget {
  final List<DropdownItem> items;
  final double width;
  final Function(DropdownItem?) onSelect;
  final bool searchable;
  final bool isOpen;

  /// text to shown, when no options is available....... even while searching if no options matches
  final String emptyItemText;

  const DropdownListView({
    Key? key,
    required this.items,
    required this.width,
    required this.onSelect,
    this.searchable = false,
    this.emptyItemText = "No Options available",
    this.isOpen = false,
  }) : super(key: key);

  @override
  _DropdownListViewState createState() => _DropdownListViewState();
}

class _DropdownListViewState extends State<DropdownListView> {
  late int _focusedIndex;
  late Map<String, bool> _itemMouseDownStates;
  late Map<String, bool> _itemHoverStates;
  late List<DropdownItem> filteredItems;
  late FocusNode _focusNode; // Add FocusNode
  late FocusNode _searchFocusNode;
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _focusedIndex = -1;
    filteredItems = List.from(widget.items);
    _itemMouseDownStates = {};
    _itemHoverStates = {};
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _searchFocusNode = FocusNode();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _focusNode.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _scrollToFocusedIndex() {
    if (_focusedIndex >= 0 && _focusedIndex < filteredItems.length) {
      // Adjust the scroll offset calculation
      double itemHeight = 50.0; // Adjust based on your item height
      double screenHeight = MediaQuery.of(context).size.height;
      double offset = (_focusedIndex * itemHeight) - (screenHeight / 2) + (itemHeight / 2);

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    if(widget.isOpen){
      _searchFocusNode.requestFocus();
    }

    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            setState(() {
              _focusedIndex = (_focusedIndex + 1) % filteredItems.length;
            });
            _scrollToFocusedIndex();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            setState(() {
              _focusedIndex =
                  (_focusedIndex - 1) % filteredItems.length;
              if (_focusedIndex < 0) {
                _focusedIndex = filteredItems.length - 1;
              }
            });
            _scrollToFocusedIndex();
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
            if(_focusedIndex!=-1){
              widget.onSelect(filteredItems[_focusedIndex]);
            }else{
              widget.onSelect(null);
            }

          }else if(event.logicalKey == LogicalKeyboardKey.escape){
            widget.onSelect(null);
          }

        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: widget.searchable,
            child: Container(
              color: const DigitColors().light.paperPrimary,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DigitSearchFormInput(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChange: (value) {
                    _focusedIndex = -1;
                    setState(() {
                      filteredItems = widget.items
                          .where((item) => item.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  onFieldSubmitted: (value) {
                    if(_focusedIndex!=-1){
                      widget.onSelect(filteredItems[_focusedIndex]);
                    }else{
                      widget.onSelect(null);
                    }
                  },
                ),
              ),
            ),
          ),
          filteredItems.isNotEmpty
              ? Flexible(
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 0),
              shrinkWrap: true,
              controller: _scrollController,
              padding: EdgeInsets.zero,
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    final DropdownItem item = filteredItems[index];
                    Color backgroundColor = index % 2 == 0
                        ? const DigitColors().light.paperSecondary
                        : const DigitColors().light.paperPrimary;

                    return InkWell(
                      onTapDown: (_) {
                        /// Handle mouse down state
                        setState(() {
                          _itemMouseDownStates[item.code] = true;
                        });
                      },
                      onTapUp: (_) {
                        /// Handle mouse up state
                        setState(() {
                          _itemMouseDownStates[item.code] = false;
                        });
                      },
                      splashColor: const DigitColors().transparent,
                      hoverColor: const DigitColors().transparent,
                      highlightColor: const DigitColors().transparent,
                      onHover: (hover) {
                        setState(() {
                          _itemHoverStates[item.code] =
                              hover ;
                        });
                      },
                      onTap: () {
                        widget.onSelect(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: .5,
                            color: _itemMouseDownStates[item.code] ==
                                true ||
                                _itemHoverStates[item.code] == true ||
                                _focusedIndex == index
                                ? const DigitColors().light.primary1
                                : Colors.transparent,
                          ),
                          color: _itemMouseDownStates[item.code] == true
                              ? const DigitColors().light.primary1
                              : _itemHoverStates[item.code] == true ||
                              _focusedIndex == index
                              ? const DigitColors().light.primary1Bg
                              : backgroundColor,
                        ),
                        padding: EdgeInsets.zero,
                        child: Padding(
                          padding: item.description == null
                              ? item.profileImageUrl == null
                              ? const EdgeInsets.only(
                            left: 10,
                            top: 10.5,
                            bottom: 10.5,
                          )
                              : const EdgeInsets.only(
                            left: 10,
                            top: 8,
                            bottom: 8,
                          )
                              : item.profileImageUrl == null
                              ? const EdgeInsets.only(
                            left: 10,
                            top: 8,
                            bottom: 8,
                          )
                              : const EdgeInsets.only(
                            left: 16,
                            top: 14.5,
                            bottom: 14.5,
                          ),
                          child: Row(
                            children: [
                              if (item.profileImageUrl != null)
                                SizedBox(
                                  height: item.description != null
                                      ? 47
                                      : DropdownConstants
                                      .defaultProfileSize,
                                  width: item.description != null
                                      ? 47
                                      : DropdownConstants
                                      .defaultProfileSize,
                                  child: Container(
                                    height: item.description != null
                                        ? 47
                                        : 32,
                                    width: item.description != null
                                        ? 47
                                        : 32,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                          DropdownConstants
                                              .defaultImageRadius,
                                        )),
                                    child: ClipOval(
                                      child: Image.network(
                                        item.profileImageUrl!,
                                        loadingBuilder: (context, child,
                                            loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Container();
                                          }
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                              color: const DigitColors()
                                                  .light
                                                  .paperPrimary,
                                              child:
                                              const Icon(Icons.add));
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              if (item.profileImageUrl != null)
                                SizedBox(
                                  width:
                                  item.description != null ? 16 : 10,
                                ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      if (item.textIcon != null)
                                        Icon(
                                          item.textIcon,
                                          size: DropdownConstants
                                              .textIconSize,
                                          color: _itemMouseDownStates[
                                          item.code] ==
                                              true
                                              ? const DigitColors()
                                              .light
                                              .paperPrimary
                                              : const DigitColors()
                                              .light
                                              .textSecondary,
                                        ),
                                      if (item.textIcon != null)
                                        const SizedBox(
                                          width: spacer1,
                                        ),
                                      SizedBox(
                                        width:
                                        item.profileImageUrl != null
                                            ? item.description != null
                                            ? widget.width - 80
                                            : widget.width - 53
                                            : item.textIcon != null
                                            ? widget.width - 40
                                            : widget.width - 16,
                                        child: Text(
                                          convertInToSentenceCase(
                                              item.name)!,
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: _itemMouseDownStates[
                                          item.code] ==
                                              true
                                              ? currentTypography.headingS
                                              .copyWith(
                                              color:
                                              const DigitColors()
                                                  .light
                                                  .paperPrimary)
                                              : item.description != null
                                              ? currentTypography
                                              .bodyL
                                              .copyWith(
                                              color: const DigitColors()
                                                  .light
                                                  .textSecondary)
                                              : currentTypography
                                              .bodyS
                                              .copyWith(
                                              color: const DigitColors()
                                                  .light
                                                  .textPrimary),
                                        ),
                                      )
                                    ],
                                  ),
                                  if (item.description != null)
                                    SizedBox(
                                      width: item.profileImageUrl != null
                                          ? item.description != null
                                          ? widget.width - 80
                                          : widget.width - 53
                                          : item.textIcon != null
                                          ? widget.width - 40
                                          : widget.width - 16,
                                      child: Text(
                                        convertInToSentenceCase(
                                            item.description!)!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        softWrap: true,
                                        style: currentTypography.bodyXS
                                            .copyWith(
                                          color: _itemMouseDownStates[
                                          item.code] ==
                                              true
                                              ? const DigitColors()
                                              .light
                                              .paperPrimary
                                              : const DigitColors()
                                              .light
                                              .textSecondary,
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
            ),
          )
              : Container(
            color: const DigitColors().light.paperPrimary,
            width: widget.width,
            child: Container(
              color: const DigitColors().light.paperSecondary,
              child: Padding(
                padding: DropdownConstants.noItemAvailablePadding,
                child: Text(
                  convertInToSentenceCase(widget.emptyItemText)!,
                  style: currentTypography.bodyS.copyWith(
                    color: const DigitColors().light.textDisabled,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}