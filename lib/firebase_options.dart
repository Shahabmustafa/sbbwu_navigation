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
    apiKey: 'AIzaSyDLwtb68bsVL8bcdaXL-9uHvXZcWiwUyoE',
    appId: '1:978230415578:web:7a343a8fe62ffdfd89d5e3',
    messagingSenderId: '978230415578',
    projectId: 'sbbwu-project-5c2aa',
    authDomain: 'sbbwu-project-5c2aa.firebaseapp.com',
    storageBucket: 'sbbwu-project-5c2aa.appspot.com',
    measurementId: 'G-RRMPV69426',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQcXNrX13ft7jLeBSVB0eXYJWRMzfJ9JE',
    appId: '1:978230415578:android:905ca29fcd518e8989d5e3',
    messagingSenderId: '978230415578',
    projectId: 'sbbwu-project-5c2aa',
    storageBucket: 'sbbwu-project-5c2aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGmW4-E0fdML2FPc33iiE0u5XDM2mIMmg',
    appId: '1:978230415578:ios:4c2a17097bd9634189d5e3',
    messagingSenderId: '978230415578',
    projectId: 'sbbwu-project-5c2aa',
    storageBucket: 'sbbwu-project-5c2aa.appspot.com',
    iosBundleId: 'com.example.sbbwuNavigator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGmW4-E0fdML2FPc33iiE0u5XDM2mIMmg',
    appId: '1:978230415578:ios:b03e9af89718e46589d5e3',
    messagingSenderId: '978230415578',
    projectId: 'sbbwu-project-5c2aa',
    storageBucket: 'sbbwu-project-5c2aa.appspot.com',
    iosBundleId: 'com.example.sbbwuNavigator.RunnerTests',
  );
}
