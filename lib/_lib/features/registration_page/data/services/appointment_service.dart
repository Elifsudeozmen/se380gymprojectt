import 'package:cloud_firestore/cloud_firestore.dart';
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
    final appointmentsRef = _firestore.collection('appointments');

    final normalizedDate = _normalizeDate(dto.date);

    // 1️⃣ Aynı user aynı slotu almasın
    final userCheck = await appointmentsRef
        .where('userId', isEqualTo: dto.userId)
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

    // 3️⃣ Normalize edilmiş tarih ile kayıt
    final normalizedDto = dto.copyWith(date: normalizedDate);

    await appointmentsRef.add(normalizedDto.toMap());
  }
}
