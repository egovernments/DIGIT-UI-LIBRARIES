import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../theme/colors.dart';
import '../../theme/spacers.dart';
import '../../utils/utils.dart';

class SelectionBox extends StatefulWidget {
  final double? width;
  final String? errorMessage;
  final List<SelectionOption> options;
  final Function(List<SelectionOption>) onSelectionChanged;
  final bool allowMultipleSelection;

  const SelectionBox({
    Key? key,
    this.width,
    this.errorMessage,
    required this.options,
    required this.onSelectionChanged,
    this.allowMultipleSelection = true, /// Default to allow multiple selection
  }) : super(key: key);

  @override
  _SelectionBoxState createState() => _SelectionBoxState();
}

class _SelectionBoxState extends State<SelectionBox> {
  final List<SelectionOption> _selectedOptions = [];

  void _onOptionTap(SelectionOption option) {
    setState(() {
      if (widget.allowMultipleSelection) {
        if (_selectedOptions.contains(option)) {
          _selectedOptions.remove(option);
        } else {
          _selectedOptions.add(option);
        }
      } else {
        if (_selectedOptions.contains(option)) {
          _selectedOptions.clear();
        } else {
          _selectedOptions.clear();
          _selectedOptions.add(option);
        }
      }
      widget.onSelectionChanged(_selectedOptions);
    });
  }

  Widget _buildOption(SelectionOption option) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final isSelected = _selectedOptions.contains(option);

    return InkWell(
      highlightColor: theme.colorTheme.generic.transparent,
      hoverColor: theme.colorTheme.generic.transparent,
      splashColor: theme.colorTheme.generic.transparent,
      onTap: () => _onOptionTap(option),
      child: Container(
        width: widget.width,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorTheme.primary.primary1
              : theme.colorTheme.paper.primary,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: theme.colorTheme.generic.divider,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (option.prefixIcon != null)
              Icon(
                option.prefixIcon,
                color: isSelected
                    ? theme.colorTheme.paper.primary
                    : theme.colorTheme.text.primary,
              ),
            if (option.prefixIcon != null) const SizedBox(width: 4.0),
            Flexible(
              child: Text(
                option.name,
                overflow: TextOverflow.ellipsis,
                style: isSelected
                    ? textTheme.bodyS.copyWith(
                  color: theme.colorTheme.paper.primary,
                  fontWeight: FontWeight.w700,
                )
                    : textTheme.bodyS.copyWith(
                  color: theme.colorTheme.text.primary,
                ),
              ),
            ),
            if (option.suffixIcon != null) const SizedBox(width: 4.0),
            if (option.suffixIcon != null)
              Icon(
                option.suffixIcon,
                color: isSelected
                    ? theme.colorTheme.paper.primary
                    : theme.colorTheme.text.primary,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorTheme.paper.secondary,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: widget.errorMessage != null
                  ? theme.colorTheme.alert.error
                  : theme.colorTheme.generic.divider,
              width: 1,
            ),
          ),
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            children: widget.options.map(_buildOption).toList(),
          ),
        ),
        const SizedBox(height: 4),
        if (widget.errorMessage != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 2,
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
                  truncateWithEllipsis(256, widget.errorMessage!),
                  style: textTheme.bodyS.copyWith(
                    color: const DigitColors().light.alertError,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class SelectionOption {
  final String name;
  final String code;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  SelectionOption({
    required this.name,
    required this.code,
    this.prefixIcon,
    this.suffixIcon,
  });
}
