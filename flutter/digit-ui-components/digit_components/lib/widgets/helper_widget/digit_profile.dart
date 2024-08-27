import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_constants.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final Widget? leading;
  final String? description;
  final VoidCallback? onPressed;

  const ProfileWidget({
    super.key,
    required this.title,
    this.leading,
    this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return InkWell(
      highlightColor: const DigitColors().transparent,
      hoverColor: const DigitColors().transparent,
      splashColor: const DigitColors().transparent,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(24),
        color: const DigitColors().light.paperPrimary,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ??
                SvgPicture.asset(
                  Base.profileIconSvg,
                  width: 64,
                  height: 64,
                ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              title,
              style: textTheme.headingS.copyWith(
                color: theme.colorTheme.text.primary,
              ),
            ),
            if (description != null) ...[
              const SizedBox(
                height: 4,
              ),
              Text(
                description!,
                style: textTheme.bodyS.copyWith(
                  color: theme.colorTheme.text.secondary,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
