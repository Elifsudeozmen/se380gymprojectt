import 'package:flutter/material.dart';

class TrackPanel extends StatelessWidget {
  const TrackPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 241, 241),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xff1C1C1C), width: 1.2),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SizedBox(height: 600), // empty space, scroll
          ],
        ),
      ),
    );
  }
}
