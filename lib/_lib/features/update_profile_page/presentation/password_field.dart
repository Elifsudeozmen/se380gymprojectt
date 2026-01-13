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
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.hintColor;

    return TextField(
      controller: internalController,
      obscureText: _obscure,
      cursorColor: textColor,
      style: TextStyle(fontSize: 16, color: textColor),
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: TextStyle(fontSize: 14, color: hintColor),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: textColor,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textColor, width: 1.2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) internalController.dispose();
    super.dispose();
  }
}
