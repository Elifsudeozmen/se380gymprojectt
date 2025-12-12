import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_picture_page/profile_picture_page.dart';


class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePicturePage()),
        );
      },
      child: const CircleAvatar(
        backgroundColor: Colors.black12,
        radius: 17,
        child: Icon(
          Icons.person,
          color: Colors.black87,
          size: 20,
        ),
      ),
    );
  }
}
