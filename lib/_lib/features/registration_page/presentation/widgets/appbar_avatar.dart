import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_picture_page/profile_picture_page.dart';

class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePicturePage()),
        );
      },
      child: CircleAvatar(
        radius: 17,
        backgroundColor: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.08),
        child: IconTheme(
          data: Theme.of(context).iconTheme,
          child: const Icon(Icons.person, size: 20),
        ),
      ),
    );
  }
}
