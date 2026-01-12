import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'appointment_card.dart';

class AppointmentsList extends StatelessWidget {
  final List<QueryDocumentSnapshot> documents;

  const AppointmentsList({super.key, required this.documents});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return AppointmentCard(data: documents[index]);
      },
    );
  }
}
