import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentCard extends StatelessWidget {
  final QueryDocumentSnapshot data;

  const AppointmentCard({super.key, required this.data});
  void _confirmDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Cancel appointment"),
      content: const Text("Are you sure you want to cancel this appointment?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('appointments')
                .doc(data.id)
                .delete();

            Navigator.pop(context);
          },
          child: const Text("Yes", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

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
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _confirmDelete(context);
          },
        ),
      ),
    );
  }
}
