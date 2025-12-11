import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_label.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_input_field.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_calculate_button.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_theme_toggle.dart';

class BmiInputPage extends StatefulWidget {
  const BmiInputPage({super.key});

  @override
  State<BmiInputPage> createState() => _BmiInputPageState();
}

class _BmiInputPageState extends State<BmiInputPage> {
  bool isDarkMode = false;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final background = isDarkMode ? const Color(0xFF1B1B1B) : const Color(0xFFFAF7F2);
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "BMI Calculator",
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            const SizedBox(height: 60),

            BmiLabel(text: "HEIGHT", textColor: textColor),
            BmiInputField(
              controller: heightController,
              isDark: isDarkMode,
            ),

            const SizedBox(height: 40),

            BmiLabel(text: "WEIGHT", textColor: textColor),
            BmiInputField(
              controller: weightController,
              isDark: isDarkMode,
            ),

            const SizedBox(height: 70),

            BmiCalculateButton(
              isDark: isDarkMode,
              onTap: () {},
            ),

            const SizedBox(height: 40),

            BmiThemeToggle(
              isDarkMode: isDarkMode,
              textColor: textColor,
              onChanged: (value) {
                setState(() => isDarkMode = value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
