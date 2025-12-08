import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      child: const Icon(Icons.person, size: 50, color: Colors.white),
    );
  }
}
