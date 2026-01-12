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
    const pointSpacing = 70.0; 
    final graphWidth = bmi.length * pointSpacing + 80; 

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: graphWidth,
        height: 320,
        child: CustomPaint(
          painter: BmiGraphPainter(bmi, dates, isDark, pointSpacing),
        ),
      ),
    );
  }
}
