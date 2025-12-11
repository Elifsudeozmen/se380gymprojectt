import 'package:flutter/material.dart';

class BmiLabel extends StatelessWidget {
  final String text;
  final Color textColor;

  const BmiLabel({
    super.key,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: textColor.withOpacity(0.85),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
