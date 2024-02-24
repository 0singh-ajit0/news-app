import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  factory AuthService() {
    return _singleton;
  }
  AuthService._internal();
  FirebaseAuth get _auth => FirebaseAuth.instance;
  static AuthService get instance => AuthService();

  // get current user
  User? get currentUser {
    return _auth.currentUser;
  }

  // Sign Up
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Save User's phone number in Firebase Firestore
  Future<void> saveUserInfo({
    required String name,
    required String email,
    required String phoneNum,
  }) async {
    if (_auth.currentUser != null) {
      final uid = _auth.currentUser!.uid;
      final db = FirebaseFirestore.instance;
      final user = {
        "id": uid,
        "name": name,
        "email": email,
        "phone": phoneNum,
      };
      await db.collection("users").add(user);
    }
  }

  // Log In
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Log Out
  Future<void> logOut() async {
    if (currentUser != null) {
      await _auth.signOut();
    }
  }
}
