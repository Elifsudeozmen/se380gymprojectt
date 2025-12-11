import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  final Color textColor;

  const ProfileButtons({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton("Edit Profile", textColor),
        const SizedBox(height: 20),
        _buildButton("Log Out", textColor),
      ],
    );
  }

  Widget _buildButton(String text, Color textColor) {
    return SizedBox(
      width: 250,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: textColor, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0.5,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
