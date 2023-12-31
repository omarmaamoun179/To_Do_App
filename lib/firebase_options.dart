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
    apiKey: 'AIzaSyCd0nea1dXGSGRU75cwItPnxEtNVL80s-o',
    appId: '1:591848349069:web:e895c895dce9da5cac71c4',
    messagingSenderId: '591848349069',
    projectId: 'todo-app-a5140',
    authDomain: 'todo-app-a5140.firebaseapp.com',
    storageBucket: 'todo-app-a5140.appspot.com',
    measurementId: 'G-RP8J9NDJN9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhCqyzXoAd9ntydksxdnHkfGk6jFqxLQU',
    appId: '1:591848349069:android:615f36c375fa7e15ac71c4',
    messagingSenderId: '591848349069',
    projectId: 'todo-app-a5140',
    storageBucket: 'todo-app-a5140.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDGj0zWJcj1Fvr0BIK3dCaDvU9clAMsS0',
    appId: '1:591848349069:ios:8f809d5c47d25bdfac71c4',
    messagingSenderId: '591848349069',
    projectId: 'todo-app-a5140',
    storageBucket: 'todo-app-a5140.appspot.com',
    iosClientId: '591848349069-0nv15mgpm3qgnvd8ugjh0l06vrhrid4o.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDGj0zWJcj1Fvr0BIK3dCaDvU9clAMsS0',
    appId: '1:591848349069:ios:b5f1d9eb7fd7d6a8ac71c4',
    messagingSenderId: '591848349069',
    projectId: 'todo-app-a5140',
    storageBucket: 'todo-app-a5140.appspot.com',
    iosClientId: '591848349069-1rr4pdqpv5f6udgm5la4eqikkar9d2q8.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp.RunnerTests',
  );
}
