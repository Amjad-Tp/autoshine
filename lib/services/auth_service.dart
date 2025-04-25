import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //------Sign-Up------
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

  //------Log-In------
  Future<User?> logIn({required String email, required String password}) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  //----------Log out-----------
  Future<void> logOut() async => await _auth.signOut();

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //-----reset password email----
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // // Facebook Sign In
  // Future<User?> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();

  //   if (result.status == LoginStatus.success) {
  //     final OAuthCredential credential = FacebookAuthProvider.credential(
  //       result.accessToken!.token,
  //     );
  //     final userCredential = await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   }

  //   return null;
  // }

  // // Twitter Sign In
  // Future<User?> signInWithTwitter() async {
  //   final twitterLogin = TwitterLogin(
  //     apiKey: 'YOUR_TWITTER_API_KEY',
  //     apiSecretKey: 'YOUR_TWITTER_SECRET_KEY',
  //     redirectURI: 'YOUR_TWITTER_REDIRECT_URI',
  //   );

  //   final authResult = await twitterLogin.login();

  //   if (authResult.status == TwitterLoginStatus.loggedIn) {
  //     final twitterAuthCredential = TwitterAuthProvider.credential(
  //       accessToken: authResult.authToken!,
  //       secret: authResult.authTokenSecret!,
  //     );

  //     final userCredential = await _auth.signInWithCredential(
  //       twitterAuthCredential,
  //     );
  //     return userCredential.user;
  //   }

  //   return null;
  // }
}
