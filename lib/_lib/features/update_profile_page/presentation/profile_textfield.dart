
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
    return TextField(
      controller: controller,
      keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
      cursorColor: Colors.black,
      inputFormatters:
          isNumberOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.2),
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}


