import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';

Future<void> initializeFirebase() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('✅ Firebase initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      // If Firebase is not configured yet (no google-services files or
      // `flutterfire configure` hasn't been run), this will surface here.
      // The developer should run `dart pub global activate flutterfire_cli`
      // and `flutterfire configure` to generate `firebase_options.dart`.
      print('❌ Firebase initialization error: $e');
    }
  }
}
