import 'package:flutter/material.dart';
import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';
import '../../models/TreeModel.dart';
import 'digit_dropdown_input.dart';
import 'digit_multiselect_dropdown.dart';
import 'digit_tree_select_dropdown.dart';

class Dropdown extends StatelessWidget {
  final DropdownType dropdownType;
  final SelectionType dropdownSelectionType;

  final TextEditingController? dropdownController;
  final void Function(DropdownItem)? onSelect;
  final List<DropdownItem> items;
  final IconData? textIcon;
  final IconData suffixIcon;
  final String emptyItemText;
  final bool isSearchable;
  final DropdownItem? selectedOption;
  final bool isDisabled;
  final List<ValueMapper>? valueMapper;
  final String? errorMessage;
  final String? helpText;
  final bool readOnly;

  // MultiSelectDropDown props
  final List<DropdownItem> options;
  final List<DropdownItem> selectedOptions;
  final OnOptionSelect<int>? onOptionSelected;
  final FocusNode? focusNode;
  final String clearAllText;
  final MultiSelectController<int>? controller;
  final List<TreeNode> treeOptions;
  final List<TreeNode> selectedTreeOptions;
  final OnOptionSelected<List<TreeNode>>? onTreeOptionSelected;
  final Decoration? treeInputDecoration;

  const Dropdown({
    Key? key,
    this.dropdownType = DropdownType.singleSelect,
    this.dropdownSelectionType = SelectionType.defaultSelect,
    this.dropdownController,
    this.onSelect,
    this.items = const [],
    this.options = const [],
    this.textIcon,
    this.readOnly = false,
    this.suffixIcon = Icons.arrow_drop_down,
    this.emptyItemText = "No Options available",
    this.isSearchable = true,
    this.selectedOption,
    this.isDisabled = false,
    this.valueMapper,
    this.errorMessage,
    this.helpText,
    // MultiSelectDropDown props
    this.selectedOptions = const [],
    this.onOptionSelected,
    this.focusNode,
    this.controller,
    this.clearAllText = 'Clear All',
    // TreeSelectDropDown props
    this.treeOptions = const [],
    this.selectedTreeOptions = const [],
    this.onTreeOptionSelected,
    this.treeInputDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (dropdownType) {
      case DropdownType.singleSelect:
        return dropdownSelectionType == SelectionType.treeSelect
            ? TreeSelectDropDown(
                treeSelectionType: dropdownType,
                options: treeOptions,
                readOnly: readOnly,
                selectedOptions: selectedTreeOptions,
                onOptionSelected: onTreeOptionSelected,
                suffixIcon: suffixIcon,
                focusNode: focusNode,
                isDisabled: isDisabled,
                clearAllText: clearAllText,
                valueMapper: valueMapper,
                errorMessage: errorMessage,
                helpText: helpText,
                inputDecoration: treeInputDecoration,
              )
            : DigitDropdown(
                dropdownController: dropdownController,
                onSelect: onSelect,
                items: items,
                readOnly: readOnly,
                textIcon: textIcon,
                suffixIcon: suffixIcon,
                emptyItemText: emptyItemText,
                isSearchable: isSearchable,
                selectedOption: selectedOption,
                isDisabled: isDisabled,
                valueMapper: valueMapper,
                errorMessage: errorMessage,
                helpText: helpText,
                selectionType: dropdownSelectionType,
              );
      case DropdownType.multiSelect:
        return dropdownSelectionType == SelectionType.treeSelect
            ? TreeSelectDropDown(
                treeSelectionType: dropdownType,
                options: treeOptions,
                readOnly: readOnly,
                selectedOptions: selectedTreeOptions,
                onOptionSelected: onTreeOptionSelected,
                suffixIcon: suffixIcon,
                focusNode: focusNode,
                isDisabled: isDisabled,
                clearAllText: clearAllText,
                valueMapper: valueMapper,
                errorMessage: errorMessage,
                helpText: helpText,
                inputDecoration: treeInputDecoration,
              )
            : MultiSelectDropDown(
                selectionType: dropdownSelectionType,
                options: options,
                readOnly: readOnly,
                initialOptions: selectedOptions,
                onOptionSelected: onOptionSelected,
                suffixIcon: suffixIcon,
                focusNode: focusNode,
                isDisabled: isDisabled,
                clearAllText: clearAllText,
                valueMapper: valueMapper,
                errorMessage: errorMessage,
                helpText: helpText,
                controller: controller,
                isSearchable: isSearchable,
              );
      default:
        throw Exception('Unsupported dropdown type');
    }
  }
}
