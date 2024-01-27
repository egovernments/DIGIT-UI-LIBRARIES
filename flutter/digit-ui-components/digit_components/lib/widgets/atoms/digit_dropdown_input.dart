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

       // Callback function when an option is selected
       onChange: (value, index) {
         print('Selected: $value'); // Handle the selected value here
       },

       // Optional parameters can be customized as needed
       icon: Icon(Icons.arrow_drop_down),
       dropdownType: DropdownType.defaultSelect,
      emptyItemText: 'No Options available',
)
....*/

import 'package:digit_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final Icon? icon;

  final DropdownType dropdownType;

  /// text to shown, when no options is available....... even while searching if no options matches
  final String emptyItemText;

  const DigitDropdown({
    Key? key,
    required this.items,
    this.icon,
    this.textIcon,
    required this.onChange,
    this.dropdownType = DropdownType.defaultSelect,
    required this.textEditingController,
    this.emptyItemText = "No Options available",
  }) : super(key: key);

  @override
  _DigitDropdownState<T> createState() => _DigitDropdownState<T>();
}

class _DigitDropdownState<T> extends State<DigitDropdown<T>>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  String _currentIndex = '';
  String _nestedIndex = '';
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  late List<DropdownItem> filteredItems;
  late List<DropdownItem> _lastFilteredItems;
  late List<bool> itemHoverStates;
  late List<bool> itemMouseDownStates;

  bool isMouseDown = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    filteredItems = List.from(widget.items);
    _lastFilteredItems = List.from(widget.items);
    itemHoverStates = List.generate(widget.items.length, (index) => false);
    itemMouseDownStates = List.generate(widget.items.length, (index) => false);
    _animationController = AnimationController(
        vsync: this, duration: DropdownConstants.animationDuration);
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();

    /// Dispose the AnimationController
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    print('fromhereeeeeeeeeeeeeeeee');
    if (!_focusNode.hasFocus && isMouseDown) {
      _toggleDropdown(close: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Responsive width based on screen size
    double dropdownWidth =
    AppView.isMobileView(MediaQuery
        .of(context)
        .size
        .width)
        ? Default.mobileInputWidth
        : Default.desktopInputWidth;

    /// link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: SizedBox(
        width: dropdownWidth,
        height: Default.height,
        child: TextField(
          onTap: () {
            _toggleDropdown();
            FocusScope.of(context).requestFocus(_focusNode);
          },
          onChanged: (input) {
            _filterItems(input);
            if (!listEquals(filteredItems, _lastFilteredItems)) {
              _updateOverlay();
              _lastFilteredItems = filteredItems;
            }
          },
          focusNode: _focusNode,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const DigitColors().woodsmokeBlack, width: 1.0),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const DigitColors().burningOrange, width: 1.0),
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: const EdgeInsets.only(
              left: 8,
            ),
            suffixIcon: RotationTransition(
              turns: _rotateAnimation,
              child: widget.icon ?? const Icon(Icons.arrow_drop_down),
            ),
            suffixIconColor: const DigitColors().davyGray,
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
      _overlayEntry!.remove();
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
      builder: (context) =>
          GestureDetector(
            onTap: () => _toggleDropdown(close: true),
            behavior: HitTestBehavior.translucent,

            /// full screen SizedBox to register taps anywhere and close drop down
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                        color: const DigitColors().white,
                        clipBehavior: Clip.none,
                        child: SizeTransition(
                          axisAlignment: 1,
                          sizeFactor: _expandAnimation,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery
                                  .of(context)
                                  .size
                                  .height -
                                  topOffset -
                                  15,
                            ),
                            child: _buildDropdownListView(),
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
    return overlayEntry;
  }

  /// build the dropdown based on the type
  Widget _buildDropdownListView() {
    switch (widget.dropdownType) {
      case DropdownType.defaultSelect:
        return _buildListView();
      case DropdownType.nestedSelect:
        return _buildNestedListView();
    }
  }

  Widget _buildListView() {
    return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 0),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return StatefulBuilder(
            builder: (context, setState) {
              Color backgroundColor = index % 2 == 0
                  ? const DigitColors().white
                  : const DigitColors().alabasterWhite;
              return InkWell(
                onTapDown: (_) {
                  /// Handle mouse down state
                  setState(() {
                    isMouseDown = false;
                    itemMouseDownStates[index] = true;
                  });
                },
                onTapUp: (_) {
                  /// Handle mouse up state
                  setState(() {
                    isMouseDown = true;
                    itemMouseDownStates[index] = false;
                  });
                },
                splashColor: const DigitColors().transaparent,
                hoverColor: const DigitColors().transaparent,
                onHover: (hover) {
                  setState(() {
                    itemHoverStates[index] = hover;
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
                      color: itemMouseDownStates[index] ||
                          itemHoverStates[index]
                          ? const DigitColors().burningOrange
                          : Colors.transparent,
                    ),
                    color: itemMouseDownStates[index] ? const DigitColors()
                        .burningOrange : itemHoverStates[index]
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
                              backgroundImage: filteredItems[index]
                                  .profileImage,
                              backgroundColor: const DigitColors().davyGray,
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
                                    color: itemMouseDownStates[index]
                                        ? const DigitColors().burningOrange
                                        : const DigitColors().davyGray,
                                  ),
                                if (filteredItems[index].textIcon != null)
                                  const SizedBox(
                                    width: kPadding / 2,
                                  ),
                                Text(
                                  filteredItems[index].name,
                                  style: DigitTheme.instance.mobileTheme
                                      .textTheme.bodyLarge
                                      ?.copyWith(
                                      color: itemMouseDownStates[index]
                                          ? const DigitColors().burningOrange
                                          :
                                      const DigitColors().davyGray),
                                )
                              ],
                            ),
                            if (filteredItems[index].description != null)
                              Text(
                                filteredItems[index].description!,
                                style: DigitTheme.instance.mobileTheme
                                    .textTheme.bodySmall
                                    ?.copyWith(
                                  color: itemMouseDownStates[index]
                                      ? const DigitColors().burningOrange
                                      : const DigitColors().davyGray,
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
        }
    );
    // return ListView(
    //   padding: EdgeInsets.zero,
    //   shrinkWrap: true,
    //   children: filteredItems.isNotEmpty
    //       ? filteredItems.asMap().entries.map((item) {
    //     Color backgroundColor = item.key % 2 == 0
    //         ? const DigitColors().white
    //         : const DigitColors().alabasterWhite;
    //
    //     return StatefulBuilder(
    //       builder: (context, setState) {
    //         return InkWell(
    //           splashColor: const DigitColors().transaparent,
    //           hoverColor: const DigitColors().transaparent,
    //           onHover: (hover) {
    //             setState(() {
    //               itemHoverStates[item.key] = hover;
    //             });
    //           },
    //           onTap: () {
    //             setState(() => _currentIndex = item.key);
    //             widget.onChange(item.value.name, 'selected');
    //             _toggleDropdown();
    //           },
    //           child: Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(
    //                 color: itemHoverStates[item.key]
    //                     ? const DigitColors().burningOrange
    //                     : Colors.transparent,
    //               ),
    //               color: itemHoverStates[item.key]
    //                   ? const DigitColors().orangeBG
    //                   : backgroundColor,
    //             ),
    //             padding: EdgeInsets.zero,
    //             child: Padding(
    //               padding:
    //               widget.dropdownType == DropdownType.defaultSelect &&
    //                   item.value.description == null
    //                   ? DropdownConstants.defaultPadding
    //                   : DropdownConstants.nestedItemPadding,
    //               child: Row(
    //                 children: [
    //                   if (widget.dropdownType ==
    //                       DropdownType.profileSelect)
    //                     SizedBox(
    //                       height: DropdownConstants.defaultProfileSize,
    //                       width: DropdownConstants.defaultProfileSize,
    //                       child: CircleAvatar(
    //                         radius: DropdownConstants.defaultImageRadius,
    //
    //                         /// This radius is the radius of the picture in the circle avatar itself.
    //                         backgroundImage: item.value.profileImage,
    //                         backgroundColor: const DigitColors().davyGray,
    //                       ),
    //                     ),
    //                   if (widget.dropdownType ==
    //                       DropdownType.profileSelect)
    //                     const SizedBox(
    //                       width: 6,
    //                     ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           if (item.value.textIcon != null)
    //                             Icon(
    //                               item.value.textIcon,
    //                               size: DropdownConstants.textIconSize,
    //                               color: const DigitColors().davyGray,
    //                             ),
    //                           if (item.value.textIcon != null)
    //                             const SizedBox(
    //                               width: kPadding / 2,
    //                             ),
    //                           Text(
    //                             item.value.name,
    //                             style: DigitTheme.instance.mobileTheme
    //                                 .textTheme.bodyLarge
    //                                 ?.copyWith(
    //                                 color:
    //                                 const DigitColors().davyGray),
    //                           )
    //                         ],
    //                       ),
    //                       if (item.value.description != null)
    //                         Text(
    //                           item.value.description!,
    //                           style: DigitTheme.instance.mobileTheme
    //                               .textTheme.bodySmall
    //                               ?.copyWith(
    //                             color: const DigitColors().davyGray,
    //                           ),
    //                         ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   }).toList()
    //       : [
    //     Center(
    //       child: Padding(
    //         padding: DropdownConstants.noItemAvailablePadding,
    //         child: Text(widget.emptyItemText),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _buildNestedListView() {
    Set<String?> uniqueTypes = filteredItems.map((item) => item.type).toSet();
    return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 0),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: uniqueTypes.length,
        itemBuilder: (context, outerIndex) {
          return StatefulBuilder(
            builder: (context, setState) {
              String? currentType = uniqueTypes.elementAt(outerIndex);
              List<DropdownItem> typeItems = filteredItems.where((item) => item.type == currentType).toList();
              return Column(
                children: [
                  Container(
                    padding: DropdownConstants.nestedItemHeaderPadding,
                    color: const DigitColors().alabasterWhite,
                    child: Text(currentType!,
                        style: DigitTheme.instance.mobileTheme.textTheme
                            .headlineSmall
                            ?.copyWith(
                          color: const DigitColors().davyGray,
                        )),
                  ),
                  ListView.builder(
                    // separatorBuilder: (_, __) => const SizedBox(height: 0),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: typeItems.length,
                    itemBuilder: (context, index) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            children: [
                              InkWell(
                                splashColor: const DigitColors().transaparent,
                                hoverColor: const DigitColors().transaparent,
                                onHover: (hover) {
                                  setState(() {
                                    itemHoverStates[index] = hover;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    _nestedIndex = typeItems[index].code;
                                  });
                                  widget.onChange(typeItems[index].name, typeItems[index].code);
                                  _toggleDropdown();
                                },
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: itemHoverStates[index]
                                          ? const DigitColors().burningOrange
                                          : Colors.transparent,
                                    ),
                                    color: itemHoverStates[index]
                                        ? const DigitColors().orangeBG
                                        : const DigitColors().white,
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: Padding(
                                    padding: widget.dropdownType ==
                                        DropdownType.defaultSelect &&
                                        typeItems[index].description == null
                                        ? DropdownConstants.defaultPadding
                                        : DropdownConstants.nestedItemPadding,
                                    child: Row(
                                      children: [
                                        // if (filteredItems[index].profileImage!=null)
                                        //   SizedBox(
                                        //     height: DropdownConstants.defaultProfileSize,
                                        //     width: DropdownConstants.defaultProfileSize,
                                        //     child: CircleAvatar(
                                        //       radius:
                                        //       DropdownConstants.defaultImageRadius,
                                        //
                                        //       /// This radius is the radius of the picture in the circle avatar itself.
                                        //       backgroundImage: item.profileImage,
                                        //       backgroundColor:
                                        //       const DigitColors().davyGray,
                                        //     ),
                                        //   ),
                                        // if (filteredItems[index].profileImage!=null)
                                        //   const SizedBox(
                                        //     width: 6,
                                        //   ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                if (typeItems[index].textIcon != null)
                                                  Icon(
                                                    typeItems[index].textIcon,
                                                    size: DropdownConstants.textIconSize,
                                                    color: const DigitColors().davyGray,
                                                  ),
                                                if (typeItems[index].textIcon != null)
                                                  const SizedBox(
                                                    width: kPadding / 2,
                                                  ),
                                                Text(
                                                  typeItems[index].name,
                                                  style: DigitTheme.instance.mobileTheme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                      color: const DigitColors()
                                                          .davyGray),
                                                )
                                              ],
                                            ),
                                            if (typeItems[index].description != null)
                                              Text(
                                                typeItems[index].description!,
                                                style: DigitTheme.instance.mobileTheme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: const DigitColors().davyGray,
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
                                height: 2,
                                color: const DigitColors().quillGray,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              )

                              /// Divider after each option
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
    );
  }

  // List<Widget> _buildGroupedItems() {
  //   List<Widget> groupedItems = [];
  //   Set<String?> uniqueTypes = filteredItems.map((item) => item.type).toSet();
  //
  //   for (String? type in uniqueTypes) {
  //     if (type != null) {
  //       /// header for the type
  //       groupedItems.add(
  //         Container(
  //           padding: DropdownConstants.nestedItemHeaderPadding,
  //           color: const DigitColors().alabasterWhite,
  //           child: Text(type,
  //               style: DigitTheme.instance.mobileTheme.textTheme.headlineSmall
  //                   ?.copyWith(
  //                 color: const DigitColors().davyGray,
  //               )),
  //         ),
  //       );
  //
  //       /// items of the current type
  //       List<DropdownItem> typeItems =
  //       filteredItems.where((item) => item.type == type).toList();
  //
  //       for (DropdownItem item in typeItems) {
  //         groupedItems.add(
  //           StatefulBuilder(
  //             builder: (context, setState) {
  //               return Column(
  //                 children: [
  //                   InkWell(
  //                     splashColor: const DigitColors().transaparent,
  //                     hoverColor: const DigitColors().transaparent,
  //                     onHover: (hover) {
  //                       setState(() {
  //                         itemHoverStates[typeItems.indexOf(item)] = hover;
  //                       });
  //                     },
  //                     onTap: () {
  //                       setState(() {
  //                         _nestedSelected = '$type,${item.name}';
  //                         _nestedIndex = 1;
  //                       });
  //                       widget.onChange(item.name, type);
  //                       _toggleDropdown();
  //                     },
  //                     child: Container(
  //                       width: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .width,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: itemHoverStates[typeItems.indexOf(item)]
  //                               ? const DigitColors().burningOrange
  //                               : Colors.transparent,
  //                         ),
  //                         color: itemHoverStates[typeItems.indexOf(item)]
  //                             ? const DigitColors().orangeBG
  //                             : const DigitColors().white,
  //                       ),
  //                       padding: EdgeInsets.zero,
  //                       child: Padding(
  //                         padding: widget.dropdownType ==
  //                             DropdownType.defaultSelect &&
  //                             item.description == null
  //                             ? DropdownConstants.defaultPadding
  //                             : DropdownConstants.nestedItemPadding,
  //                         child: Row(
  //                           children: [
  //                             // if (filteredItems[index].profileImage!=null)
  //                             //   SizedBox(
  //                             //     height: DropdownConstants.defaultProfileSize,
  //                             //     width: DropdownConstants.defaultProfileSize,
  //                             //     child: CircleAvatar(
  //                             //       radius:
  //                             //       DropdownConstants.defaultImageRadius,
  //                             //
  //                             //       /// This radius is the radius of the picture in the circle avatar itself.
  //                             //       backgroundImage: item.profileImage,
  //                             //       backgroundColor:
  //                             //       const DigitColors().davyGray,
  //                             //     ),
  //                             //   ),
  //                             // if (filteredItems[index].profileImage!=null)
  //                             //   const SizedBox(
  //                             //     width: 6,
  //                             //   ),
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     if (item.textIcon != null)
  //                                       Icon(
  //                                         item.textIcon,
  //                                         size: DropdownConstants.textIconSize,
  //                                         color: const DigitColors().davyGray,
  //                                       ),
  //                                     if (item.textIcon != null)
  //                                       const SizedBox(
  //                                         width: kPadding / 2,
  //                                       ),
  //                                     Text(
  //                                       item.name,
  //                                       style: DigitTheme.instance.mobileTheme
  //                                           .textTheme.bodyLarge
  //                                           ?.copyWith(
  //                                           color: const DigitColors()
  //                                               .davyGray),
  //                                     )
  //                                   ],
  //                                 ),
  //                                 if (item.description != null)
  //                                   Text(
  //                                     item.description!,
  //                                     style: DigitTheme.instance.mobileTheme
  //                                         .textTheme.bodySmall
  //                                         ?.copyWith(
  //                                       color: const DigitColors().davyGray,
  //                                     ),
  //                                   ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   /// Divider after each option
  //                   Container(
  //                     height: 2,
  //                     color: const DigitColors().quillGray,
  //                     width: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .width,
  //                     margin: const EdgeInsets.symmetric(
  //                       horizontal: 10,
  //                     ),
  //                   )
  //
  //                   /// Divider after each option
  //                 ],
  //               );
  //             },
  //           ),
  //         );
  //       }
  //     }
  //   }
  //
  //   /// Add a message if no options are available
  //   if (groupedItems.isEmpty) {
  //     groupedItems.add(
  //       Center(
  //         child: Padding(
  //           padding: DropdownConstants.noItemAvailablePadding,
  //           child: Text(widget.emptyItemText),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return groupedItems;
  // }

  /// function to make change when the dropdown is opening or closing.... we will reset and set the value inside this
  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      setState(() {
        _currentIndex = '';

        /// Reset the index when opening the dropdown
        _nestedIndex = '';

        /// Reset the index when opening the dropdown
        _overlayEntry = _createOverlayEntry();
      });
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
    if (_currentIndex != '') {
      // Find the item with the code matching the current index
      DropdownItem selectedItem = filteredItems.firstWhere(
            (item) => item.code == _currentIndex,
      );

      // Check if the found item is not the default item
      if (selectedItem.name.isNotEmpty) {
        setState(() {
          widget.textEditingController.text = selectedItem.name;
        });
      }
    }
    if (widget.dropdownType == DropdownType.nestedSelect &&
        _nestedIndex != '') {
      // Find the item with the code matching the current index
      DropdownItem selectedItem = filteredItems.firstWhere(
            (item) => item.code == _nestedIndex,
      );

      // Check if the found item is not the default item
      if (selectedItem.name.isNotEmpty) {
        setState(() {
          widget.textEditingController.text = '${selectedItem.type}: ${selectedItem.name}';
        });
      }
    }
  }
}