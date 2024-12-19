/// Enum representing the possible types of the DigitButton.
enum DigitButtonType {
  primary,
  secondary,
  tertiary,
  link,
}

/// Enum representing the possible sizes of the DigitButton.
enum DigitButtonSize {
  large,
  medium,
  small,
}

/// Enum representing the possible type of info DigitButtons
enum InfoDigitButtonType {
  error,
  info,
  success,
  warning,
}

/// Enum representing different types of multi select dropdowns.
enum SelectionType {
  defaultSelect,
  nestedSelect,
  treeSelect,
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
  info,
}

/// dropdown type and subtype for dropdown wrapper
enum DropdownType {
  singleSelect,
  multiSelect,
}

/// Enum to define different types of information for the InfoCard
enum InfoType { info, success, error, warning }

/// Enum to define different state for timeline
enum TimelineStepState { completed, present, future, failed }

/// Enum representing different types of popup card - default and alert
enum PopUpType {
  simple,
  alert,
}

/// Enum representing different type of divider( small, medium and large)
enum DividerType{
  small,
  medium,
  large,
}

/// Enum representing different orientations of divider
enum DividerOrientation {
  horizontal,
  vertical,
}

/// Enum representing different types of panel(success and error)
enum PanelType {
  success,
  error,
}

/// Enum representing different types of card(primary and secondary)
enum CardType {
  primary,
  secondary,
}