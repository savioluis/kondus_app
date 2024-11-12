import 'package:flutter/material.dart';
import 'package:kondus/app/app.dart';
import 'package:kondus/app/injections.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(const KondusApp());
}