import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/profile_page/presentation/profile_page.dart';
import 'package:gymproject/_lib/features/update_profile_page/presentation/update_profile_page.dart';
import 'package:gymproject/_lib/features/home_page/services/auth_gate.dart';

class ProfileButtons extends StatelessWidget {
  final Color textColor;

  const ProfileButtons({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfilePage(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: textColor, width: 1.4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 0.5,
                color: textColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildButton(context, "Log Out", textColor),
      ],
    );
  }

  Widget _buildButton(BuildContext context, text, Color textColor) {
    return SizedBox(
      width: 250,
      //log out mantığı fonksiyon onpressed
      child: OutlinedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const AuthGate()),
            (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: textColor, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, letterSpacing: 0.5, color: textColor),
        ),
      ),
    );
  }
}
