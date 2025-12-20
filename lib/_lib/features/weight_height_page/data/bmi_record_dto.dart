import 'package:cloud_firestore/cloud_firestore.dart';

class BmiRecordDto {
  final String userId;
  final double height;
  final double weight;
  final double bmi;
  final DateTime createdAt;

  BmiRecordDto({
    required this.userId,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'height': height,
      'weight': weight,
      'bmi': bmi,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory BmiRecordDto.fromMap(Map<String, dynamic> map) {
    return BmiRecordDto(
      userId: map['userId'],
      height: (map['height'] as num).toDouble(),
      weight: (map['weight'] as num).toDouble(),
      bmi: (map['bmi'] as num).toDouble(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
