import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/data/date_utils.dart';
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
                ],
              ),
              trailing: IconButton(
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_circle_outline),
                onPressed:
                    (_isSubmitting || total >= AppointmentService.maxCapacity)
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

  //
  Future<void> _createAppointment(String time) async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      final appointment = AppointmentDto(
        userId: 'CURRENT_USER_ID', // sonra FirebaseAuth
        gender: 'Female', // sonra Firestore
        date: DateUtilsHelper.normalize(widget.date),
        day: widget.day,
        timeSlot: time,
        createdAt: DateTime.now(),
      );

      await service.createAppointment(appointment);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Appointment created')));
    } catch (e) {
      if (!mounted) return;
      String message = 'Something went wrong';
      if (e.toString().contains('User already has an appointment')) {
        message = '⚠️ You already have an appointment for this time slot';
      } else if (e.toString().contains('Capacity full')) {
        message = '❌ This time slot is full';
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
