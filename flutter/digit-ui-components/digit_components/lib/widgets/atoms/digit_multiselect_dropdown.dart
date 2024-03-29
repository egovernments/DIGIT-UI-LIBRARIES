library multiselect_dropdown;
/*
the MultiSelectDropDown component is used to create a multi-select dropdown with a list of options.
The onOptionSelected callback is used to handle the selected items, and the appearance of the dropdown, chips,
and other elements can be customized using various properties.

 Example usage:
 ```dart
 MultiSelectDropDown(
             // Provide the list of options
             options: options,
             // Provide the initially selected options
             selectedOptions: selectedOptions,
             // Define the callback function when options are selected/deselected
             onOptionSelected: (List<DropdownItem> selectedItems) {
               // Handle the selected items
               setState(() {
                 selectedOptions = selectedItems;
               });
             },
             // Customize the appearance of chips
             chipConfig: ChipConfig(
               labelStyle: TextStyle(color: Colors.paperPrimary),
               backgroundColor: Colors.blue,
               deleteIconColor: Colors.paperPrimary,
             ),
             // Customize the suffix icon (dropdown arrow)
             suffixIcon: Icon(Icons.arrow_drop_down),
             // Customize the selection type (multiSelect or singleSelect)
             selectionType: SelectionType.multiSelect,
           ),
 ....*/

import 'package:collection/collection.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';
import '../../models/chipModel.dart';
import '../helper_widget/dropdown_options.dart';
import '../helper_widget/selection_chip.dart';

typedef OnOptionSelect<T> = void Function(List<DropdownItem> selectedOptions);

class MultiSelectDropDown<int> extends StatefulWidget {
  /// selection type of the dropdown
  final SelectionType selectionType;

  /// Options
  final List<DropdownItem> options;
  final List<DropdownItem> selectedOptions;
  final OnOptionSelect<int>? onOptionSelected;

  /// chip configuration
  final ChipConfig chipConfig;

  /// dropdownfield configuration
  final IconData? suffixIcon;

  /// focus node
  final FocusNode? focusNode;

  /// Whether the dropdown is enabled or disabled.
  final bool isDisabled;

  /// Whether the dropdown is readOnly.
  final bool readOnly;

  /// Clear All text
  final String clearAllText;

  /// value mapper to show selected options inside the chip
  final List<ValueMapper>? valueMapper;

  /// Controller for the dropdown
  /// [controller] is the controller for the dropdown. It can be used to programmatically open and close the dropdown.
  final MultiSelectController<int>? controller;

  /// custom errorMessage Props
  final String? errorMessage;

  /// custom helpText Props
  final String? helpText;

  const MultiSelectDropDown({
    Key? key,
    required this.onOptionSelected,
    required this.options,
    this.chipConfig = const ChipConfig(),
    this.selectionType = SelectionType.multiSelect,
    this.selectedOptions = const [],
    this.suffixIcon = Icons.arrow_drop_down,
    this.focusNode,
    this.controller,
    this.isDisabled = false,
    this.clearAllText = 'Clear All',
    this.valueMapper,
    this.helpText,
    this.errorMessage,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<MultiSelectDropDown<int>> createState() =>
      _MultiSelectDropDownState<int>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  /// Options list that is used to display the options.
  final List<DropdownItem> _options = [];

  /// Selected options list that is used to display the selected options.
  final List<DropdownItem> _selectedOptions = [];

  /// The controller for the dropdown.
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _selectionMode = false;
  int _focusedIndex = -1;
  NestedFocusedIndex _focusedNestedIndex = NestedFocusedIndex(-1, -1);

  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();

  /// value notifier that is used for controller.
  MultiSelectController<T>? _controller;

  late DigitTypography currentTypography;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? MultiSelectController<T>();
  }

  void _initialize() {
    if (!mounted) return;
    _options.addAll(_controller?.options.isNotEmpty == true
        ? _controller!.options
        : widget.options);
    _addOptions();
    _overlayState ??= Overlay.of(context);
    _focusNode.addListener(_handleFocusChange);
  }

  /// Adds the selected options to the options list.
  void _addOptions() {
    setState(() {
      _selectedOptions.addAll(_controller?.selectedOptions.isNotEmpty == true
          ? _controller!.selectedOptions
          : widget.selectedOptions);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null && _controller?._isDisposed == false) {
        _controller!.setOptions(_options);
        _controller!.setSelectedOptions(_selectedOptions);
        _controller!.addListener(_handleControllerChange);
      }
    });
  }

