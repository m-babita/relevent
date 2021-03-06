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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBiJh_4HYet-n9Ij6lIjB9e5_cI5odlc0g',
    appId: '1:758168219246:web:3cb2a29948ea49b016407f',
    messagingSenderId: '758168219246',
    projectId: 'relevent-auth',
    authDomain: 'relevent-auth.firebaseapp.com',
    storageBucket: 'relevent-auth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPYO8IjCdOCUOSyMRa1MdcZjj_cwl-7sk',
    appId: '1:758168219246:android:516682b50803e0c716407f',
    messagingSenderId: '758168219246',
    projectId: 'relevent-auth',
    storageBucket: 'relevent-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeGCMQVrTFBUGu2JPV11BL1UM3rIplpbM',
    appId: '1:758168219246:ios:2574adb0f9e7554416407f',
    messagingSenderId: '758168219246',
    projectId: 'relevent-auth',
    storageBucket: 'relevent-auth.appspot.com',
    androidClientId: '758168219246-afjfopjv48mkopv8mm0se57uieegh0af.apps.googleusercontent.com',
    iosClientId: '758168219246-g9lgn3ranpkmkdn5pkfuna1sge8pjfco.apps.googleusercontent.com',
    iosBundleId: 'com.example.relevent',
  );
}
