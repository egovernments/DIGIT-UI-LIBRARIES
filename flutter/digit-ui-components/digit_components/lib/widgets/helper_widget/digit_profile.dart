import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final Widget? leading;
  final String? description;
  final VoidCallback? onPressed;

  const ProfileWidget({super.key,
    required this.title,
    this.leading,
    this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Container(
      padding: const EdgeInsets.all(24),
      color: const DigitColors().light.paperPrimary,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading ?? Image.asset(Base.profileIconSvg, width: 24, height: 24,),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            title,
            style: textTheme.headingS.copyWith(
              color: theme.colorTheme.text.primary,
            ),
          ),
          const SizedBox(height: 4,),
          if(description!=null)
          Text(
           description!,
            style: textTheme.bodyS.copyWith(
              color: theme.colorTheme.text.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
