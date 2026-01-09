import 'package:cloud_firestore/cloud_firestore.dart';

class SlotComment {
  final String userId;
  final String userName;
  final String text;
  final DateTime createdAt;

  SlotComment({
    required this.userId,
    required this.userName,
    required this.text,
    required this.createdAt,
  });

  factory SlotComment.fromMap(Map<String, dynamic> map) {
    return SlotComment(
      userId: map['userId'],
      userName: map['userName'],
      text: map['text'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
