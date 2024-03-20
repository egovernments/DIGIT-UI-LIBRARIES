class ToggleButtonModel {
  final String name;
  final String key;

  /// Callback function when the button is selected
  final void Function(bool value)? onSelected;

  ToggleButtonModel({
    required this.name,
    required this.key,
    this.onSelected,
  });
}
