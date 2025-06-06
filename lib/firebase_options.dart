// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDOOZVcNkoU5Vc7dtRF1If1_JXjuiZHw6Q',
    appId: '1:380810622513:web:67a9915067e5e2f10f4710',
    messagingSenderId: '380810622513',
    projectId: 'autoshine-bda4d',
    authDomain: 'autoshine-bda4d.firebaseapp.com',
    storageBucket: 'autoshine-bda4d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDS66qIIGIU7jO8EC7wTE_hlBNiGuiS2Fg',
    appId: '1:380810622513:android:09d5cade20b101880f4710',
    messagingSenderId: '380810622513',
    projectId: 'autoshine-bda4d',
    storageBucket: 'autoshine-bda4d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAu6s2u_2Yhe50NBRs2gUP3p3_x58RbcY0',
    appId: '1:380810622513:ios:2247b8830b4e9cdc0f4710',
    messagingSenderId: '380810622513',
    projectId: 'autoshine-bda4d',
    storageBucket: 'autoshine-bda4d.firebasestorage.app',
    iosBundleId: 'com.example.autoshine',
  );
}
