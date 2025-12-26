import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../dto/appointment_dto.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const int maxCapacity = 15;

  /// 🔒 Tarihi normalize et (saat/dakika sıfırla)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Stream<List<AppointmentDto>> getAppointments(DateTime date, String timeSlot) {
    final normalizedDate = _normalizeDate(date);

    return _firestore
        .collection('appointments')
        .where('date', isEqualTo: Timestamp.fromDate(normalizedDate))
        .where('timeSlot', isEqualTo: timeSlot)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AppointmentDto.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> createAppointment(AppointmentDto dto) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final userId = user.uid;
    final appointmentsRef = _firestore.collection('appointments');
    final normalizedDate = _normalizeDate(dto.date);

    // 1️⃣ Aynı user aynı slotu almasın
    final userCheck = await appointmentsRef
        .where('userId', isEqualTo: userId)
        .where('date', isEqualTo: Timestamp.fromDate(normalizedDate))
        .where('timeSlot', isEqualTo: dto.timeSlot)
        .limit(1)
        .get();

    if (userCheck.docs.isNotEmpty) {
      throw Exception('User already has an appointment');
    }

    // 2️⃣ Kapasite kontrolü
    final capacityCheck = await appointmentsRef
        .where('date', isEqualTo: Timestamp.fromDate(normalizedDate))
        .where('timeSlot', isEqualTo: dto.timeSlot)
        .get();

    if (capacityCheck.size >= maxCapacity) {
      throw Exception('Capacity full');
    }

    // 3️⃣ Normalize edilmiş ve GÜNCEL userId ile kayıt
    final normalizedDto = dto.copyWith(userId: userId, date: normalizedDate);

    await appointmentsRef.add(normalizedDto.toMap());
  }
}
