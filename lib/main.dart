import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/firebase_options.dart';
import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
