import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/bmi_record_dto.dart';

class BmiGraphPage extends StatelessWidget {
  final List<BmiRecordDto> records;

  const BmiGraphPage({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Progress")),
      body: records.isEmpty
          ? const Center(child: Text("No BMI data yet"))
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  BmiGraphHeader(),
                  SizedBox(height: 24),
                  Expanded(child: BmiGraphCanvas()),
                ],
              ),
            ),
    );
  }
}

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

class BmiGraphCanvas extends StatelessWidget {
  const BmiGraphCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorWidgetOfExactType<BmiGraphPage>()!;

    return CustomPaint(
      painter: _BmiGraphPainter(page.records),
      child: Container(),
    );
  }
}

class _BmiGraphPainter extends CustomPainter {
  final List<BmiRecordDto> records;

  _BmiGraphPainter(this.records);

  @override
  void paint(Canvas canvas, Size size) {
    if (records.length < 2) return;

    final sorted = List.of(records)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final paintLine = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paintPoint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final minBmi = sorted.map((e) => e.bmi).reduce((a, b) => a < b ? a : b);
    final maxBmi = sorted.map((e) => e.bmi).reduce((a, b) => a > b ? a : b);

    double scaleY(double bmi) {
      return size.height -
          ((bmi - minBmi) / (maxBmi - minBmi)) * size.height;
    }

    final stepX = size.width / (sorted.length - 1);
    final path = Path();

    for (int i = 0; i < sorted.length; i++) {
      final x = i * stepX;
      final y = scaleY(sorted[i].bmi);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 4, paintPoint);
    }

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
