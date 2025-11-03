import 'package:flutter/material.dart';

class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Color.fromARGB(255, 152, 240, 242),
      radius: 17,
      child: Icon(Icons.person, color: Colors.lightGreenAccent),
    );
  }
}
