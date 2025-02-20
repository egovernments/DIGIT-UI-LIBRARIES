/// The TreeSelectDropDown component is a Flutter dropdown widget with a tree-like structure, allowing the selection of multiple or single options
/// It initializes the options, selected options, and other configurations.
/// It supports the integration of a TreeSelectController for programmatically controlling the dropdown.
/// It provides customization options for the appearance of the dropdown, chips, and other elements.
/// Example usage:
/// ```dart
///TreeSelectDropDown<int>(
///  // Provide the list of options
///  options: options,
///  // Provide the initially selected options
///  selectedOptions: selectedOptions,
///  // Define the callback function when options are selected/deselected
///  onOptionSelected: (List<TreeNode> selectedItems) {
///    // Handle the selected items
///    setState(() {
///      selectedOptions = selectedItems;
///    });
///  },
///  // Customize the appearance of chips
///  chipConfig: ChipConfig(),
///  // Customize the suffix icon (dropdown arrow)
///  suffixIcon: Icon(Icons.arrow_drop_down),
///  // Customize the selection type (multiSelect or singleSelect)
///  treeSelectionType: TreeSelectionType.multiSelect,
///),

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../helper_widget/tree_node_widget.dart';
import 'digit_chip.dart';

typedef OnOptionSelected<T> = void Function(List<TreeNode> selectedOptions);

class TreeSelectDropDown<int> extends StatefulWidget {
  /// selection type of the dropdown
  final DropdownType treeSelectionType;

  /// Options
  final List<TreeNode> options;
  final List<TreeNode> selectedOptions;
  final OnOptionSelected<int>? onOptionSelected;
  final IconData suffixIcon;
  final Decoration? inputDecoration;

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
  final TreeSelectController<int>? controller;

  /// custom errorMessage Props
  final String? errorMessage;

  /// custom helpText Props
  final String? helpText;

  const TreeSelectDropDown({
    Key? key,
    required this.onOptionSelected,
    required this.options,
    this.treeSelectionType = DropdownType.singleSelect,
    this.selectedOptions = const [],
    this.suffixIcon = Icons.arrow_drop_down,
    this.inputDecoration,
    this.focusNode,
    this.controller,
    this.isDisabled = false,
    this.clearAllText = "Clear All",
    this.valueMapper,
    this.errorMessage,
    this.helpText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<TreeSelectDropDown<int>> createState() =>
      _TreeSelectDropDownState<int>();
}

class _TreeSelectDropDownState<T> extends State<TreeSelectDropDown<T>> {
  /// Options list that is used to display the options.
  final List<TreeNode> _options = [];

  /// Selected options list that is used to display the selected options.
  final List<TreeNode> _selectedOptions = [];
  Map<String, bool> hoverStates = {};
  Map<String, bool> mouseStates = {};

  /// The controller for the dropdown.
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _selectionMode = false;

  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();

  /// value notifier that is used for controller.
  TreeSelectController<T>? _controller;

  late DigitTypography currentTypography;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TreeSelectController<T>();
  }

  void _initialize() {
    if (!mounted) return;
    _options.addAll(_controller?.options.isNotEmpty == true
        ? _controller!.options
        : widget.options);
    _addOptions();
    _overlayState ??= Overlay.of(context);
    hoverStates = {};
    mouseStates = {};
    _focusNode.addListener(_handleFocusChange);
  }

  /// Adds the selected options and disabled options to the options list.
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
      hoverStates = {};
      mouseStates = {};
      Overlay.of(context).insert(_overlayEntry!);
    }

