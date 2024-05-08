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
///  ...
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyB7hZDyhPfJQaO_KahX9CHHBAv9xAvScD0',
    appId: '1:742647208214:web:227cfeda7b87f7aaee5837',
    messagingSenderId: '742647208214',
    projectId: 'vozclara-f7843',
    authDomain: 'vozclara-f7843.firebaseapp.com',
    storageBucket: 'vozclara-f7843.appspot.com',
    measurementId: 'G-PBQDG6843E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDSKtytqe0XEKpUwn7VZRiZV7huGCfbT4',
    appId: '1:742647208214:android:edc50578098fb81aee5837',
    messagingSenderId: '742647208214',
    projectId: 'vozclara-f7843',
    storageBucket: 'vozclara-f7843.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjzfOuxckWPwU61xQabd2jhTwh6ob1z5A',
    appId: '1:742647208214:ios:2a24c035303ee4b5ee5837',
    messagingSenderId: '742647208214',
    projectId: 'vozclara-f7843',
    storageBucket: 'vozclara-f7843.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjzfOuxckWPwU61xQabd2jhTwh6ob1z5A',
    appId: '1:742647208214:ios:2a24c035303ee4b5ee5837',
    messagingSenderId: '742647208214',
    projectId: 'vozclara-f7843',
    storageBucket: 'vozclara-f7843.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7hZDyhPfJQaO_KahX9CHHBAv9xAvScD0',
    appId: '1:742647208214:web:14b989a2784bfe54ee5837',
    messagingSenderId: '742647208214',
    projectId: 'vozclara-f7843',
    authDomain: 'vozclara-f7843.firebaseapp.com',
    storageBucket: 'vozclara-f7843.appspot.com',
    measurementId: 'G-HNS0JCED5L',
  );
}
