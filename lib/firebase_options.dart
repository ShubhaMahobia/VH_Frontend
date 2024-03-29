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
// / // ...
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
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
    apiKey: 'AIzaSyCXGkyNiSf1D5gO-03rNAxErLQTwhNjV0Y',
    appId: '1:1052472595836:web:cd283984641767e3db40f9',
    messagingSenderId: '1052472595836',
    projectId: 'virtualhospital-e9b10',
    authDomain: 'virtualhospital-e9b10.firebaseapp.com',
    storageBucket: 'virtualhospital-e9b10.appspot.com',
    measurementId: 'G-F1VHYE4865',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYBqGBATE8DHCmBeyu4JcdIFtBODCS8h8',
    appId: '1:1052472595836:android:f9266603882b0903db40f9',
    messagingSenderId: '1052472595836',
    projectId: 'virtualhospital-e9b10',
    storageBucket: 'virtualhospital-e9b10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxj2mKMr1tNY5oKUrJ8WuWl48RJSH8m-s',
    appId: '1:1052472595836:ios:654cf8ce50c4b77cdb40f9',
    messagingSenderId: '1052472595836',
    projectId: 'virtualhospital-e9b10',
    storageBucket: 'virtualhospital-e9b10.appspot.com',
    iosBundleId: 'com.example.virtualHospital',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxj2mKMr1tNY5oKUrJ8WuWl48RJSH8m-s',
    appId: '1:1052472595836:ios:0a7dfd106add12fbdb40f9',
    messagingSenderId: '1052472595836',
    projectId: 'virtualhospital-e9b10',
    storageBucket: 'virtualhospital-e9b10.appspot.com',
    iosBundleId: 'com.example.virtualHospital.RunnerTests',
  );
}
