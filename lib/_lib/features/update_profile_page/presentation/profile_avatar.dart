import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      radius: 60,
      backgroundColor: theme.colorScheme.surfaceVariant,
      child: Text(
        "Profile",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
