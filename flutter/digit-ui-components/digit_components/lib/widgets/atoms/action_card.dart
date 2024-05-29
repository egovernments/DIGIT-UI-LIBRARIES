import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../enum/app_enums.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../atoms/digit_button.dart';

class ActionItem {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  ActionItem({
    required this.text,
    this.icon,
    this.onTap,
  });
}

class ActionCard extends StatelessWidget {
  final double? width;
  final List<ActionItem> actions;
  final bool isScrollable;

  const ActionCard({
    super.key,
    this.width,
    required this.actions,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    double cardWidth = width ?? (isMobile ? 328 : (isTab ? 500 : 620));

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          width: cardWidth,
          margin: EdgeInsets.symmetric(vertical: isMobile ? 64 : isTab ? 100 : 74),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const DigitColors().light.paperPrimary,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(.16),
                offset: const Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isScrollable)
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildActionButtons(),
                  ),
                )
              else
                _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: actions.asMap().entries.map((action) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: action.key == actions.length - 1 ? 24 : 0,
          ),
          child: Button(
            label: action.value.text,
            size: ButtonSize.large,
            mainAxisSize: MainAxisSize.max,
            type: ButtonType.secondary,
            prefixIcon: action.value.icon,
            isDisabled: action.value.onTap == null,
            onPressed: action.value.onTap != null ? action.value.onTap! : () {},
          ),
        );
      }).toList(),
    );
  }
}
