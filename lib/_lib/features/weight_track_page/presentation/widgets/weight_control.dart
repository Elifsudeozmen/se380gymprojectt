import 'package:flutter/material.dart';

class WeightControl extends StatelessWidget {
  final double weight;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const WeightControl({
    Key? key,
    required this.weight,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xff1C1C1C), width: 1.2),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: InkWell(
              onTap: onDecrease,
              child: const Center(
                child: Icon(Icons.remove, size: 24, color: Color(0xff1C1C1C)),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "${weight.toInt()}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1C1C1C)),
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: InkWell(
              onTap: onIncrease,
              child: const Center(
                child: Icon(Icons.add, size: 24, color: Color(0xff1C1C1C)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
