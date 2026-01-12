import 'package:flutter/material.dart';

class BmiGraphHeader extends StatelessWidget {
  const BmiGraphHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Your BMI over time",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
