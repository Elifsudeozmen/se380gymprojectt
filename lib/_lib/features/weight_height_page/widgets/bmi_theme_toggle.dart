import 'package:flutter/material.dart';

class BmiThemeToggle extends StatelessWidget {
  final bool isDarkMode;
  final Color textColor;
  final ValueChanged<bool> onChanged;

  const BmiThemeToggle({
    super.key,
    required this.isDarkMode,
    required this.textColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isDarkMode ? "Dark Mode" : "Light Mode",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(width: 10),
        Switch(
          value: isDarkMode,
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.grey.shade700,
          inactiveThumbColor: Colors.black,
          inactiveTrackColor: Colors.grey.shade400,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
