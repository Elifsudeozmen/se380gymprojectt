import 'package:flutter/material.dart';
import 'widgets/bmi_graph_header.dart';
import 'widgets/BmiGraphCanvas.dart';

class BmiGraphPage extends StatelessWidget {
  final List<double> bmi;
  final List<DateTime> dates;

  const BmiGraphPage({
    super.key,
    required this.bmi,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("BMI Progress")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BmiGraphHeader(),
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              child: BmiGraphCanvas(
                bmi: bmi,
                dates: dates,
               isDark: isDark,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
