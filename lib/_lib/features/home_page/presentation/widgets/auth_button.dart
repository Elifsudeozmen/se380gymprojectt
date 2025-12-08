import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/profile_page.dart';

class AuthButtons extends StatelessWidget {
  final VoidCallback onSignIn;

  const AuthButtons({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            //side: const BorderSide(color: Colors.black, width: 1),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
          child: const Text("Sign Up"),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            //side: const BorderSide(color: Colors.black, width: 1),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.black,
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: onSignIn,
          child: const Text("Sign In"),
        ),
      ],
    );
  }
}