  /// Handles the focus change to show/hide the dropdown.
  _handleFocusChange() {
    if (_focusNode.hasFocus && mounted) {
      _overlayEntry = _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _focusedIndex = -1;
      _focusedNestedIndex = NestedFocusedIndex(-1, -1);
    }

    if (_focusNode.hasFocus == false && _overlayEntry != null) {
      _overlayEntry?.remove();
      _focusedIndex = -1;
      _focusedNestedIndex = NestedFocusedIndex(-1, -1);
    }

    if (mounted) {
      setState(() {
        _selectionMode = _focusNode.hasFocus == true;
      });
    }

    if (_controller != null) {
      _controller!.value._isDropdownOpen = _focusNode.hasFocus == true;
    }
  }

  /// Handles the widget rebuild when the options are changed externally.
  @override
  void didUpdateWidget(covariant MultiSelectDropDown<T> oldWidget) {
    if (widget.controller == null && oldWidget.controller != null) {
      _controller = MultiSelectController<T>();
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }

    /// If the options are changed externally, then the options are updated.
    if (listEquals(widget.options, oldWidget.options) == false) {
      _options.clear();
      _options.addAll(widget.options);

      /// If the controller is not null, then the options are updated in the controller.
      if (_controller != null) {
        _controller!.setOptions(_options);
      }
    }

    /// If the selected options are changed externally, then the selected options are updated.
    if (listEquals(widget.selectedOptions, oldWidget.selectedOptions) ==
        false) {
      _selectedOptions.clear();
      _selectedOptions.addAll(widget.options
          .where((element) => widget.selectedOptions.contains(element)));

      /// If the controller is not null, then the selected options are updated in the controller.
      if (_controller != null) {
        _controller!.setSelectedOptions(_selectedOptions);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Calculate offset size for dropdown.
  List _calculateOffsetSize() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    var size = renderBox?.size ?? Size.zero;
    var offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

    final availableHeight = MediaQuery.of(context).size.height - offset.dy;

    return [size, availableHeight];
  }

  @override
  Widget build(BuildContext context) {
    currentTypography = getTypography(context);
    double dropdownWidth =
        AppView.isMobileView(MediaQuery.of(context).size.width)
            ? Default.mobileInputWidth
            : Default.desktopInputWidth;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Focus(
            onKey: (FocusNode focusNode, RawKeyEvent event) {
              /// Check for arrow up and arrow down key events
              if (event is RawKeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                  widget.selectionType ==
                      SelectionType.nestedMultiSelect ? _navigateNestedDropdown(-1): _navigateDropdown(-1);
                  return KeyEventResult.handled;
                } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                  widget.selectionType ==
                      SelectionType.nestedMultiSelect ? _navigateNestedDropdown(1): _navigateDropdown(1);
                  return KeyEventResult.handled;
                } else if (event.logicalKey == LogicalKeyboardKey.enter) {
                  widget.selectionType ==
                      SelectionType.nestedMultiSelect ?_selectNestedDropdownOption() :_selectDropdownOption();
                  return KeyEventResult.handled;
                } else if(event.logicalKey == LogicalKeyboardKey.escape){
                  _focusNode.unfocus();
                }
              }
              return KeyEventResult.ignored;
            },
            canRequestFocus: !widget.isDisabled && !widget.readOnly,
            /// Only allow focus if the dropdown is enabled
            skipTraversal: !widget.isDisabled && !widget.readOnly,
            focusNode: _focusNode,
            child: InkWell(
              splashColor: const DigitColors().transparent,
              highlightColor: const DigitColors().transparent,
              hoverColor: const DigitColors().transparent,
              onTap: !widget.isDisabled && !widget.readOnly ? _toggleFocus : null,

              /// Disable onTap if dropdown is disabled
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  height: Default.height,
                  width: dropdownWidth,
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    minHeight: Default.height,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPadding,
                  ),
                  decoration: widget.isDisabled
                      ? _getDisabledContainerDecoration()
                      : widget.readOnly ? _getReadOnlyContainerDecoration() : _getContainerDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                        child: (_selectedOptions.isNotEmpty)
                            ? Text(
                                '${_selectedOptions.length} Selected',
                                style: currentTypography.bodyL.copyWith(
                                  height: 1.5,
                                  color: widget.readOnly ? const DigitColors().light.textSecondary : const DigitColors().light.textPrimary,
                                ),
                              )
                            : const Text(''),
                      ),
                      Icon(
                        widget.suffixIcon,
                        color: widget.isDisabled
                            ? const DigitColors().light.genericDivider
                            : const DigitColors().light.textSecondary,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        if (widget.helpText != null || widget.errorMessage != null)
          const SizedBox(
            height: kPadding / 2,
          ),
        if (widget.helpText != null || widget.errorMessage != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.errorMessage != null
                  ? Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              SizedBox(
                                height: 16,
                                width: 16,
                                child: Icon(
                                  Icons.info,
                                  color: const DigitColors().light.alertError,
                                  size: BaseConstants.errorIconSize,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: kPadding / 2),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text(
                              widget.errorMessage!.length > 256
                                  ? '${widget.errorMessage!.substring(0, 256)}...'
                                  : widget.errorMessage!,
                              style: currentTypography.bodyS.copyWith(
                                height: 1.5,
                                color: const DigitColors().light.alertError,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Text(
                        widget.helpText!.length > 256
                            ? '${widget.helpText!.substring(0, 256)}...'
                            : widget.helpText!,
                        style: currentTypography.bodyS.copyWith(
                          height: 1.5,
                          color: const DigitColors().light.textSecondary,
                        ),
                      ),
                    ),
            ],
          ),
        const SizedBox(
          height: kPadding,
        ),
        if (_anyItemSelected)
          SizedBox(
            width: dropdownWidth,
            child: _getContainerContent(),
          )
      ],
    );
  }

