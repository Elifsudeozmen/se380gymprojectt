
 
import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/bmi_result_page/business/bmi_calculator.dart';
import 'package:gymproject/_lib/features/bmi_result_page/data/bmi_repository.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/registration_page.dart';
import 'package:gymproject/_lib/features/weight_track_page/weight_track_page.dart';



class BMIResultPage extends StatelessWidget {
  final double height;
  final double weight;

  const BMIResultPage({super.key, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    final bmiRepo = BMIRepository();
    final bmiCalc = BMICalculator();

    final bmiValue = bmiRepo.calculateBMI(height, weight);
    final message = bmiCalc.interpretBMI(bmiValue);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WeightTrackPage()),// aslında height weight sayfasına gitmeli ama çıkmıyor???
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegistrationPage()),
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
              // IMAGE — sen dolduracaksın
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Text(
                  "IMAGE HERE",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 30),

              // MESSAGE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Your BMI: ${bmiValue.toStringAsFixed(1)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
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


