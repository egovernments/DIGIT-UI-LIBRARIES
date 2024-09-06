import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String description;
  final VoidCallback? onTap;

  const MenuCard({
    Key? key,
    required this.icon,
    required this.heading,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: theme.textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: theme.textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