  /// Container Content for the dropdown.
  Widget _getContainerContent() {
    if (_selectedOptions.isEmpty) {
      return const Text('select items to show here');
    }

    return _buildSelectedItems();
  }

  /// return true if any item is selected.
  bool get _anyItemSelected => _selectedOptions.isNotEmpty;

  void _navigateDropdown(int direction) {
    if (_focusedIndex == -1) {
      setState(() {
        _focusedIndex = 0;
      });
    } else {
      int newIndex = _focusedIndex + direction;
      if (newIndex < _options.length && newIndex>=0) {
        setState(() {
          _focusedIndex = newIndex;
        });
      } else if (newIndex >= _options.length) {
        setState(() {
          _focusedIndex = 0;
        });
      } else {
        setState(() {
          _focusedIndex = _options.length - 1;
        });
      }
    }
    _updateOverlay();
  }

  void _navigateNestedDropdown(int direction) {
    final groupedOptions = groupBy(_options, (option) => option.type);

    if (_focusedNestedIndex.group == -1 && _focusedNestedIndex.index == -1) {
      setState(() {
        _focusedNestedIndex = NestedFocusedIndex(0, 0);
      });
    } else {
      int newGroup = _focusedNestedIndex.group;
      int newIndex = _focusedNestedIndex.index + direction;
      var keys = groupedOptions.keys.toList();
      var currentType = keys[newGroup];
      if (groupedOptions.containsKey(currentType)) {
        var currentTypeItems = groupedOptions[currentType]!;
        if (newIndex < currentTypeItems.length && newIndex >= 0) {
          setState(() {
            _focusedNestedIndex = NestedFocusedIndex(newGroup, newIndex);
          });
        } else if (newIndex >= currentTypeItems.length) {
          newGroup++;
          newIndex = 0;

          if (newGroup < groupedOptions.length) {
            setState(() {
              _focusedNestedIndex = NestedFocusedIndex(newGroup, newIndex);
            });
          } else {
            /// Reset to the first group if we are at the end
            setState(() {
              _focusedNestedIndex = NestedFocusedIndex(0, 0);
            });
          }
        } else if (newIndex < 0) {
          newGroup--;

          if (newGroup >= 0) {
            currentTypeItems = groupedOptions[keys[newGroup]]!;
            newIndex = currentTypeItems.length - 1;
            setState(() {
              _focusedNestedIndex = NestedFocusedIndex(newGroup, newIndex);
            });
          } else {
            /// Reset to the last group if we are at the beginning
            setState(() {
              _focusedNestedIndex = NestedFocusedIndex(groupedOptions.length - 1, groupedOptions[keys[groupedOptions.length-1]]!.length-1 );
            });
          }
        }
      }
    }
    _updateOverlay();
  }

