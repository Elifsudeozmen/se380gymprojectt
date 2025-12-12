import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback onPressed;   // <-- dışarıdan fonksiyon al

  const UpdateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        side: const BorderSide(color: Colors.black, width: 1.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        "UPDATE",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
