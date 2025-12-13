import 'package:cloud_firestore/cloud_firestore.dart';
import '../dto/appointment_dto.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const int maxCapacity = 15;

  Stream<List<AppointmentDto>> getAppointments(DateTime date, String timeSlot) {
    return _firestore
        .collection('appointments')
        .where('date', isEqualTo: Timestamp.fromDate(date))
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

    // aynı user aynı slotu almasın
    final userCheck = await appointmentsRef
        .where('userId', isEqualTo: dto.userId)
        .where('date', isEqualTo: Timestamp.fromDate(dto.date))
        .where('timeSlot', isEqualTo: dto.timeSlot)
        .limit(1)
        .get();

    if (userCheck.docs.isNotEmpty) {
      throw Exception('User already has an appointment');
    }

    //kapasite
    final capacityCheck = await appointmentsRef
        .where('date', isEqualTo: Timestamp.fromDate(dto.date))
        .where('timeSlot', isEqualTo: dto.timeSlot)
        .get();

    if (capacityCheck.size >= maxCapacity) {
      throw Exception('Capacity full');
    }

    await appointmentsRef.add(dto.toMap());
  }
}