  void _selectNestedDropdownOption() {
    var groupedOptions = groupBy(_options, (option) => option.type);

    if (_focusedNestedIndex.group >= 0 && _focusedNestedIndex.group < groupedOptions.length) {
      var currentType = groupedOptions.keys.toList()[_focusedNestedIndex.group];
      var currentTypeItems = groupedOptions[currentType]!;

      if (_focusedNestedIndex.index >= 0 && _focusedNestedIndex.index < currentTypeItems.length) {
        var selectedOption = currentTypeItems[_focusedNestedIndex.index];

        if (!_selectedOptions.contains(selectedOption)) {
          setState(() {
            _selectedOptions.add(selectedOption);
            widget.onOptionSelected?.call(_selectedOptions);
          });

          if (_controller != null) {
            _controller!.addSelectedOption(selectedOption);
          }
        } else {
          setState(() {
            _selectedOptions.remove(selectedOption);
            widget.onOptionSelected?.call(_selectedOptions);
          });

          if (_controller != null) {
            _controller!.clearSelection(selectedOption);
          }
        }
        _updateOverlay();
      }
    }
  }



  void _selectDropdownOption() {
    if (_focusedIndex >= 0 && _focusedIndex < _options.length) {
      final selectedOption = _options[_focusedIndex];
      if (!_selectedOptions.contains(selectedOption)) {
        setState(() {
          _selectedOptions.add(selectedOption);
          widget.onOptionSelected?.call(_selectedOptions);
        });

        if (_controller != null) {
          _controller!.addSelectedOption(selectedOption);
        }
      }else{
        setState(() {
          _selectedOptions.remove(selectedOption);
          widget.onOptionSelected?.call(_selectedOptions);
        });

        if (_controller != null) {
          _controller!.clearSelection(selectedOption);
        }

      }
      _updateOverlay();
    }
  }

  /// Capitalize the first letter if required
  String capitalizeFirstLetter(String text) {
    if (text.isNotEmpty) {
      return text.substring(0, 1).toUpperCase() + text.substring(1);
    }
    return text;
  }

  /// Container decoration for disabled dropdown.
  Decoration _getDisabledContainerDecoration() {
    return BoxDecoration(
      color:  const DigitColors().transparent,
      borderRadius: BorderRadius.zero,
      border: Border.all(
        color: const DigitColors().light.textDisabled,
        width: 1,
      ),
    );
  }

  /// Container decoration for readOnly dropdown.
  Decoration _getReadOnlyContainerDecoration() {
    return BoxDecoration(
      color: const DigitColors().light.genericBackground,
      borderRadius: BorderRadius.zero,
      border: Border.all(
        color:const DigitColors().light.genericInputBorder,
        width: 1,
      ),
    );
  }

  /// Container decoration for the dropdown.
  Decoration _getContainerDecoration() {
    return BoxDecoration(
      color: const DigitColors().light.paperPrimary,
      borderRadius: BorderRadius.zero,
      border: widget.errorMessage!=null ? Border.all(
        color: const DigitColors().light.alertError,
        width: 1.5,
      ): _selectionMode
          ? Border.all(
              color: const DigitColors().light.primaryOrange,
              width: 1.5,
            )
          : Border.all(
              color: const DigitColors().light.genericInputBorder,
              width: 1,
            ),
    );
  }