    if (_focusNode.hasFocus == false && _overlayEntry != null) {
      _overlayEntry?.remove();
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
  void didUpdateWidget(covariant TreeSelectDropDown<T> oldWidget) {
    if (widget.controller == null && oldWidget.controller != null) {
      _controller = TreeSelectController<T>();
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
    currentTypography = getTypography(context, false);

    /// Responsive width based on screen size
    double width = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? BaseConstants.tabInputMaxWidth
        : BaseConstants.desktopInputMaxWidth;
    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? BaseConstants.mobileInputMinWidth
        : BaseConstants.desktopInputMaxWidth;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Focus(
            canRequestFocus: !widget.isDisabled && !widget.readOnly,

            /// Only allow focus if the dropdown is enabled
            skipTraversal: !widget.isDisabled && !widget.readOnly,
            focusNode: _focusNode,
            child: InkWell(
              splashColor: const DigitColors().transparent,
              highlightColor: const DigitColors().transparent,
              hoverColor: const DigitColors().transparent,
              onTap:
              !widget.isDisabled && !widget.readOnly ? _toggleFocus : null,

              /// Disable onTap if dropdown is disabled
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  height: Base.height,
                  width: width,
                  constraints: const BoxConstraints(
                    minWidth: Base.mobileInputWidth,
                    minHeight: Base.height,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: spacer2,
                  ),
                  decoration: widget.isDisabled
                      ? _getDisabledContainerDecoration()
                      : widget.readOnly
                      ? _getReadOnlyContainerDecoration()
                      : _getContainerDecoration(),
                  child: Row(
                    children: [
                      Expanded(
                        child: (_selectedOptions.isNotEmpty)
                            ? (widget.treeSelectionType ==
                            DropdownType.multiSelect)
                            ? Text(
                          convertInToSentenceCase(
                              '${_selectedOptions.length} Selected')!,
                          style: currentTypography.bodyL.copyWith(
                            color: widget.readOnly
                                ? const DigitColors()
                                .light
                                .textSecondary
                                : const DigitColors()
                                .light
                                .textPrimary,
                          ),
                        )
                            : Text(
                          convertInToSentenceCase(_selectedOptions
                              .first.code
                              .toString())!,
                          style: currentTypography.bodyL.copyWith(
                            color: widget.readOnly
                                ? const DigitColors()
                                .light
                                .textSecondary
                                : const DigitColors()
                                .light
                                .textPrimary,
                          ),
                        )
                            : const SizedBox(),
                      ),
                      Icon(
                        widget.suffixIcon,
                        color: widget.isDisabled
                            ? const DigitColors().light.textDisabled
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
            height: spacer1,
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
                          height: spacer1 / 2,
                        ),
                        SizedBox(
                          height: spacer4,
                          width: spacer4,
                          child: Icon(
                            Icons.info,
                            color: const DigitColors().light.alertError,
                            size: BaseConstants.errorIconSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: spacer1),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        widget.errorMessage!.length > 256
                            ? '${convertInToSentenceCase(widget.errorMessage!)?.substring(0, 256)}...'
                            : convertInToSentenceCase(
                            widget.errorMessage!)!,
                        style: currentTypography.bodyS.copyWith(
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
                      ? '${convertInToSentenceCase(widget.helpText!)?.substring(0, 256)}...'
                      : widget.helpText!,
                  style: currentTypography.bodyS.copyWith(
                    color: const DigitColors().light.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: spacer2,
        ),
        if (_anyItemSelected &&
            widget.treeSelectionType == DropdownType.multiSelect)
          SizedBox(
            width: width,
            child: _getContainerContent(),
          )
      ],
    );
  }

  /// Container Content for the dropdown.
  Widget _getContainerContent() {
    return _buildSelectedItems();
  }

  /// Build the selected items for the dropdown.
  Widget _buildSelectedItems() {
    return Wrap(
      spacing: spacer2,
      runSpacing: spacer2,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ..._selectedOptions.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          Widget chip = _buildChip(item);

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
                horizontal: spacer2,
                vertical: spacer2,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const DigitColors().light.primary1,
                ),
                borderRadius: BorderRadius.circular(spacer1),
                color: const DigitColors().light.paperSecondary,
              ),
              child: Text(
                convertInToSentenceCase(widget.clearAllText)!,
                style: currentTypography.bodyS.copyWith(
                  color: const DigitColors().light.primary1,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Build the selected item chip.
  Widget _buildChip(TreeNode item) {
    return DigitChip(
      label: widget.valueMapper != null
          ? getAssociatedValue(item.code, widget.valueMapper!)
          : item.name,
      onItemDelete: () {
        if (_controller != null) {
          _controller!.clearSelection(item);
        } else {
          setState(() {
            _selectedOptions.remove(item);
          });

          widget.onOptionSelected?.call(_selectedOptions);
        }
        if (_focusNode.hasFocus) _focusNode.unfocus();
      },
    );
  }

  /// return true if any item is selected.
  bool get _anyItemSelected => _selectedOptions.isNotEmpty;

  /// Container decoration for disabled dropdown.
  Decoration _getDisabledContainerDecoration() {
    return BoxDecoration(
      color: const DigitColors().transparent,
      borderRadius: Base.radius,
      border: Border.all(
        color: const DigitColors().light.textDisabled,
        width: Base.defaultBorderWidth,
      ),
    );
  }

  /// Container decoration for readOnly dropdown.
  Decoration _getReadOnlyContainerDecoration() {
    return BoxDecoration(
      color: const DigitColors().light.genericBackground,
      borderRadius: Base.radius,
      border: Border.all(
        color: const DigitColors().light.genericInputBorder,
        width: Base.defaultBorderWidth,
      ),
    );
  }

  /// Container decoration for the dropdown.
  Decoration _getContainerDecoration() {
    return BoxDecoration(
      color: const DigitColors().light.paperPrimary,
      borderRadius: Base.radius,
      border: widget.errorMessage != null
          ? Border.all(
        color: const DigitColors().light.alertError,
        width: Base.errorBorderWidth,
      )
          : _selectionMode
          ? Border.all(
        color: const DigitColors().light.primary1,
        width: Base.focusedBorderWidth,
      )
          : Border.all(
        color: const DigitColors().light.textSecondary,
        width: Base.defaultBorderWidth,
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
    /// Calculate the offset and the size of the dropdown DigitButton
    final values = _calculateOffsetSize();

    /// Get the size from the first item in the values list
    final size = values[0] as Size;

    return OverlayEntry(builder: (context) {
      List<TreeNode> options = widget.options;
      List<TreeNode> selectedOptions = [..._selectedOptions];

      return StatefulBuilder(builder: ((context, dropdownState) {
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
                    borderRadius: Base.radius,
                    shadowColor: null,
                    clipBehavior: Clip.none,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                            _buildOptions(values, options, selectedOptions,
                                dropdownState),
                          ],
                        ),
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

  Widget _buildOptions(List<dynamic> values, List<TreeNode> options,
      List<TreeNode> selectedOptions, StateSetter dropdownState) {
    return Scrollbar(
      radius: const Radius.circular(Base.defaultCircularRadius),
      thickness: 10,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: values[1] - 30,
        ),
        child: ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 0),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            bool isSelected =
            selectedOptions.any((item) => item.name == option.name);
            Color backgroundColor = index % 2 == 0
                ? const DigitColors().light.paperPrimary
                : const DigitColors().light.paperSecondary;
            return _buildOption(
              option,
              isSelected,
              dropdownState,
              backgroundColor,
              selectedOptions,
            );
          },
        ),
      ),
    );
  }

  Widget _buildOption(
      TreeNode option,
      bool isSelected,
      StateSetter dropdownState,
      Color backgroundColor,
      List<TreeNode> selectedOptions,
      ) {
    return TreeNodeWidget(
      currentOption: option,
      option: option,
      isSelected: isSelected,
      selectedOptions: selectedOptions,
      backgroundColor: backgroundColor,
      currentHorPadding: 22,
      focusNode: _focusNode,
      hoverStates: hoverStates,
      mouseStates: mouseStates,
      treeSelectionType: widget.treeSelectionType,
      onOptionSelected: (updatedOptions) {
        if (widget.treeSelectionType == DropdownType.multiSelect) {
          dropdownState(() {
            selectedOptions.clear();
            selectedOptions.addAll(updatedOptions);
          });
          setState(() {
            _selectedOptions.clear();
            _selectedOptions.addAll(updatedOptions);
          });
        } else {
          dropdownState(() {
            selectedOptions.clear();
            selectedOptions.addAll(updatedOptions);
          });
          setState(() {
            _selectedOptions.clear();
            _selectedOptions.addAll(updatedOptions);
          });
        }

        if (_controller != null) {
          _controller!.value._selectedOptions.clear();
          _controller!.value._selectedOptions.addAll(_selectedOptions);
        }

        widget.onOptionSelected?.call(selectedOptions);
      },
    );
  }

  /// Clear the selected options.
  /// [TreeSelectController] is used to clear the selected options.
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

/// TreeSelect Controller class.
/// This class is used to control the state of the TreeSelectDropdown widget.
/// This is just base class. The implementation of this class is in the TreeSelectController class.
/// The implementation of this class is hidden from the user.
class _TreeSelectController<T> {
  final List<TreeNode> _options = [];
  final List<TreeNode> _selectedOptions = [];
  bool _isDropdownOpen = false;
}

/// implementation of the treeSelectController class.
class TreeSelectController<T> extends ValueNotifier<_TreeSelectController<T>> {
  TreeSelectController() : super(_TreeSelectController());

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  /// set the dispose method.
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  /// Clear the selected options.
  /// [TreeSelectController] is used to clear the selected options.
  void clearAllSelection() {
    value._selectedOptions.clear();
    notifyListeners();
  }

  /// clear specific selected option
  /// [TreeSelectController] is used to clear specific selected option.
  void clearSelection(TreeNode option) {
    if (!value._selectedOptions
        .any((item) => item.code == option.code && item.name == option.name)) {
      return;
    }
    value._selectedOptions.removeWhere(
            (item) => item.code == option.code && item.name == option.name);
    notifyListeners();
  }

  /// select the options
  /// [TreeSelectController] is used to select the options.
  void setSelectedOptions(List<TreeNode> options) {
    if (options.any((element) => !value._options.contains(element))) {
      throw Exception('Cannot select options that are not in the options list');
    }

    value._selectedOptions.clear();
    value._selectedOptions.addAll(options);
    notifyListeners();
  }

  /// add selected option
  /// [TreeSelectController] is used to add selected option.
  void addSelectedOption(TreeNode option) {
    if (!value._options.contains(option)) {
      throw Exception('Cannot select option that is not in the options list');
    }

    value._selectedOptions.add(option);
    notifyListeners();
  }

  /// set options
  /// [TreeSelectController] is used to set options.
  void setOptions(List<TreeNode> options) {
    value._options.clear();
    value._options.addAll(options);
    notifyListeners();
  }

  /// get options
  List<TreeNode> get options => value._options;

  /// get selected options
  List<TreeNode> get selectedOptions => value._selectedOptions;

  /// get is dropdown open
  bool get isDropdownOpen => value._isDropdownOpen;

  /// show dropdown
  /// [TreeSelectController] is used to show dropdown.
  void showDropdown() {
    if (value._isDropdownOpen) return;
    value._isDropdownOpen = true;
    notifyListeners();
  }

  /// hide dropdown
  /// [TreeSelectController] is used to hide dropdown.
  void hideDropdown() {
    if (!value._isDropdownOpen) return;
    value._isDropdownOpen = false;
    notifyListeners();
  }
}