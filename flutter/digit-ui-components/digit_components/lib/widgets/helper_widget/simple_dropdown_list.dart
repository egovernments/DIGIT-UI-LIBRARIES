import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_constants.dart';
import '../../models/DropdownModels.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';
import '../../utils/utils.dart';
import '../atoms/digit_search_form_input.dart';

class DropdownListView extends StatefulWidget {
  final List<DropdownItem> items;
  final double width;
  final Function(DropdownItem) onSelect;
  final bool searchable;

  /// text to shown, when no options is available....... even while searching if no options matches
  final String emptyItemText;

  const DropdownListView({
    Key? key,
    required this.items,
    required this.width,
    required this.onSelect,
    this.searchable = false,
    this.emptyItemText = "No Options available",
  }) : super(key: key);

  @override
  _DropdownListViewState createState() => _DropdownListViewState();
}

class _DropdownListViewState extends State<DropdownListView> {
  late int _focusedIndex;
  late Map<String, bool> _itemMouseDownStates;
  late Map<String, bool> _itemHoverStates;
  late bool _isKeyboardFocused; // Track keyboard focus
  late List<DropdownItem> filteredItems;
  late FocusNode _focusNode; // Add FocusNode
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusedIndex = -1;
    filteredItems = List.from(widget.items);
    _itemMouseDownStates = {};
    _itemHoverStates = {};
    _isKeyboardFocused = false; // Initialize to false
    _focusNode = FocusNode(); // Initialize FocusNode
    _focusNode.requestFocus(); // Request focus initially
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    return Column(
      children: [
        if(widget.searchable)
          Padding(
            padding:
            const EdgeInsets.all(8),
            child: DigitSearchFormInput(
              controller: _searchController,
              innerLabel: 'Search',
              onChange: (value) {
                setState(() {
                  filteredItems = widget.items
                      .where(
                          (item) =>
                          item.name.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
        filteredItems.isNotEmpty ? RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                setState(() {
                  _focusedIndex =
                      (_focusedIndex + 1) %
                          filteredItems.length; // Move focus down
                  _isKeyboardFocused = true; // Set keyboard focus
                });
              } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                setState(() {
                  _focusedIndex = (_focusedIndex - 1) %
                      filteredItems.length; // Move focus up
                  if (_focusedIndex < 0) {
                    _focusedIndex = filteredItems.length - 1;
                  }
                  _isKeyboardFocused = true; // Set keyboard focus
                });
              } else if (event.logicalKey == LogicalKeyboardKey.enter) {
                widget.onSelect(
                    filteredItems[_focusedIndex]); // Select item on pressing Enter
              }
            }
          },
          child: Scrollbar(
            radius: const Radius.circular(50),
            thickness: 10,
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 0),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    final DropdownItem item = filteredItems[index];
                    Color backgroundColor = index % 2 == 0
                        ? const DigitColors().light.paperPrimary
                        : const DigitColors().light.paperSecondary;

                    return InkWell(
                      onTapDown: (_) {
                        /// Handle mouse down state
                        setState(() {
                          _itemMouseDownStates[item.code] =
                          true;
                          _isKeyboardFocused = false;
                        });
                      },
                      onTapUp: (_) {
                        /// Handle mouse up state
                        setState(() {
                          _itemMouseDownStates[item.code] =
                          false;
                        });
                      },
                      splashColor: const DigitColors().transparent,
                      hoverColor: const DigitColors().transparent,
                      highlightColor: const DigitColors().transparent,
                      onHover: (hover) {
                        setState(() {
                          _itemHoverStates[item.code] =
                              hover && !_isKeyboardFocused;
                        });
                      },
                      onTap: () {
                        widget.onSelect(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: .5,
                            color: _itemMouseDownStates[
                            item.code] ==
                                true ||
                                _itemHoverStates[
                                item.code] ==
                                    true || _focusedIndex == index
                                ? const DigitColors().light.primary1
                                : Colors.transparent,
                          ),
                          color: _itemMouseDownStates[
                          item.code] ==
                              true
                              ? const DigitColors().light.primary1
                              : _itemHoverStates[item.code] ==
                              true || _focusedIndex == index
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
                                  height: item.description !=
                                      null
                                      ? 47
                                      : DropdownConstants.defaultProfileSize,
                                  width: item.description !=
                                      null
                                      ? 47
                                      : DropdownConstants.defaultProfileSize,
                                  child: Container(
                                    height:
                                    item.description != null
                                        ? 47
                                        : 32,
                                    width:
                                    item.description != null
                                        ? 47
                                        : 32,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          DropdownConstants.defaultImageRadius,
                                        )),
                                    child: ClipOval(
                                      child: Image.network(
                                        item.profileImageUrl!,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
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
                                              child: const Icon(Icons.add));
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              if (item.profileImageUrl != null)
                                SizedBox(
                                  width:
                                  item.description != null
                                      ? 16
                                      : 10,
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      if (item.textIcon != null)
                                        Icon(
                                          item.textIcon,
                                          size: DropdownConstants.textIconSize,
                                          color: _itemMouseDownStates[
                                          item
                                              .code] ==
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
                                          width: kPadding / 2,
                                        ),
                                      SizedBox(
                                        width: item
                                            .profileImageUrl !=
                                            null
                                            ? item
                                            .description !=
                                            null ? widget.width - 80 : widget
                                            .width - 53
                                            : item.textIcon !=
                                            null
                                            ? widget.width - 40
                                            : widget.width - 16,
                                        child: Text(
                                          convertInToSentenceCase(item.name)!,
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: _itemMouseDownStates[item
                                              .code] ==
                                              true
                                              ? currentTypography.headingS
                                              .copyWith(
                                              color: const DigitColors()
                                                  .light
                                                  .paperPrimary)
                                              : item.description !=
                                              null
                                              ? currentTypography.bodyL
                                              .copyWith(
                                              color: const DigitColors()
                                                  .light
                                                  .textSecondary)
                                              : currentTypography.bodyS
                                              .copyWith(
                                              color: const DigitColors().light
                                                  .textPrimary),
                                        ),
                                      )
                                    ],
                                  ),
                                  if (item.description != null)
                                    SizedBox(
                                      width: item
                                          .profileImageUrl !=
                                          null
                                          ? item
                                          .description !=
                                          null ? widget.width - 80 : widget
                                          .width - 53
                                          : item.textIcon !=
                                          null
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
                                          item
                                              .code] ==
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
          ),
        )
            : Container(
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
      ],
    );
  }

}
