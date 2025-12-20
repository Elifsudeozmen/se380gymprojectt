import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/services/bmi_service.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_label.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_input_field.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_calculate_button.dart';
import 'package:gymproject/_lib/features/dark_light_theme/theme_toggle.dart';

class WeightHeightPage extends StatefulWidget {
  const WeightHeightPage({super.key});

  @override
  State<WeightHeightPage> createState() => _WeightHeightPageState();
}

class _WeightHeightPageState extends State<WeightHeightPage> {
  bool isDarkMode = false;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final BmiService _bmiService = BmiService();

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final background = isDarkMode
        ? const Color(0xFF1B1B1B)
        : const Color(0xFFFAF7F2);
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

            // HEIGHT
            BmiLabel(text: "HEIGHT", textColor: textColor),
            BmiInputField(controller: heightController, isDark: isDarkMode),

            const SizedBox(height: 40),

            // WEIGHT
            BmiLabel(text: "WEIGHT", textColor: textColor),
            BmiInputField(controller: weightController, isDark: isDarkMode),

            const SizedBox(height: 70),

            // CALCULATE BUTTON
            BmiCalculateButton(
              isDark: isDarkMode,
              onTap: () async {
                final height = double.tryParse(heightController.text);
                final weight = double.tryParse(weightController.text);
                print("🔥 CALCULATE BUTTON CLICKED");

                if (height == null ||
                    weight == null ||
                    height <= 0 ||
                    weight <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid values')),
                  );
                  return;
                }

                try {
                  await _bmiService.calculateAndSaveBmi(
                    height: height,
                    weight: weight,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('✅ BMI calculated and saved')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),

            const SizedBox(height: 40),

            // THEME TOGGLE
            ThemeToggle(
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
