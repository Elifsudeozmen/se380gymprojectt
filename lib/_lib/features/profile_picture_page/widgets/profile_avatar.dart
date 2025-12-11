import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: isDark ? Colors.white24 : Colors.black12,
        child: Icon(
          Icons.person,
          size: 50,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}
