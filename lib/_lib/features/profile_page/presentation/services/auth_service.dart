import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String username,
    required String name,
    required String surname,
    required String birthDate,
    required String gender,
    required String height,
    required String weight,
    required String password,
  }) async {
    try {
      var query = await _db
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (query.docs.isNotEmpty) {
        return "Username already exists!";
      }

      await _db.collection('users').add({
        'username': username,
        'name': name,
        'surname': surname,
        'birthDate': birthDate,
        'gender': gender,
        'height': height,
        'weight': weight,
        'password': password,
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
