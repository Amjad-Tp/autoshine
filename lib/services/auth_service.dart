import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user?.updateDisplayName(name);
    await userCredential.user?.sendEmailVerification();

    return userCredential.user!.uid;
  }

  Future<User?> logIn({required String email, required String password}) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  Future<void> logOut() async => await _auth.signOut();

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
