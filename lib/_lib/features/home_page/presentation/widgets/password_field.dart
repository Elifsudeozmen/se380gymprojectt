import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password'.tr(),
          fillColor: const Color.fromARGB(255, 236, 172, 193),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
