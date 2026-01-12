import 'package:flutter/material.dart';
import '_BmiGraphPainter.dart';

class BmiGraphCanvas extends StatelessWidget {
  final List<double> bmi;
  final List<DateTime> dates;
  final bool isDark;

  const BmiGraphCanvas({
    super.key,
    required this.bmi,
    required this.dates,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final graphWidth = bmi.length * 60.0; // 60px per point

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: graphWidth,
        child: CustomPaint(
          painter: BmiGraphPainter(bmi, dates, isDark),
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}
