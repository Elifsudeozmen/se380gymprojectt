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
                  .orderBy('date')
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

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Center(
                    child: Text("You have no appointments yet."),
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
