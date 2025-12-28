import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/services/appointment_service.dart';
import '../../data/dto/appointment_dto.dart';

class DayOption extends StatefulWidget {
  final String day;
  final DateTime date;

  const DayOption({super.key, required this.day, required this.date});

  @override
  State<DayOption> createState() => _DayOptionState();
}

class _DayOptionState extends State<DayOption> {
  final AppointmentService service = AppointmentService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isSubmitting = false;

  final List<String> timeOptions = [
    '8:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
    '22:00 - 00:00',
  ];

  /// 🔒 Slot geçmiş mi?
  bool _isPastSlot(DateTime date, String timeSlot) {
    final now = DateTime.now();

    final startHour = int.parse(timeSlot.split(':')[0]);

    final slotDateTime = DateTime(date.year, date.month, date.day, startHour);

    return slotDateTime.isBefore(now);
  }

  Future<String> _getUserGender() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      throw Exception('User data not found');
    }

    final gender = userDoc.data()?['gender'];

    if (gender == null || (gender != 'Male' && gender != 'Female')) {
      throw Exception('Invalid gender data');
    }

    return gender as String;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.day,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: timeOptions.map((time) {
        return StreamBuilder<List<AppointmentDto>>(
          stream: service.getAppointments(widget.date, time),
          builder: (context, snapshot) {
            final list = snapshot.data ?? [];

            final male = list.where((e) => e.gender == 'Male').length;
            final female = list.where((e) => e.gender == 'Female').length;
            final total = list.length;
            final percent = total / AppointmentService.maxCapacity;

            final isPast = _isPastSlot(widget.date, time);
            final isFull = total >= AppointmentService.maxCapacity;

            return ListTile(
              title: Text(time),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('👩 Female: $female   👨 Male: $male'),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(value: percent),
                  const SizedBox(height: 4),
                  Text(
                    '$total / ${AppointmentService.maxCapacity} '
                    '(%${(percent * 100).toStringAsFixed(0)})',
                  ),
                  if (isPast)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        '⏳ This time slot has passed',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                ],
              ),
              trailing: _isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : IconButton(
                      icon: Icon(
                        isPast || isFull
                            ? Icons.lock_outline
                            : Icons.add_circle_outline,
                        color: isPast || isFull ? Colors.grey : null,
                      ),
                      onPressed: (isPast || isFull || _isSubmitting)
                          ? null
                          : () => _showConfirmDialog(time),
                    ),
            );
          },
        );
      }).toList(),
    );
  }

  // 🔹 ONAY DIALOG
  void _showConfirmDialog(String time) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Appointment'),
        content: Text(
          '${widget.day} • $time\n\nAre you sure you want to book this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _createAppointment(time);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  // 🔹 GERÇEK KAYIT
  Future<void> _createAppointment(String time) async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      // 🔥 Gender'ı Firestore'dan çek
      final gender = await _getUserGender();
      final user = FirebaseAuth.instance.currentUser!;

      final appointment = AppointmentDto(
        userId: user.uid,
        gender: gender, // ✅ Artık gerçek gender
        date: widget.date,
        day: widget.day,
        timeSlot: time,
        createdAt: DateTime.now(),
      );

      await service.createAppointment(appointment);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('✅ Appointment created')));
    } catch (e) {
      if (!mounted) return;

      String message = 'Something went wrong';

      if (e.toString().contains('User already has an appointment')) {
        message = '⚠️ You already have an appointment for this time slot';
      } else if (e.toString().contains('Capacity full')) {
        message = '❌ This time slot is full';
      } else if (e.toString().contains('Past appointment')) {
        message = '⏳ You cannot book past time slots';
      } else if (e.toString().contains('User not logged in')) {
        message = '🔒 Please log in first';
      } else if (e.toString().contains('User data not found')) {
        message = '⚠️ User profile not found';
      } else if (e.toString().contains('Invalid gender data')) {
        message = '⚠️ Please update your profile with gender information';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
