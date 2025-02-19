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
    apiKey: 'AIzaSyD1gmcNIVlbBvL0biKM5dpoKuJxCiKsLmA',
    appId: '1:70689439748:web:a82eace2c801d51a25b551',
    messagingSenderId: '70689439748',
    projectId: 'iconic-momentum',
    authDomain: 'iconic-momentum.firebaseapp.com',
    storageBucket: 'iconic-momentum.firebasestorage.app',
    measurementId: 'G-FFQTBL5WN4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHkDRj7JoW-20_Pda2WXTPZLc5mqVP_ZA',
    appId: '1:70689439748:android:d1913943effbfad525b551',
    messagingSenderId: '70689439748',
    projectId: 'iconic-momentum',
    storageBucket: 'iconic-momentum.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2wHukl2w7fuZJDeksbcRMkvsvgi44iOs',
    appId: '1:70689439748:ios:9f9410ac6a85c46225b551',
    messagingSenderId: '70689439748',
    projectId: 'iconic-momentum',
    storageBucket: 'iconic-momentum.firebasestorage.app',
    iosBundleId: 'com.example.iconicMomentum',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2wHukl2w7fuZJDeksbcRMkvsvgi44iOs',
    appId: '1:70689439748:ios:9f9410ac6a85c46225b551',
    messagingSenderId: '70689439748',
    projectId: 'iconic-momentum',
    storageBucket: 'iconic-momentum.firebasestorage.app',
    iosBundleId: 'com.example.iconicMomentum',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD1gmcNIVlbBvL0biKM5dpoKuJxCiKsLmA',
    appId: '1:70689439748:web:0d16ea368dbded5f25b551',
    messagingSenderId: '70689439748',
    projectId: 'iconic-momentum',
    authDomain: 'iconic-momentum.firebaseapp.com',
    storageBucket: 'iconic-momentum.firebasestorage.app',
    measurementId: 'G-F8T55V477T',
  );
}
