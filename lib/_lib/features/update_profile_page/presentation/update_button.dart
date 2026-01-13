import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UpdateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: textColor, width: 1.4),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        "UPDATE",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
