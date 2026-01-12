import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/appointments_header.dart';
import 'widgets/appointments_list.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: const Text("My Appointments")),
      body: Column(
        children: [
          const AppointmentsHeader(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('appointments')
                  .where('userId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                   return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final now = DateTime.now();
                final docs = snapshot.data!.docs.toList();
                docs.removeWhere((doc) {
                  final date = (doc['date'] as Timestamp).toDate();
                  final timeSlot = doc['timeSlot'] as String;
                  final startTime = timeSlot.split('-').first.trim(); 
                  final parts = startTime.split(':');
                  final appointmentDateTime = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    int.parse(parts[0]),
                    int.parse(parts[1]),
                  );
                  return appointmentDateTime.isBefore(now);
                });
                docs.sort((a, b) {
                  final dateA = (a['date'] as Timestamp).toDate();
                  final dateB = (b['date'] as Timestamp).toDate();
                  return dateA.compareTo(dateB); 
                  });

                if (docs.isEmpty) {
                  return const Center(
                    child: Text("No appointments made yet."),
                  );
                }

                return AppointmentsList(documents: docs);
              },
            ),
          ),
        ],
      ),
    );
  }
}
