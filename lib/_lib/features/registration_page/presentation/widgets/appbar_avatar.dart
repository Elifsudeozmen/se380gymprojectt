import 'package:flutter/material.dart';

class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Colors.black12,
      radius: 17,
      child: Icon(
        Icons.person, 
        color: Colors.black87,
        size: 20,
        ),
    );
  }
}
