/// Enum representing the possible types of the button.
enum ButtonType {
  primary,
  secondary,
  tertiary,
  link,
}

/// Enum representing the possible sizes of the button.
enum ButtonSize {
  large,
  medium,
  small,
}

/// Enum representing the possible type of info buttons
enum InfoButtonType {
  error,
  info,
  success,
  warning,
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

/// Enum representing the scroll for textArea
enum TextAreaScroll{
  vertical,
  smart,
  none,
}

/// Enum representing toast types
enum ToastType {
  success,
  error,
  warning,
}

/// dropdown type and subtype for dropdown wrapper
enum Type {
  singleSelect,
  multiSelect,
}

enum DropdownSubtype {
  defaultSelect,
  nested,
  tree,
}

/// Enum to define different types of information for the InfoCard
enum InfoType { info, success, error, warning }

/// Enum to define different state for timeline
enum TimelineStepState { completed, present, future }