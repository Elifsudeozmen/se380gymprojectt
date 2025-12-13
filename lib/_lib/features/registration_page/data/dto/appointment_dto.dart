import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentDto {
  final String userId;
  final String gender;
  final DateTime date;
  final String day;
  final String timeSlot;
  final DateTime createdAt;

  AppointmentDto({
    required this.userId,
    required this.gender,
    required this.date,
    required this.day,
    required this.timeSlot,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'gender': gender,
      'date': Timestamp.fromDate(date),
      'day': day,
      'timeSlot': timeSlot,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory AppointmentDto.fromMap(Map<String, dynamic> map) {
    return AppointmentDto(
      userId: map['userId'],
      gender: map['gender'],
      date: (map['date'] as Timestamp).toDate(),
      day: map['day'],
      timeSlot: map['timeSlot'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
