import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/bmi_result_page/presentation/bmi_result_page.dart';
import 'package:gymproject/_lib/features/profile_picture_page/profile_picture_page.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/services/bmi_service.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_label.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_input_field.dart';
import 'package:gymproject/_lib/features/weight_height_page/widgets/bmi_calculate_button.dart';
import 'package:gymproject/_lib/features/dark_light_theme/theme_toggle.dart';
import 'package:gymproject/_lib/features/weight_track_page/weight_track_page.dart';
import 'package:provider/provider.dart';
import 'package:gymproject/_lib/theme_notifier.dart';

class WeightHeightPage extends StatefulWidget {
  const WeightHeightPage({super.key});

  @override
  State<WeightHeightPage> createState() => _WeightHeightPageState();
}

class _WeightHeightPageState extends State<WeightHeightPage> {
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
    final background = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).colorScheme.onSurface;

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
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePicturePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            const SizedBox(height: 60),

            BmiLabel(text: "HEIGHT"),
            BmiInputField(controller: heightController),

            const SizedBox(height: 40),

            BmiLabel(text: "WEIGHT"),
            BmiInputField(controller: weightController),

            const SizedBox(height: 70),

            BmiCalculateButton(
              onTap: () async {
                final height = double.tryParse(heightController.text);
                final weight = double.tryParse(weightController.text);

                if (height == null ||
                    weight == null ||
                    height <= 0 ||
                    weight <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid values')),
                  );
                  return;
                }

                await _bmiService.calculateAndSaveBmi(
                  height: height,
                  weight: weight,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        BMIResultPage(height: height, weight: weight),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
