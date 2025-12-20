import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/data/date_utils.dart';
import 'day_option.dart';

class WeekView extends StatelessWidget {
  final DateTime weekStart; // pazartesi

  const WeekView({super.key, required this.weekStart});

  DateTime _dateOfWeek(int weekday) {
    return DateUtilsHelper.normalize(
      weekStart.add(Duration(days: weekday - 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 WEEK HEADER
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5DC), // 🎨 BEJ
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                DateUtilsHelper.weekTitle(weekStart),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          DayOption(day: 'Monday', date: _dateOfWeek(1)),
          DayOption(day: 'Tuesday', date: _dateOfWeek(2)),
          DayOption(day: 'Wednesday', date: _dateOfWeek(3)),
          DayOption(day: 'Thursday', date: _dateOfWeek(4)),
          DayOption(day: 'Friday', date: _dateOfWeek(5)),
          DayOption(day: 'Saturday', date: _dateOfWeek(6)),
          DayOption(day: 'Sunday', date: _dateOfWeek(7)),
        ],
      ),
    );
  }
}
