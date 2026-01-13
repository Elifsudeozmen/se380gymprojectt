import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const ProfileTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.white70 : Colors.grey.shade600;
    final borderColor = textColor;

    return TextField(
      controller: controller,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: hintColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 1.2,
          ),
        ),
      ),
      cursorColor: textColor,
    );
  }
}
