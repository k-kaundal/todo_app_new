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
    apiKey: 'AIzaSyCgFnBGIkoezYamRtzWUj8uxBV_zYZa5Q0',
    appId: '1:943663349968:web:be4305376c6739ebd31ed5',
    messagingSenderId: '943663349968',
    projectId: 'todo-app-9a002',
    authDomain: 'todo-app-9a002.firebaseapp.com',
    storageBucket: 'todo-app-9a002.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDRFCg0mOkV4q3u0MR042KLd7N93SgY2o',
    appId: '1:943663349968:android:bd144b8cf294a186d31ed5',
    messagingSenderId: '943663349968',
    projectId: 'todo-app-9a002',
    storageBucket: 'todo-app-9a002.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8eQp0kMj3I9vC58jcq5J7E_PRVkvjPlo',
    appId: '1:943663349968:ios:6a09a56c53fe3779d31ed5',
    messagingSenderId: '943663349968',
    projectId: 'todo-app-9a002',
    storageBucket: 'todo-app-9a002.appspot.com',
    iosClientId: '943663349968-2bu81reu83p32js4ndc8endqjr7l4gvq.apps.googleusercontent.com',
    iosBundleId: 'com.widgetshubs.todoAppNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8eQp0kMj3I9vC58jcq5J7E_PRVkvjPlo',
    appId: '1:943663349968:ios:6a09a56c53fe3779d31ed5',
    messagingSenderId: '943663349968',
    projectId: 'todo-app-9a002',
    storageBucket: 'todo-app-9a002.appspot.com',
    iosClientId: '943663349968-2bu81reu83p32js4ndc8endqjr7l4gvq.apps.googleusercontent.com',
    iosBundleId: 'com.widgetshubs.todoAppNew',
  );
}
