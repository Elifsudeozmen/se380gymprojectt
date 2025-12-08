import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Kullanıcı kaydı
  Future<String?> registerUser({
    required String username,
    required String name,
    required String surname,
    required String birthDate,
    required String gender,
    required String height,
    required String weight,
    required String email,
    required String password,
  }) async {
    try {
      //  Kullanıcı adı benzersizliğini kontrol et
      var query = await _db
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (query.docs.isNotEmpty) {
        return "Username already exists!";
      }

      //  Email + password ile Firebase Auth kaydı
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Firestore’a profil bilgilerini kaydet
      await _db.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'name': name,
        'surname': surname,
        'birthDate': birthDate,
        'gender': gender,
        'height': height,
        'weight': weight,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // kayıt başarılı
    } on FirebaseAuthException catch (e) {
      // Auth hataları (ör: email zaten kayıtlı)
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
