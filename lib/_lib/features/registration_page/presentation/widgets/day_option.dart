import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymproject/_lib/features/registration_page/presentation/widgets/slot_commentui.dart';

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

  // 🔒 Slot geçmiş mi?
  bool _isPastSlot(DateTime date, String timeSlot) {
    final now = DateTime.now();
    final startHour = int.parse(timeSlot.split(':')[0]);
    final slotDateTime = DateTime(date.year, date.month, date.day, startHour);
    return slotDateTime.isBefore(now);
  }

  String _slotId(DateTime date, String timeSlot) {
    return '${date.toIso8601String()}_$timeSlot';
  }

  Future<String> _getUserGender() async {
    final user = FirebaseAuth.instance.currentUser!;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc['gender'];
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.day,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: timeOptions.map((time) {
        final slotId = _slotId(widget.date, time);

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

            return GestureDetector(
              onTap: () {
                // 💬 Slot'a tıklayınca yorum paneli açılır (her zaman)
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) =>
                      SlotCommentsPanel(date: widget.date, timeRange: time),
                );
              },
              child: StreamBuilder(
                stream: _firestore
                    .collection('timeSlots')
                    .doc(slotId)
                    .collection('comments')
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  final hasComments = snapshot.data?.docs.isNotEmpty ?? false;

                  return Stack(
                    children: [
                      ListTile(
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
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        trailing: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
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
                      ),

                      // 💬 Yorum balonu
                      if (hasComments)
                        const Positioned(
                          top: 8,
                          right: 48,
                          child: Icon(
                            Icons.chat_bubble,
                            size: 18,
                            color: Colors.orange,
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // ======================
  // 🔹 CONFIRM
  // ======================
  void _showConfirmDialog(String time) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Appointment'),
        content: Text('${widget.day} • $time'),
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

  // ======================
  // 🔹 CREATE
  // ======================
  Future<void> _createAppointment(String time) async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      final gender = await _getUserGender();
      final user = FirebaseAuth.instance.currentUser!;

      final appointment = AppointmentDto(
        userId: user.uid,
        gender: gender,
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
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
