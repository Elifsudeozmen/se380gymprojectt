import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDarkMode;
  final Color textColor;
  final ValueChanged<bool> onChanged;

  const ThemeToggle({
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
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        const SizedBox(width: 10),
        Switch(
          value: isDarkMode,
          activeThumbColor: Colors.white,
          inactiveThumbColor: Colors.black,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
