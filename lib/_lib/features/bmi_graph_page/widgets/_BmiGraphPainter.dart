import 'package:flutter/material.dart';

class BmiGraphPainter extends CustomPainter {
  final List<double> bmi;
  final List<DateTime> dates;
  final bool isDark;
  final double spacing;

  BmiGraphPainter(this.bmi, this.dates, this.isDark, this.spacing);

  @override
  void paint(Canvas canvas, Size size) {
    if (bmi.isEmpty) return;

    const leftPad = 50.0;
    const bottomPad = 40.0;
    const topPad = 20.0;
    const rightPad = 20.0;

    final width = size.width - leftPad - rightPad;
    final height = size.height - topPad - bottomPad;

    final bg = Paint()..color = isDark ? Colors.black : Colors.white;
    canvas.drawRect(Offset.zero & size, bg);

    final axisPaint = Paint()
      ..color = isDark ? Colors.white70 : Colors.black54
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(leftPad, topPad),
      Offset(leftPad, size.height - bottomPad),
      axisPaint,
    );
    canvas.drawLine(
      Offset(leftPad, size.height - bottomPad),
      Offset(size.width - rightPad, size.height - bottomPad),
      axisPaint,
    );

    final min = bmi.reduce((a, b) => a < b ? a : b);
    final max = bmi.reduce((a, b) => a > b ? a : b);
    final range = (max - min == 0) ? 1 : max - min;

    final labelStyle = TextStyle(
      color: isDark ? Colors.white70 : Colors.black87,
      fontSize: 12,
    );

    for (int i = 0; i <= 5; i++) {
      final value = min + range * i / 5;
      final y = topPad + height * (1 - i / 5);

      final tp = TextPainter(
        text: TextSpan(text: value.toStringAsFixed(1), style: labelStyle),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(leftPad - tp.width - 6, y - tp.height / 2));

      canvas.drawLine(
        Offset(leftPad - 4, y),
        Offset(leftPad, y),
        axisPaint,
      );
    }

    // ---- BMI line ----
    final path = Path();

    for (int i = 0; i < bmi.length; i++) {
      final x = leftPad + i * spacing;
      final y = topPad + (1 - (bmi[i] - min) / range) * height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = Colors.red;
    for (int i = 0; i < bmi.length; i++) {
      final x = leftPad + i * spacing;
      final y = topPad + (1 - (bmi[i] - min) / range) * height;
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }

  final maxLabels = 6;
  final step = (bmi.length / maxLabels).ceil();
  for (int i = 0; i < bmi.length; i++) {
    final x = leftPad + i * spacing;
    final d = dates[i];
    final label = "${d.day}/${d.month}";

    final tp = TextPainter(
    text: TextSpan(text: label, style: labelStyle),
    textDirection: TextDirection.ltr,
  );
  tp.layout();

  tp.paint(
    canvas,
    Offset(x - tp.width / 2, topPad + height + 8), 
  );
}

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
