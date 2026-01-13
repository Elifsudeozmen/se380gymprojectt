import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isNumberOnly;

  const ProfileTextField({
    super.key,
    required this.label,
    this.controller,
    this.isNumberOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.hintColor;

    return TextField(
      controller: controller,
      keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNumberOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      cursorColor: textColor,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: hintColor),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textColor, width: 1.2),
        ),
      ),
    );
  }
}
