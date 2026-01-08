import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymproject/_lib/features/weight_height_page/data/bmi_record_dto.dart';

class BmiService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// BMI hesaplama
  double calculateBmi({required double heightCm, required double weightKg}) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  Future<List<BmiRecordDto>> getAllBmiRecords() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final query = await _db
        .collection('users')
        .doc(user.uid)
        .collection('bmi_records')
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs.map((doc) => BmiRecordDto.fromMap(doc.data())).toList();
  }

  /// Hesapla + kaydet
  Future<void> calculateAndSaveBmi({
    required double height,
    required double weight,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final bmi = calculateBmi(heightCm: height, weightKg: weight);

    final record = BmiRecordDto(
      userId: user.uid,
      height: height,
      weight: weight,
      bmi: bmi,
      createdAt: DateTime.now(),
    );

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('bmi_records')
        .add(record.toMap());
  }
}
