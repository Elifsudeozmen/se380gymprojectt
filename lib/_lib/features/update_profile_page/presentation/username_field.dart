import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.hintColor;

    return TextField(
      controller: controller,
      cursorColor: textColor,
      style: TextStyle(fontSize: 16, color: textColor),
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(fontSize: 14, color: hintColor),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textColor, width: 1.2),
        ),
      ),
    );
  }
}
