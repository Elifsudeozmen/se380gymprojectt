import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password'.tr(),
          fillColor: const Color.fromARGB(255, 236, 172, 193),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
