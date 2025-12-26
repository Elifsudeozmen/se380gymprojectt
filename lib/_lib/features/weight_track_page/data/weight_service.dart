import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../business/weight_model.dart';

class WeightService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<WeightModel> loadUserWeight() async {
    final user = _auth.currentUser!;

    final query = await _db
        .collection('users')
        .doc(user.uid)
        .collection('bmi_records')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      // ilk kez giriyorsa default
      return WeightModel(weight: 70);
    }

    final data = query.docs.first.data();
    return WeightModel(weight: data['weight'].toDouble());
  }

  Future<void> updateWeight(double weight) async {
    final user = _auth.currentUser!;

    await _db.collection('users').doc(user.uid).collection('bmi_records').add({
      'weight': weight,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
