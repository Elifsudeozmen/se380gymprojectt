import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BmiInputField extends StatelessWidget {
  final TextEditingController controller;

  const BmiInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final fillColor = isDark
        ? const Color(0xFF2A2A2A)
        : theme.colorScheme.surface;

    final borderColor = theme.colorScheme.outline;
    final textColor = theme.colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1),
      ),
      height: 55,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(color: textColor, fontSize: 17),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "",
                hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
