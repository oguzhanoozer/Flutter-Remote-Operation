import 'package:firebase_core/firebase_core.dart';

import 'app_locator.dart';

abstract final class AppInitializer {
  static bool _isFirebaseInited = false;

  static Future<void> init() async {
    await _initFirebase();
    await AppLocator.initControllers();
  }

  static Future<void> _initFirebase() async {
    if (!_isFirebaseInited) {
      await Firebase.initializeApp();
      _isFirebaseInited = true;
    }
  }
}
