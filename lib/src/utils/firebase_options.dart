import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../config/app_settings.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return webOptions;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for fuchsia - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions webOptions = FirebaseOptions(
      apiKey: "AIzaSyBRfGMOOmF71GzvekdaCoCthQPbszKp-Sw",
      authDomain: "lockhoodmanagement.firebaseapp.com",
      projectId: "lockhoodmanagement",
      storageBucket: "lockhoodmanagement.appspot.com",
      messagingSenderId: "514494598039",
      appId: "1:514494598039:web:ca0f18485bdbb1083192d2",
      measurementId: "G-YFFQ15CGLT"
    // databaseURL: "https://bakery-delivery-bc6b9-default-rtdb.firebaseio.com",
  );

  static ActionCodeSettings get actionCodeSettings {
    if (kDebugMode) return ActionCodeSettings(url: AppSettings.debugWebUrl);
    return ActionCodeSettings(url: AppSettings.prodWebUrl);
  }
}