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
    if (user == null) throw Exception("User not logged in");

    final userId = user.uid;
    final normalizedDate = _normalizeDate(dto.date);

    final slotId = '${normalizedDate.toIso8601String()}_${dto.timeSlot}';

    final slotRef = _firestore.collection('timeSlots').doc(slotId);
    final appointmentRef = _firestore.collection('appointments').doc();

    await _firestore.runTransaction((transaction) async {
      // 1️⃣ Slot dokümanını oku
      final slotSnapshot = await transaction.get(slotRef);

      int currentCount = 0;

      if (slotSnapshot.exists) {
        currentCount = slotSnapshot.get('currentCount');
      }

      // 2️⃣ Kapasite kontrolü (ATOMIC)
      if (currentCount >= maxCapacity) {
        throw Exception('Capacity full');
      }

      // 3️⃣ Aynı user aynı slotu almış mı?
      final userQuery = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .where('date', isEqualTo: Timestamp.fromDate(normalizedDate))
          .where('timeSlot', isEqualTo: dto.timeSlot)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        throw Exception('User already has an appointment');
      }

      // 4️⃣ Slot counter artır
      transaction.set(slotRef, {
        'date': Timestamp.fromDate(normalizedDate),
        'timeSlot': dto.timeSlot,
        'currentCount': currentCount + 1,
      }, SetOptions(merge: true));

      // 5️⃣ Appointment ekle
      final normalizedDto = dto.copyWith(userId: userId, date: normalizedDate);

      transaction.set(appointmentRef, normalizedDto.toMap());
    });
  }
}
