import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/appbar_avatar.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/day_option.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  DateTime get today => DateTime.now();

  DateTime _dateOfWeek(int weekday) {
    final monday = today.subtract(Duration(days: today.weekday - 1));
    return monday.add(Duration(days: weekday - 1));
  }

  String _weekTitle() {
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));

    return '${_formatDate(monday)} - ${_formatDate(sunday)} Schedule';
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthName(date.month)}';
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
        centerTitle: true,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: AppBarAvatar()),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 WEEK HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _weekTitle(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
