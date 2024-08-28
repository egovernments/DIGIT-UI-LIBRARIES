import 'dart:math';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../../models/TreeModel.dart';
import '../../theme/ComponentTheme/checkbox_theme.dart';
import '../../theme/theme.dart';
import '../atoms/digit_checkbox_icon.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNode option;
  final TreeNode? parentNode;
  final TreeNode currentOption;
  final bool isSelected;
  final Map<String, bool>? hoverStates;
  final Map<String, bool>? mouseStates;
  final List<TreeNode> selectedOptions;
  final Color backgroundColor;
  final ValueChanged<List<TreeNode>> onOptionSelected;
  final FocusNode focusNode;
  final DropdownType treeSelectionType;
  final double currentHorPadding;

  const TreeNodeWidget({
    Key? key,
    required this.option,
    this.parentNode,
    required this.currentOption,
    required this.isSelected,
    required this.selectedOptions,
    required this.onOptionSelected,
    required this.backgroundColor,
    required this.focusNode,
    required this.treeSelectionType,
    this.hoverStates,
    this.mouseStates,
    this.currentHorPadding = 10,
  }) : super(key: key);

  @override
  _TreeNodeWidgetState createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool _isExpanded = false;
  bool _isSelected = false;

  /// Capitalize the first letter if required
  String capitalizeFirstLetter(String text) {
    if (text.isNotEmpty) {
      return text.substring(0, 1).toUpperCase() + text.substring(1);
    }
    return text;
  }

  /// Update _areAllChildrenSelected method in _TreeNodeWidgetState
  bool _areAllChildrenSelected(TreeNode node) {
    if (node.children.isEmpty) {
      return widget.selectedOptions.any((item) => item.code == node.code);
    }

    return node.children.every((child) => _areAllChildrenSelected(child));
  }

  /// Update _isAnyChildSelected method in _TreeNodeWidgetState
  bool _isAnyChildSelected(TreeNode node) {
    return node.children.any((child) =>
    widget.selectedOptions.any((item) => item.code == child.code) ||
        _isAnyChildSelected(child));
  }

  /// Update _selectAllChildren method in _TreeNodeWidgetState
  void _selectAllChildren(TreeNode node) {
    if (node.children.isEmpty) {
      if (!widget.selectedOptions.any((item) => item.code == node.code)) {
        widget.onOptionSelected([...widget.selectedOptions, node]);
      }
    } else {
      for (final child in node.children) {
        _selectAllChildren(child);
      }
    }
  }

  /// Update _deselectAllChildren method in _TreeNodeWidgetState
  void _deselectAllChildren(TreeNode node) {
    if (node.children.isEmpty) {
      widget.onOptionSelected([...widget.selectedOptions]
        ..removeWhere((item) => item.code == node.code));
    } else {
      for (final child in node.children) {
        _deselectAllChildren(child);
      }
    }
  }

  Color _calculateBackgroundColor(TreeNode node, TreeNode? parentNode) {
    if (parentNode != null && _areAllChildrenSelected(parentNode)) {
      return const DigitColors().light.primary1Bg;
    } else if (_areAllChildrenSelected(node) &&
        widget.treeSelectionType == DropdownType.multiSelect) {
      return const DigitColors().light.primary1;
    } else {
      return widget.hoverStates?[widget.currentOption.code] == true
          ? const DigitColors().light.primary1Bg
          : _isExpanded
          ? const DigitColors().light.paperSecondary
          : widget.backgroundColor;
    }
  }

  bool _parentSelected(TreeNode node, TreeNode? parentNode) {
    if (parentNode != null && _areAllChildrenSelected(parentNode)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    DigitTypography currentTypography = getTypography(context, false);
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          InkWell(
            onTapDown: (_) {
              /// Handle mouse down state
              setState(() {
                widget.mouseStates?[widget.currentOption.code] = true;
              });
            },
            onTapUp: (_) {
              /// Handle mouse up state
              setState(() {
                widget.mouseStates?[widget.currentOption.code] = false;
              });
            },
            splashColor: const DigitColors().transparent,
            hoverColor: const DigitColors().transparent,
            highlightColor: const DigitColors().transparent,
            onHover: (hover) {
              setState(() {
                widget.hoverStates?[widget.currentOption.code] = hover;
              });
            },
            onTap: () {
              if (widget.currentOption.children.isNotEmpty) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              } else if (widget.selectedOptions
                  .any((item) => item.code == widget.currentOption.code)) {
                widget.onOptionSelected([...widget.selectedOptions]
                  ..removeWhere(
                          (item) => item.code == widget.currentOption.code));
              } else {
                if (widget.treeSelectionType == DropdownType.multiSelect) {
                  if (!widget.selectedOptions
                      .any((item) => item.code == widget.currentOption.code)) {
                    widget.onOptionSelected(
                        [...widget.selectedOptions, widget.currentOption]);
                  }
                } else {
                  setState(() {
                    widget.selectedOptions.clear();
                  });
                  widget.onOptionSelected(
                      [...widget.selectedOptions, widget.currentOption]);
                  widget.focusNode.unfocus();
                }
              }
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: widget.hoverStates?[widget.currentOption.code] ==
                            true ||
                            _areAllChildrenSelected(widget.currentOption) &&
                                !_parentSelected(widget.currentOption,
                                    widget.parentNode) &&
                                widget.treeSelectionType ==
                                    DropdownType.multiSelect
                            ? const DigitColors().light.primary1
                            : Colors.transparent,
                      ),
                      color: _calculateBackgroundColor(
                          widget.currentOption, widget.parentNode)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7.5,
                    ),
                    child: Row(
                      children: [
                        Transform.rotate(
                          angle: _isExpanded ? 0 : -pi / 2,
                          alignment: Alignment.center,
                          child: widget.currentOption.children.isNotEmpty
                              ? Icon(
                            Icons.arrow_drop_down,
                            size: spacer6,
                            color: _parentSelected(widget.currentOption,
                                widget.parentNode)
                                ? const DigitColors().light.textSecondary
                                : _areAllChildrenSelected(
                                widget.currentOption) &&
                                widget.treeSelectionType ==
                                    DropdownType.multiSelect
                                ? const DigitColors()
                                .light
                                .paperPrimary
                                : widget.currentOption.children
                                .isNotEmpty
                                ? const DigitColors()
                                .light
                                .textPrimary
                                : const DigitColors()
                                .light
                                .genericDivider,
                          )
                              : const SizedBox(
                            width: spacer6,
                          ),
                        ),
                        const SizedBox(
                          width: spacer1,
                        ),
                        if (widget.treeSelectionType ==
                            DropdownType.multiSelect)
                          InkWell(
                            highlightColor: const DigitColors().transparent,
                            hoverColor: const DigitColors().transparent,
                            splashColor: const DigitColors().transparent,
                            onTap: () {
                              _isSelected =
                                  _areAllChildrenSelected(widget.currentOption);
                              if (_isSelected) {
                                _deselectAllChildren(widget.currentOption);
                              } else {
                                _selectAllChildren(widget.currentOption);
                              }
                              setState(() {
                                _isSelected = _areAllChildrenSelected(
                                    widget.currentOption);
                                _isExpanded = true;/// need to add as configuration
                              });
                            },
                            child: _areAllChildrenSelected(widget.currentOption)
                                ?  DigitCheckboxIcon(
                              //size: spacer5
                              checkboxThemeData: DigitCheckboxThemeData(iconSize: spacer5,
                                selectedIconColor: _parentSelected(widget.currentOption,
                                    widget.parentNode)
                                    ? theme.colorTheme.primary.primary1
                                    : _areAllChildrenSelected(
                                    widget.currentOption)
                                    ? theme.colorTheme.paper.primary
                                    : theme.colorTheme.paper.primary,
                              ),
                              state: DigitCheckboxState.checked,
                              // color: _parentSelected(widget.currentOption,
                              //     widget.parentNode)
                              //     ? const DigitColors()
                              //     .light
                              //     .primary1
                              //     : _areAllChildrenSelected(
                              //     widget.currentOption)
                              //     ? const DigitColors()
                              //     .light
                              //     .paperPrimary
                              //     : const DigitColors()
                              //     .light
                              //     .paperPrimary,
                            )
                                : _isAnyChildSelected(widget.currentOption)
                                ? const DigitCheckboxIcon(
                                //size: spacer5,
                                checkboxThemeData: DigitCheckboxThemeData(iconSize: spacer5,),
                                state: DigitCheckboxState.intermediate)
                                : const DigitCheckboxIcon(
                                //size: spacer5,
                                checkboxThemeData: DigitCheckboxThemeData(iconSize: spacer5,),
                                state: DigitCheckboxState.unchecked),
                          ),
                        if (widget.treeSelectionType ==
                            DropdownType.multiSelect)
                          const SizedBox(
                            width: spacer3,
                          ),
                        Text(
                          capitalizeFirstLetter(widget.currentOption.name),
                          style: _isExpanded ||
                              _areAllChildrenSelected(
                                  widget.currentOption) &&
                                  widget.treeSelectionType ==
                                      DropdownType.multiSelect
                              ? currentTypography.headingS.copyWith(
                            color: _parentSelected(widget.currentOption,
                                widget.parentNode)
                                ? const DigitColors().light.textSecondary
                                : _areAllChildrenSelected(
                                widget.currentOption)
                                ? const DigitColors()
                                .light
                                .paperPrimary
                                : const DigitColors()
                                .light
                                .textSecondary,
                          )
                              : currentTypography.bodyS.copyWith(
                            color: const DigitColors().light.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded && widget.currentOption.children.isNotEmpty)
            Container(
              color: _areAllChildrenSelected(widget.currentOption)
                  ? const DigitColors().light.primary1Bg
                  : const DigitColors().light.paperPrimary,
              child: Padding(
                padding: EdgeInsets.only(left: widget.currentHorPadding),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      left: _areAllChildrenSelected(widget.currentOption)
                          ? BorderSide.none
                          : BorderSide(
                        color: const DigitColors().light.genericDivider,
                        width: 1.0,
                      ),
                      top: BorderSide.none,
                      bottom: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                  child: Column(
                    children: widget.currentOption.children.map((child) {
                      bool isChildSelected =
                      _areAllChildrenSelected(widget.currentOption);
                      return TreeNodeWidget(
                        option: widget.option,
                        parentNode: widget.currentOption,
                        isSelected: isChildSelected,
                        mouseStates: widget.mouseStates,
                        focusNode: widget.focusNode,
                        hoverStates: widget.hoverStates,
                        selectedOptions: widget.selectedOptions,
                        onOptionSelected: widget.onOptionSelected,
                        backgroundColor: const DigitColors().light.paperPrimary,
                        treeSelectionType: widget.treeSelectionType,
                        currentOption: child,
                        currentHorPadding: widget.currentHorPadding + 2,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}