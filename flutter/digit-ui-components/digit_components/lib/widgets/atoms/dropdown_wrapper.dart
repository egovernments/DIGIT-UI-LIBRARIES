import 'package:flutter/material.dart';

import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';
import '../../models/TreeModel.dart';
import '../../models/chipModel.dart';
import 'digit_dropdown_input.dart';
import 'digit_multiselect_dropdown.dart';
import 'digit_tree_select_dropdown.dart';

enum Type {
  singleSelect,
  multiSelect,
}

enum DropdownSubtype {
  defaultSelect,
  nested,
  tree,
}

class Dropdown extends StatelessWidget {
  final Type dropdownType;
  final DropdownSubtype dropdownSubtype;
  final TextEditingController? textEditingController;
  final void Function(String, String)? onChange;
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

  // MultiSelectDropDown props
  final SelectionType selectionType;
  final List<DropdownItem> options;
  final List<DropdownItem> selectedOptions;
  final OnOptionSelect<int>? onOptionSelected;
  final ChipConfig chipConfig;
  final FocusNode? focusNode;
  final String clearAllText;
  final MultiSelectController<int>? controller;

  // TreeSelectDropDown props
  final TreeSelectionType treeSelectionType;
  final List<TreeNode> treeOptions;
  final List<TreeNode> selectedTreeOptions;
  final OnOptionSelected<List<TreeNode>>? onTreeOptionSelected;
  final Decoration? treeInputDecoration;

  const Dropdown({
    Key? key,
    this.dropdownType = Type.singleSelect,
    this.dropdownSubtype = DropdownSubtype.defaultSelect,
    this.textEditingController,
    this.onChange,
    this.items = const [],
    this.options = const [],
    this.textIcon,
    this.suffixIcon = Icons.arrow_drop_down,
    this.emptyItemText = "No Options available",
    this.isSearchable = true,
    this.selectedOption,
    this.isDisabled = false,
    this.valueMapper,
    this.errorMessage,
    this.helpText,
    // MultiSelectDropDown props
    this.selectionType = SelectionType.multiSelect,
    this.selectedOptions = const [],
    this.onOptionSelected,
    this.chipConfig = const ChipConfig(),
    this.focusNode,
    this.controller,
    this.clearAllText = 'Clear All',
    // TreeSelectDropDown props
    this.treeSelectionType = TreeSelectionType.singleSelect,
    this.treeOptions = const [],
    this.selectedTreeOptions = const [],
    this.onTreeOptionSelected,
    this.treeInputDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (dropdownType) {
      case Type.singleSelect:
        return dropdownSubtype == DropdownSubtype.defaultSelect
            ? DigitDropdown(
                textEditingController: textEditingController ?? TextEditingController(),
                onChange: onChange ?? (value, index){},
                items: items,
                textIcon: textIcon,
                suffixIcon: suffixIcon,
                emptyItemText: emptyItemText,
                isSearchable: isSearchable,
                selectedOption: selectedOption,
                isDisabled: isDisabled,
                valueMapper: valueMapper,
                errorMessage: errorMessage,
                helpText: helpText,
              )
            : dropdownSubtype == DropdownSubtype.nested
                ? DigitDropdown(
          textEditingController: textEditingController ?? TextEditingController(),
          onChange: onChange ?? (value, index){},
                    items: items,
                    textIcon: textIcon,
                    suffixIcon: suffixIcon,
                    emptyItemText: emptyItemText,
                    isSearchable: isSearchable,
                    selectedOption: selectedOption,
                    isDisabled: isDisabled,
                    valueMapper: valueMapper,
                    errorMessage: errorMessage,
                    helpText: helpText,
                    dropdownType: DropdownType.nestedSelect,
                  )
                : TreeSelectDropDown(
                    treeSelectionType: TreeSelectionType.singleSelect,
                    options: treeOptions,
                    selectedOptions: selectedTreeOptions,
                    onOptionSelected: onTreeOptionSelected,
                    chipConfig: chipConfig,
                    suffixIcon: suffixIcon,
                    focusNode: focusNode,
                    isDisabled: isDisabled,
                    clearAllText: clearAllText,
                    valueMapper: valueMapper,
                    errorMessage: errorMessage,
                    helpText: helpText,
                    inputDecoration: treeInputDecoration,
                  );
      case Type.multiSelect:
        return dropdownSubtype == DropdownSubtype.defaultSelect
            ? MultiSelectDropDown(
                selectionType: SelectionType.multiSelect,
                options: options,
                selectedOptions: selectedOptions,
                onOptionSelected: onOptionSelected,
                chipConfig: chipConfig,
                suffixIcon: suffixIcon,
                focusNode: focusNode,
                isDisabled: isDisabled,
                clearAllText: clearAllText,
                valueMapper: valueMapper,
                errorMessage: errorMessage,
                helpText: helpText,
                controller: controller,
              )
            : dropdownSubtype == DropdownSubtype.nested
                ? MultiSelectDropDown(
                    selectionType: SelectionType.nestedMultiSelect,
                    options: options,
                    selectedOptions: selectedOptions,
                    onOptionSelected: onOptionSelected,
                    chipConfig: chipConfig,
                    suffixIcon: suffixIcon,
                    focusNode: focusNode,
                    isDisabled: isDisabled,
                    clearAllText: clearAllText,
                    valueMapper: valueMapper,
                    errorMessage: errorMessage,
                    helpText: helpText,
                    controller: controller,
                  )
                : TreeSelectDropDown(
                    treeSelectionType: TreeSelectionType.MultiSelect,
                    options: treeOptions,
                    selectedOptions: selectedTreeOptions,
                    onOptionSelected: onTreeOptionSelected,
                    chipConfig: chipConfig,
                    suffixIcon: suffixIcon,
                    focusNode: focusNode,
                    isDisabled: isDisabled,
                    clearAllText: clearAllText,
                    valueMapper: valueMapper,
                    errorMessage: errorMessage,
                    helpText: helpText,
                    inputDecoration: treeInputDecoration,
                  );
      default:
        throw Exception('Unsupported dropdown type');
    }
  }
}
