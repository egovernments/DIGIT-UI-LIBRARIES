import 'package:flutter/material.dart';
import '../atoms/digit_header.dart';

class CustomHeaderMolecule extends StatelessWidget {
  final HeaderType type;
  final String? title;
  final List<Widget>? actions;
  final String? leadingImageUrl;
  final String? trailingImageUrl;

  const CustomHeaderMolecule({
    Key? key,
    this.type = HeaderType.light,
    this.title,
    this.actions,
    this.leadingImageUrl,
    this.trailingImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      type: type,
      actions: [
        // Leading image
        if (leadingImageUrl != null)
          SizedBox(
            height: 32.0,
            child: Image.network(
              leadingImageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        // Title
        if (title != null)
          Expanded(
            child: Text(
              title!,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
        // List of actions
        ...?actions,
        // Trailing image
        if (trailingImageUrl != null)
          SizedBox(
            height: 32.0,
            child: Image.network(
              trailingImageUrl!,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}
