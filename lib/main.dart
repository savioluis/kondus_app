import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kondus/app/app.dart';
import 'package:kondus/app/injections.dart';
import 'package:kondus/firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjections();
  runApp(const KondusApp());
}
