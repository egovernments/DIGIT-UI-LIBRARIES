/// Enum representing the possible types of the button.
enum ButtonType {
  primary,
  secondary,
  tertiary,
  link,
}


/// Enum representing different types of single select dropdowns.
enum DropdownType {
  defaultSelect,
  nestedSelect,
}

/// Enum representing different types of multi select dropdowns.
enum SelectionType {
  multiSelect,
  nestedMultiSelect,
}

/// Enum representing different types of multi select dropdowns.
enum TreeSelectionType {
  singleSelect,
  MultiSelect,
}



/// Enum representing the possible states of the DigitCheckbox.
enum DigitCheckboxState {
  /// Represents an unchecked state.
  unchecked,

  /// Represents an intermediate state (partially checked).
  intermediate,

  /// Represents a checked state.
  checked,
}

// Enum representing the scroll for textArea
enum TextAreaScroll{
  vertical,
  smart,
  none,
}