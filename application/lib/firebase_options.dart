// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBRJgm4K4-ELLdRAY47ib4YvA7l-T3SQ1Q',
    appId: '1:297160251276:web:cab804454946e4aa5aa8a9',
    messagingSenderId: '297160251276',
    projectId: 'jomcamp-8453d',
    authDomain: 'jomcamp-8453d.firebaseapp.com',
    storageBucket: 'jomcamp-8453d.appspot.com',
    measurementId: 'G-7ZPRV7BMX4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIphtkBfmJAj352SUxmRaIqdLWe_6VmXo',
    appId: '1:297160251276:android:59163e288a3197aa5aa8a9',
    messagingSenderId: '297160251276',
    projectId: 'jomcamp-8453d',
    storageBucket: 'jomcamp-8453d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIHEll0SVv8D_qkuqoT25lBspz5HLebFw',
    appId: '1:297160251276:ios:5ecade87959e98a35aa8a9',
    messagingSenderId: '297160251276',
    projectId: 'jomcamp-8453d',
    storageBucket: 'jomcamp-8453d.appspot.com',
    androidClientId: '297160251276-j7sm660806ev7b2kh51sehgti0gnid4h.apps.googleusercontent.com',
    iosClientId: '297160251276-465u6n1qnk1qku9jc8nk1a1mqovbgth7.apps.googleusercontent.com',
    iosBundleId: 'com.example.application',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIHEll0SVv8D_qkuqoT25lBspz5HLebFw',
    appId: '1:297160251276:ios:801b56ee7115eb685aa8a9',
    messagingSenderId: '297160251276',
    projectId: 'jomcamp-8453d',
    storageBucket: 'jomcamp-8453d.appspot.com',
    androidClientId: '297160251276-j7sm660806ev7b2kh51sehgti0gnid4h.apps.googleusercontent.com',
    iosClientId: '297160251276-305uq1tnujb7bc1efrsl10gkbjq4reo6.apps.googleusercontent.com',
    iosBundleId: 'com.example.application.RunnerTests',
  );
}
