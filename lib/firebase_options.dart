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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMPcLwvGvuDfIlqn0DVU1hLbXKrmh6i9Y',
    appId: '1:1085475706334:android:c1c0a1e19eafe58e91b94f',
    messagingSenderId: '1085475706334',
    projectId: 'pemdesmekarjaya-838d9',
    storageBucket: 'pemdesmekarjaya-838d9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGIw9vXXP_Bvbfx67ym4vELT6qWo8NSHo',
    appId: '1:1085475706334:ios:5dab17bac260915e91b94f',
    messagingSenderId: '1085475706334',
    projectId: 'pemdesmekarjaya-838d9',
    storageBucket: 'pemdesmekarjaya-838d9.appspot.com',
    androidClientId: '1085475706334-779a2c4qba5reo7ri5n01ds15q3prp36.apps.googleusercontent.com',
    iosClientId: '1085475706334-4vec6t09rsngqnqjqc7frcfnv8nt7v0t.apps.googleusercontent.com',
    iosBundleId: 'com.mekarjaya.pemdesMekarjaya',
  );
}
