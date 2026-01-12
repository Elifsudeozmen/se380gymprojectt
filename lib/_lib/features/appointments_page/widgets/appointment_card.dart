import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentCard extends StatelessWidget {
  final QueryDocumentSnapshot data;

  const AppointmentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final date = (data['date'] as Timestamp).toDate();
    final timeSlot = data['timeSlot'];

    final formattedDate = "${date.day}/${date.month}/${date.year}";

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(formattedDate),
        subtitle: Text("Time: $timeSlot"),
      ),
    );
  }
}
