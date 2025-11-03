import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/appbar_avatar.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/day_option.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Registration Page'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: AppBarAvatar(),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DayOption(day: 'Monday'),
            DayOption(day: 'Tuesday'),
            DayOption(day: 'Wednesday'),
            DayOption(day: 'Thursday'),
            DayOption(day: 'Friday'),
            DayOption(day: 'Saturday'),
            DayOption(day: 'Sunday'),
          ],
        ),
      ),
    );
  }
}
