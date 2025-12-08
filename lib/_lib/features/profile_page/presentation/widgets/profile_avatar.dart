import 'package:flutter/material.dart';

// sadece tasarım olacağı için stateful widget yapmaya gerek yok hiçbir değişken (state) yok
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey.shade200,
      child: const Text(
        "Profile",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
