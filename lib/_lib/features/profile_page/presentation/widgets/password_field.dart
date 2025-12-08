
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const PasswordField({super.key, required this.label, this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;
  late final TextEditingController internalController;

  @override
  void initState() {
    super.initState();
    internalController = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: internalController,
      obscureText: _obscure,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
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

  @override
  void dispose() {
    if (widget.controller == null) {
      internalController.dispose();
    }
    super.dispose();
  }
}
