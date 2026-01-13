import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.white70 : Colors.grey.shade600;

    return TextField(
      controller: widget.controller,
      obscureText: isObscure,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: hintColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: textColor,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textColor,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textColor,
            width: 1.2,
          ),
        ),
      ),
      cursorColor: textColor,
    );
  }
}
