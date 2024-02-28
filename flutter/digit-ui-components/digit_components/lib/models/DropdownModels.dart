import 'package:flutter/material.dart';

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.

class DropdownItem {
  final String name;
  final String code;
  final String? type;
  final String? description;
  final IconData? textIcon;
  final String? profileImageUrl;

  const DropdownItem({
    required this.name,
    required this.code,
    this.type,
    this.description,
    this.textIcon,
    this.profileImageUrl,
  });
}
