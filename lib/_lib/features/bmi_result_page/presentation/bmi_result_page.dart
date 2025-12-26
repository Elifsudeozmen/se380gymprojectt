import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/bmi_result_page/business/bmi_calculator.dart';
import 'package:gymproject/_lib/features/bmi_result_page/data/bmi_repository.dart';
import 'package:gymproject/_lib/features/profile_picture_page/profile_picture_page.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'package:gymproject/_lib/features/weight_height_page/weight_height_page.dart';
import 'package:gymproject/_lib/features/weight_track_page/weight_track_page.dart';

class BMIResultPage extends StatelessWidget {
  final double height;
  final double weight;

  const BMIResultPage({super.key, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.scaffoldBackgroundColor;
    final onBg = theme.colorScheme.onBackground;
    final isDark = theme.brightness == Brightness.dark;

    final bmiRepo = BMIRepository();
    final bmiCalc = BMICalculator();

    final bmiValue = bmiRepo.calculateBMI(height, weight);
    final message = bmiCalc.interpretBMI(bmiValue);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: onBg),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: onBg),
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
            icon: Icon(Icons.person, color: onBg),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // IMAGE PLACEHOLDER
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Image.asset("assets/images/bodymassindex.jpg"),
              ),

              const SizedBox(height: 100),

              // BMI RESULT CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? theme.colorScheme.surface
                      : theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "Your BMI: ${bmiValue.toStringAsFixed(1)}",
                      style: TextStyle(
                        color: isDark
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // TRACK BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WeightTrackPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Track Your Weight",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
