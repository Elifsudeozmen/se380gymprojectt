import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.hintColor;
    final borderColor = textColor;

    return TextFormField(
      controller: controller,
      cursorColor: textColor,
      style: TextStyle(fontSize: 16, color: textColor),
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(fontSize: 14, color: hintColor),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.2),
        ),
      ),
    );
  }
}
