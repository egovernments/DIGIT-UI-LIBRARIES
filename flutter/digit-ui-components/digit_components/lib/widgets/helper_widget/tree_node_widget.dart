import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../../models/TreeModel.dart';
import '../atoms/digit_checkbox_icon.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNode option;
  final TreeNode currentOption;
  final bool isSelected;
  final List<TreeNode> selectedOptions;
  final Color backgroundColor;
  final ValueChanged<List<TreeNode>> onOptionSelected;
  final FocusNode focusNode;
  final TreeSelectionType treeSelectionType;
  final double currentHorPadding;

  const TreeNodeWidget({
    Key? key,
    required this.option,
    required this.currentOption,
    required this.isSelected,
    required this.selectedOptions,
    required this.onOptionSelected,
    required this.backgroundColor,
    required this.focusNode,
    required this.treeSelectionType,
    this.currentHorPadding = 10,
  }) : super(key: key);

  @override
  _TreeNodeWidgetState createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool _isExpanded = false;
  bool _isSelected = false;
  bool _isHover = false;
  bool _isMouseDown = false;

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

  bool _selected(TreeNode node) {
    return widget.selectedOptions.any((item) => item.code == node.code);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTapDown: (_) {
            /// Handle mouse down state
            setState(() {
              _isMouseDown = true;
            });
          },
          onTapUp: (_) {
            /// Handle mouse up state
            setState(() {
              _isMouseDown = false;
            });
          },
          splashColor: const DigitColors().transaparent,
          hoverColor: const DigitColors().transaparent,
          onHover: (hover) {
            setState(() {
              _isHover = hover;
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
                ..removeWhere((item) => item.code == widget.currentOption.code));
            } else {
              if (widget.treeSelectionType == TreeSelectionType.MultiSelect) {
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
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:  _isHover || _isMouseDown
                    ? const DigitColors().burningOrange
                    : Colors.transparent,
              ),
              color: (_isMouseDown && _areAllChildrenSelected(widget.currentOption)) || _isSelected
                  ? const DigitColors().burningOrange
                  : _isHover
                  ? const DigitColors().orangeBG
                  : const DigitColors().white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: kPadding*2,),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.rotate(
                        angle: _isExpanded ? 0 : -1.5,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: const DigitColors().woodsmokeBlack,
                        ),
                      ),
                      if (widget.treeSelectionType == TreeSelectionType.MultiSelect) const SizedBox(width: kPadding/2,),
                      if (widget.treeSelectionType == TreeSelectionType.MultiSelect)
                        InkWell(
                          onTap: () {
                            _isSelected = _areAllChildrenSelected(widget.currentOption);
                            if (_isSelected) {
                              _deselectAllChildren(widget.currentOption);
                            } else {
                              _selectAllChildren(widget.currentOption);
                            }
                            setState(() {
                              _isSelected =
                                  _areAllChildrenSelected(widget.currentOption);
                            });
                          },
                          child: _areAllChildrenSelected(widget.currentOption) || _isMouseDown
                              ?  DigitCheckboxIcon(
                            state: CheckboxState.checked,
                            color: const DigitColors().white,
                          )
                              : _isAnyChildSelected(widget.currentOption)
                              ? const DigitCheckboxIcon(
                              state: CheckboxState.intermediate)
                              : const DigitCheckboxIcon(
                              state: CheckboxState.unchecked),
                        ),
                      const SizedBox(
                        width: kPadding,
                      ),
                      Text(
                        widget.currentOption.name,
                        style: DigitTheme.instance.mobileTheme.textTheme.headlineSmall
                            ?.copyWith(
                          color: _isMouseDown || _isSelected ? const DigitColors().white :const DigitColors().davyGray,
                        ),
                      ),
                    ],
                  ),
                  if (_isExpanded && widget.currentOption.children.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(left: widget.currentHorPadding),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: const DigitColors().quillGray,
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
                              isSelected: isChildSelected,
                              focusNode: widget.focusNode,
                              selectedOptions: widget.selectedOptions,
                              onOptionSelected: widget.onOptionSelected,
                              backgroundColor: widget.backgroundColor,
                              treeSelectionType: widget.treeSelectionType,
                              currentOption: child,
                              currentHorPadding: widget.currentHorPadding+2,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
