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
    apiKey: 'AIzaSyAUB6cu9jZ8IEyRPUSbUx0y06-cNtvg-G4',
    appId: '1:878141978930:web:cd604488dc35832c1dff2b',
    messagingSenderId: '878141978930',
    projectId: 'shopping-a11e7',
    authDomain: 'shopping-a11e7.firebaseapp.com',
    storageBucket: 'shopping-a11e7.firebasestorage.app',
    measurementId: 'G-VNYB47V28C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7xBxkU0PROo7nAhLq1iB7Btn9R4lYso0',
    appId: '1:878141978930:android:543e920255dc22b21dff2b',
    messagingSenderId: '878141978930',
    projectId: 'shopping-a11e7',
    storageBucket: 'shopping-a11e7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0EHrrdmHERt2ytid-Tm7XjOQS0uaf4rg',
    appId: '1:878141978930:ios:81403e04ccdc9a211dff2b',
    messagingSenderId: '878141978930',
    projectId: 'shopping-a11e7',
    storageBucket: 'shopping-a11e7.firebasestorage.app',
    iosBundleId: 'com.example.shoping',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0EHrrdmHERt2ytid-Tm7XjOQS0uaf4rg',
    appId: '1:878141978930:ios:81403e04ccdc9a211dff2b',
    messagingSenderId: '878141978930',
    projectId: 'shopping-a11e7',
    storageBucket: 'shopping-a11e7.firebasestorage.app',
    iosBundleId: 'com.example.shoping',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAUB6cu9jZ8IEyRPUSbUx0y06-cNtvg-G4',
    appId: '1:878141978930:web:f8bcb42d58fb85181dff2b',
    messagingSenderId: '878141978930',
    projectId: 'shopping-a11e7',
    authDomain: 'shopping-a11e7.firebaseapp.com',
    storageBucket: 'shopping-a11e7.firebasestorage.app',
    measurementId: 'G-549GY5WTPH',
  );
}
