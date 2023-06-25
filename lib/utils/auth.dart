import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final Stream<User?> firebaseUser;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      List<String> signInMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      print('Error checking email registration: $e');
      return false;
    }
  }

  Future passwordReset(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return;
  }
}
