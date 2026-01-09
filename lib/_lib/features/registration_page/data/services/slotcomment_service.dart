import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymproject/_lib/features/registration_page/data/dto/slotcomment.dart';
import 'package:gymproject/_lib/features/registration_page/data/date_utils.dart';

class SlotCommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _buildSlotId(DateTime date, String timeRange) {
    return DateUtilsHelper.buildSlotId(date, timeRange);
  }

  Stream<List<SlotComment>> getComments({
    required DateTime date,
    required String timeRange,
  }) {
    final slotId = _buildSlotId(date, timeRange);

    return _firestore
        .collection('timeSlots')
        .doc(slotId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => SlotComment.fromMap(d.data())).toList());
  }

  Future<void> addComment({
    required DateTime date,
    required String timeRange,
    required String text,
  }) async {
    final user = FirebaseAuth.instance.currentUser!;
    final slotId = _buildSlotId(date, timeRange);

    final slotRef = _firestore.collection('timeSlots').doc(slotId);

    // 🔥 Slot yoksa oluştur
    await slotRef.set({
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // 🔥 Kullanıcının gerçek ismini çek
    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    final userName = userDoc.data()?['name'] ?? 'User';

    await slotRef.collection('comments').add({
      'userId': user.uid,
      'userName': userName, // 🔥 artık gerçek isim
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
