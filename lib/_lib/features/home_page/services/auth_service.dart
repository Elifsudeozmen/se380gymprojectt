import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithControllers({
    required TextEditingController usernameCtrl,
    required TextEditingController passwordCtrl,
  }) async {
    String username = usernameCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if (username.isEmpty || password.isEmpty) {
      return "Please enter username and password!";
    }

    try {
      var query = await _db
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (query.docs.isEmpty) return "User not found!";

      String email = query.docs.first['email'];

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null; // başarılı giriş
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return "Incorrect password!";
      } else if (e.code == 'user-not-found') {
        return "User not found!";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
