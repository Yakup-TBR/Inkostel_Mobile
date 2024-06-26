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
    apiKey: 'AIzaSyAihRZOZ5zmyFzHTI7AcnzsO7zJkb6PN98',
    appId: '1:960484760276:web:158bd361af3305739b3941',
    messagingSenderId: '960484760276',
    projectId: 'inkostel-6d01d',
    authDomain: 'inkostel-6d01d.firebaseapp.com',
    storageBucket: 'inkostel-6d01d.appspot.com',
    measurementId: 'G-V0PWBD869P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWqfEhTa9so7WsI7XQXRDoEQoSWrkR_8M',
    appId: '1:960484760276:android:868249f6184acf3f9b3941',
    messagingSenderId: '960484760276',
    projectId: 'inkostel-6d01d',
    storageBucket: 'inkostel-6d01d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnYkrNfVKlYzYDucMGC9ETo5WOT4H7gjk',
    appId: '1:960484760276:ios:6efcc3db95d572379b3941',
    messagingSenderId: '960484760276',
    projectId: 'inkostel-6d01d',
    storageBucket: 'inkostel-6d01d.appspot.com',
    iosBundleId: 'com.example.inkostel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnYkrNfVKlYzYDucMGC9ETo5WOT4H7gjk',
    appId: '1:960484760276:ios:6efcc3db95d572379b3941',
    messagingSenderId: '960484760276',
    projectId: 'inkostel-6d01d',
    storageBucket: 'inkostel-6d01d.appspot.com',
    iosBundleId: 'com.example.inkostel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAihRZOZ5zmyFzHTI7AcnzsO7zJkb6PN98',
    appId: '1:960484760276:web:05a6ebec3d324b039b3941',
    messagingSenderId: '960484760276',
    projectId: 'inkostel-6d01d',
    authDomain: 'inkostel-6d01d.firebaseapp.com',
    storageBucket: 'inkostel-6d01d.appspot.com',
    measurementId: 'G-K3NBM3QM84',
  );
}