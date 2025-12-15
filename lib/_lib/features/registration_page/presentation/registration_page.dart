import 'package:flutter/material.dart';
import 'widgets/day_option.dart';
import 'widgets/appbar_avatar.dart';
import '../../weight_height_page/weight_height_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Registration Page'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: AppBarAvatar(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DayOption(day: 'Monday', date: today),
            DayOption(day: 'Tuesday', date: today.add(const Duration(days: 1))),
            DayOption(day: 'Wednesday', date: today.add(const Duration(days: 2))),
            DayOption(day: 'Thursday', date: today.add(const Duration(days: 3))),
            DayOption(day: 'Friday', date: today.add(const Duration(days: 4))),
            DayOption(day: 'Saturday', date: today.add(const Duration(days: 5))),
            DayOption(day: 'Sunday', date: today.add(const Duration(days: 6))),

            const SizedBox(height: 30),

            // 🔥 CALCULATE YOUR BMI BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WeightHeightPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Calculate Your BMI",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