  /// Dispose the focus node and overlay entry.
  @override
  void dispose() {
    if (_overlayEntry?.mounted == true) {
      if (_overlayState != null && _overlayEntry != null) {
        _overlayEntry?.remove();
      }
      _overlayEntry = null;
      _overlayState?.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller?.removeListener(_handleControllerChange);

    if (widget.controller == null || widget.controller?.isDisposed == true) {
      _controller!.dispose();
    }

    super.dispose();
  }

  /// Handle the focus change on tap outside of the dropdown.
  void _onOutSideTap() {
    _focusNode.unfocus();
  }

  /// Method to toggle the focus of the dropdown.
  void _toggleFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  /// Create the overlay entry for the dropdown.
  OverlayEntry _buildOverlayEntry() {
    /// Calculate the offset and the size of the dropdown button
    final values = _calculateOffsetSize();

    /// Get the size from the first item in the values list
    final size = values[0] as Size;

    return OverlayEntry(builder: (context) {
      List<DropdownItem> options = widget.options;
      List<DropdownItem> selectedOptions = [..._selectedOptions];

      return StatefulBuilder(builder: ((context, dropdownState) {
        /// full screen GestureDetector to register when a user has clicked away from the dropdown
        return GestureDetector(
          onTap: _onOutSideTap,
          behavior: HitTestBehavior.translucent,

          /// full screen SizedBox to register taps anywhere and close drop down
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  offset: Offset.zero,
                  child: Material(
                    borderRadius: BorderRadius.zero,
                    shadowColor: null,
                    child: Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 4.4,
                            spreadRadius: 0,
                            color: Color(0x26000000), // #00000026
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.selectionType ==
                                  SelectionType.nestedMultiSelect
                              ? _buildNestedItems(values, options,
                                  selectedOptions, dropdownState)
                              : _buildFlatOptions(values, options,
                                  selectedOptions, dropdownState),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }));
    });
  }

  /// update the overlay when overlay needs to build again
  void _updateOverlay() {
    if ( _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  Widget _buildFlatOptions(List<dynamic> values, List<DropdownItem> options,
      List<DropdownItem> selectedOptions, StateSetter dropdownState) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Scrollbar(
          radius: const Radius.circular(50),
          thickness: 10,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: values[1] - 30,
            ),
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 0),
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                bool isSelected = selectedOptions.any(
                    (item) => item.code == option.code && item.name == option.name);
                Color backgroundColor = index % 2 == 0
                    ? const DigitColors().light.paperPrimary
                    : const DigitColors().light.paperSecondary;
                bool isFocused = index == _focusedIndex;
                return Column(
                  children: [
                    DropdownOption(
                      option: option,
                      isSelected: selectedOptions.contains(option),
                      backgroundColor: backgroundColor,
                      selectedOptions: selectedOptions,
                      isFocused: isFocused,
                      onOptionSelected: (List<DropdownItem> selectedOptions) {
                        if (isSelected) {
                          dropdownState(() {
                            selectedOptions.remove(option);
                          });
                          setState(() {
                            _selectedOptions.remove(option);
                          });
                        } else {
                          dropdownState(() {
                            selectedOptions.add(option);
                          });
                          setState(() {
                            _selectedOptions.add(option);
                          });
                        }

                        if (_controller != null) {
                          _controller!.value._selectedOptions.clear();
                          _controller!.value._selectedOptions
                              .addAll(_selectedOptions);
                        }
                        widget.onOptionSelected?.call(_selectedOptions);
                      },
                      selectionType: widget.selectionType,
                      focusedIndex: _focusedIndex,
                      onHover: (value, isHover){
                        if(isHover && _focusedIndex!=-1){
                          int hoveredIndex = options.indexWhere((item) => item.code == value.code);
                          setState(() {
                            _focusedIndex = -1;
                          });
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
    );
  }

  Widget _buildNestedItems(List<dynamic> values, List<DropdownItem> options,
      List<DropdownItem> selectedOptions, StateSetter dropdownState) {
    return Scrollbar(
      radius: const Radius.circular(50),
      thickness: 10,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: values[1] - 30,
          ),
          child: _buildNestedOptions(
              values, options, selectedOptions, dropdownState)),
    );
  }
  Widget _buildNestedOptions(List<dynamic> values, List<DropdownItem> options,
      List<DropdownItem> selectedOptions, StateSetter dropdownState) {
    /// Group options by type
    final groupedOptions = groupBy(options, (option) => option.type);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: groupedOptions.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, groupIndex) {
        final type = groupedOptions.keys.elementAt(groupIndex);
        final typeOptions = groupedOptions[type] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (type != null)
              Container(
                width: (values[0] as Size).width,
                padding: const EdgeInsets.all(10),
                color: const DigitColors().light.paperSecondary,
                child: Text(
                  capitalizeFirstLetter(type),
                  style: currentTypography.headingS.copyWith(
                    color: const DigitColors().light.textSecondary,
                  ),
                ),
              ),
            ...typeOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              bool isSelected = selectedOptions.any((item) =>
              item.code == option.code && item.name == option.name);
              Color backgroundColor = const DigitColors().light.paperPrimary;

              bool isFocused = groupIndex == _focusedNestedIndex.group && index == _focusedNestedIndex.index;
              return StatefulBuilder(
                builder: (context, setState) {
                  return DropdownOption(
                    option: option,
                    isSelected: selectedOptions.contains(option),
                    backgroundColor: backgroundColor,
                    selectedOptions: selectedOptions,
                    isFocused: isFocused,
                    onOptionSelected: (List<DropdownItem> selectedOptions) {
                      if (isSelected) {
                        dropdownState(() {
                          selectedOptions.remove(option);
                        });
                        setState(() {
                          _selectedOptions.remove(option);
                        });
                      } else {
                        dropdownState(() {
                          selectedOptions.add(option);
                        });
                        setState(() {
                          _selectedOptions.add(option);
                        });
                      }

                      if (_controller != null) {
                        _controller!.value._selectedOptions.clear();
                        _controller!.value._selectedOptions
                            .addAll(_selectedOptions);
                      }
                      widget.onOptionSelected?.call(_selectedOptions);
                    },
                    selectionType: widget.selectionType,
                  );
                },
              );
            }).toList(),
            if (groupIndex != groupedOptions.length - 1)
              Container(
                height: kPadding * 2,
                color: const DigitColors().light.paperPrimary,
              ),
          ],
        );
      },
    );
  }


  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clear() {
    if (_controller != null && !_controller!._isDisposed) {
      _controller!.clearAllSelection();
    } else {
      setState(() {
        _selectedOptions.clear();
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  /// Build the selected items for the dropdown.
  Widget _buildSelectedItems() {
    return Wrap(
      spacing: widget.chipConfig.spacing,
      runSpacing: widget.chipConfig.runSpacing,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ..._selectedOptions.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          Widget chip = _buildChip(item, widget.chipConfig);

          return IgnorePointer(
            ignoring: widget.readOnly,

            /// Disable pointer events when dropdown is disabled
            child: chip,
          );
        }),
        if (_selectedOptions.isNotEmpty && !widget.readOnly)

          /// Display "Clear All" only if there are selected options
          InkWell(
            onTap: () => clear(),
            hoverColor: const DigitColors().transparent,
            splashColor: const DigitColors().transparent,
            highlightColor: const DigitColors().transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kPadding,
                vertical: kPadding,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const DigitColors().light.primaryOrange,
                ),
                borderRadius: BorderRadius.circular(50),
                color: const DigitColors().light.paperSecondary,
              ),
              child: Text(
                capitalizeFirstLetter(widget.clearAllText),
                style: currentTypography.bodyS.copyWith(
                  color: const DigitColors().light.primaryOrange,
                  height: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Build the selected item chip.
  Widget _buildChip(DropdownItem item, ChipConfig chipConfig) {
    return SelectionChip<T>(
      item: item,
      selectionType: widget.selectionType,
      chipConfig: chipConfig,
      valueMapper: widget.valueMapper,
      onItemDelete: (removedItem) {
        if (_controller != null) {
          _controller!.clearSelection(removedItem);
        } else {
          setState(() {
            _selectedOptions.remove(removedItem);
          });
          widget.onOptionSelected?.call(_selectedOptions);
        }
        if (_focusNode.hasFocus) _focusNode.unfocus();
      },
    );
  }

  /// handle the controller change.
  void _handleControllerChange() {
    /// if the controller is null, return.
    if (_controller == null || _controller?.isDisposed == true) return;

    /// if current options are not equal to the controller's options, update the state.
    if (_options != _controller!.value._options) {
      setState(() {
        _options.clear();
        _options.addAll(_controller!.value._options);
      });
    }

    /// if current selected options are not equal to the controller's selected options, update the state.
    if (_selectedOptions != _controller!.value._selectedOptions) {
      setState(() {
        _selectedOptions.clear();
        _selectedOptions.addAll(_controller!.value._selectedOptions);
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }

    if (_selectionMode != _controller!.value._isDropdownOpen) {
      if (_controller!.value._isDropdownOpen) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    }
  }
}

/// MultiSelect Controller class.
/// This class is used to control the state of the MultiSelectDropdown widget.
/// This is just base class. The implementation of this class is in the MultiSelectController class.
/// The implementation of this class is hidden from the user.
class _MultiSelectController<T> {
  final List<DropdownItem> _options = [];
  final List<DropdownItem> _selectedOptions = [];
  bool _isDropdownOpen = false;
}

/// implementation of the MultiSelectController class.
class MultiSelectController<T>
    extends ValueNotifier<_MultiSelectController<T>> {
  MultiSelectController() : super(_MultiSelectController());

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  /// set the dispose method.
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clearAllSelection() {
    value._selectedOptions.clear();
    notifyListeners();
  }

  /// clear specific selected option
  /// [MultiSelectController] is used to clear specific selected option.
  void clearSelection(DropdownItem option) {
    if (!value._selectedOptions.contains(option)) return;
    value._selectedOptions.remove(option);
    notifyListeners();
  }

  /// select the options
  /// [MultiSelectController] is used to select the options.
  void setSelectedOptions(List<DropdownItem> options) {
    if (options.any((element) => !value._options.contains(element))) {
      throw Exception('Cannot select options that are not in the options list');
    }

    value._selectedOptions.clear();
    value._selectedOptions.addAll(options);
    notifyListeners();
  }

  /// add selected option
  /// [MultiSelectController] is used to add selected option.
  void addSelectedOption(DropdownItem option) {
    if (!value._options.contains(option)) {
      throw Exception('Cannot select option that is not in the options list');
    }

    value._selectedOptions.add(option);
    notifyListeners();
  }

  /// set options
  /// [MultiSelectController] is used to set options.
  void setOptions(List<DropdownItem> options) {
    value._options.clear();
    value._options.addAll(options);
    notifyListeners();
  }

  /// get options
  List<DropdownItem> get options => value._options;

  /// get selected options
  List<DropdownItem> get selectedOptions => value._selectedOptions;

  /// get is dropdown open
  bool get isDropdownOpen => value._isDropdownOpen;

  /// show dropdown
  /// [MultiSelectController] is used to show dropdown.
  void showDropdown() {
    if (value._isDropdownOpen) return;
    value._isDropdownOpen = true;
    notifyListeners();
  }

  /// hide dropdown
  /// [MultiSelectController] is used to hide dropdown.
  void hideDropdown() {
    if (!value._isDropdownOpen) return;
    value._isDropdownOpen = false;
    notifyListeners();
  }
}


class NestedFocusedIndex {
  final int group;
  final int index;

  NestedFocusedIndex(this.group, this.index);
}
