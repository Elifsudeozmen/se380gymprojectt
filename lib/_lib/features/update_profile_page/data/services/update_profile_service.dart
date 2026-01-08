import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 User bilgilerini getir
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) return null;
    return doc.data();
  }

  /// 🔹 User bilgilerini güncelle
  Future<void> updateUserProfile({
    required String username,
    required String name,
    required String surname,
    required String birthDate,
    required String gender,
    required String height,
    required String weight,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _firestore.collection('users').doc(user.uid).update({
      'username': username,
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      'gender': gender,
      'height': height,
      'weight': weight,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
